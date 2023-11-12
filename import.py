import json
import pymysql
from datetime import datetime

# MySQL数据库配置
db_config = {
    "host": "127.0.0.1",
    "port": 3306,
    "user": "root",
    "password": "root",
    "db": "plat_second_house",
    "charset": "utf8mb4"
}

# 连接数据库
connection = pymysql.connect(**db_config)

try:
    with connection.cursor() as cursor:
        # 打开JSON文件
        with open('lianjia.json', 'r', encoding='utf-8') as file:
            for line in file:
                # 解析JSON数据
                data = json.loads(line)

                # 处理分类信息
                location_parts = data['location'].split()
                first_category, second_category = location_parts[0], location_parts[1]

                # 插入一级分类
                sql_category = "INSERT INTO plat_house_category (category_level, parent_id, category_name) VALUES (%s, %s, %s)"
                cursor.execute(sql_category, (1, 0, first_category))
                first_category_id = cursor.lastrowid

                # 插入二级分类
                cursor.execute(sql_category, (2, first_category_id, second_category))
                second_category_id = cursor.lastrowid

                # 插入三级分类（community）
                cursor.execute(sql_category, (3, second_category_id, data['community']))

                # 插入房屋信息
                sql_house = """INSERT INTO plat_house (validation_code, title, picture, total_price, unit_price,
                                                      community, location, house_type, area, in_area, side,
                                                      decoration, elevator, floor, structure, arch_type, arch_struct,
                                                      elevator_resident, hang_time, last_trade, house_time, mortgage,
                                                      ownership, purpose, property_right, selling_point, type_describe,
                                                      suitable, perimeter, traffic)
                               VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                                       %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""

                # 处理并转换数据
                data['hang_time'] = datetime.strptime(data['hang_time'], '%Y-%m-%d')
                data['last_trade'] = datetime.strptime(data['last_trade'], '%Y-%m-%d')
                insert_house_data = (int(data['validation_code']), data['title'], data['picture'],
                                     float(data['total_price']), float(data['unit_price'].rstrip('元/平米')),
                                     data['community'], data['location'], data['house_type'],
                                     float(data['area'].rstrip('㎡')), None if data['in_area'] == '暂无数据' else float(data['in_area'].rstrip('㎡')),
                                     # ... 其他字段 ...
                                    )

                # 执行房屋信息插入
                cursor.execute(sql_house, insert_house_data)

        # 提交事务
        connection.commit()

finally:
    connection.close()

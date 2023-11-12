// 自动生成模板MallGoodsInfo
package manage

import (
	"main.go/model/common"
)

type HouseInfo struct {
	ValidationCode   int64           `json:"validation_code" gorm:"primarykey;column:validation_code;comment:房源核验码，作为主键"`
	CategoryId       int64           `json:"categoryId" gorm:"column:category_id;comment:用于标识分类信息的字段"`
	Title            string          `json:"title" gorm:"column:title;comment:标题;type:varchar(255)"`
	Picture          string          `json:"picture" gorm:"column:picture;comment:图片地址;type:varchar(255)"`
	TotalPrice       float64         `json:"totalPrice" gorm:"column:total_price;comment:总价;type:double"`
	UnitPrice        float64         `json:"unitPrice" gorm:"column:unit_price;comment:均价;type:double"`
	Community        string          `json:"community" gorm:"column:community;comment:小区名称;type:varchar(100)"`
	Location         string          `json:"location" gorm:"column:location;comment:区域名称;type:varchar(100)"`
	HouseType        string          `json:"houseType" gorm:"column:house_type;comment:户型;type:varchar(50)"`
	Area             float64         `json:"area" gorm:"column:area;comment:建筑面积;type:double"`
	InArea           float64         `json:"inArea" gorm:"column:in_area;comment:套内面积;type:double"`
	Side             string          `json:"side" gorm:"column:side;comment:房屋朝向;type:varchar(50)"`
	Decoration       string          `json:"decoration" gorm:"column:decoration;comment:装修情况;type:varchar(50)"`
	Elevator         string          `json:"elevator" gorm:"column:elevator;comment:配备电梯;type:varchar(50)"`
	Floor            string          `json:"floor" gorm:"column:floor;comment:所在楼层;type:varchar(50)"`
	Structure        string          `json:"structure" gorm:"column:structure;comment:户型结构;type:varchar(50)"`
	ArchType         string          `json:"archType" gorm:"column:arch_type;comment:建筑类型;type:varchar(50)"`
	ArchStruct       string          `json:"archStruct" gorm:"column:arch_struct;comment:建筑结构;type:varchar(50)"`
	ElevatorResident string          `json:"elevatorResident" gorm:"column:elevator_resident;comment:梯户比例;type:varchar(50)"`
	HangTime         common.JSONTime `json:"hangTime" gorm:"column:hang_time;comment:挂牌时间;type:datetime"`
	LastTrade        common.JSONTime `json:"lastTrade" gorm:"column:last_trade;comment:上次交易;type:datetime"`
	HouseTime        string          `json:"houseTime" gorm:"column:house_time;comment:房屋年限;type:varchar(50)"`
	Mortgage         string          `json:"mortgage" gorm:"column:mortgage;comment:抵押信息;type:varchar(50)"`
	Ownership        string          `json:"ownership" gorm:"column:ownership;comment:交易权属;type:varchar(50)"`
	Purpose          string          `json:"purpose" gorm:"column:purpose;comment:房屋用途;type:varchar(50)"`
	PropertyRight    string          `json:"propertyRight" gorm:"column:property_right;comment:产权所属;type:varchar(50)"`
	SellingPoint     string          `json:"sellingPoint" gorm:"column:selling_point;comment:核心卖点;type:text"`
	TypeDescribe     string          `json:"typeDescribe" gorm:"column:type_describe;comment:户型介绍;type:text"`
	Suitable         string          `json:"suitable" gorm:"column:suitable;comment:适宜人群;type:text"`
	Perimeter        string          `json:"perimeter" gorm:"column:perimeter;comment:周边配套;type:text"`
	Traffic          string          `json:"traffic" gorm:"column:traffic;comment:交通出行;type:text"`
}

// TableName HouseInfo 表名
func (HouseInfo) TableName() string {
	return "plat_house"
}

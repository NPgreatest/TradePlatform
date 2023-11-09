package initialize

import (
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"main.go/global"
	"main.go/initialize/internal"
	"os"
)

func GormMysql() (*gorm.DB, error) {
	m := global.GVA_CONFIG.Mysql
	if m.Dbname == "" {
		return nil, os.ErrInvalid
	}
	mysqlConfig := mysql.Config{
		DSN:                       m.Dsn(), // DSN data source name
		DefaultStringSize:         191,     // string 类型字段的默认长度
		SkipInitializeWithVersion: false,   // 根据版本自动配置
	}
	if db, err := gorm.Open(mysql.New(mysqlConfig), internal.Gorm.Config()); err != nil {
		return nil, err
	} else {
		sqlDB, _ := db.DB()
		sqlDB.SetMaxIdleConns(m.MaxIdleConns)
		sqlDB.SetMaxOpenConns(m.MaxOpenConns)
		return db, err
	}
}

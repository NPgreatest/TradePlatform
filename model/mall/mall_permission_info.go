package mall

import "main.go/model/common"

type PermissionInfo struct {
	PermissionID   int             `json:"permission_id" form:"permission_id" gorm:"column:permission_id;comment:权限ID;type:tinyint;"`
	PermissionName string          `json:"permission_name" form:"permission_name" gorm:"column:permission_name;comment:权限名称;type:tinyint;"`
	CreateTime     common.JSONTime `json:"createTime" form:"createTime" gorm:"column:create_time;comment:注册时间;type:datetime"`
}

// TableName MallUser 表名
func (PermissionInfo) TableName() string {
	return "plat_permission_info"
}

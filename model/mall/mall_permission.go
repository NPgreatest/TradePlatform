package mall

import "main.go/model/common"

type Permission struct {
	UserId       int             `json:"user_id" form:"user_id" gorm:"column:user_id;comment:用户id;type:int;"`
	PermissionID int             `json:"permission_id" form:"permission_id" gorm:"column:permission_id;comment:权限ID;type:tinyint;"`
	CreateTime   common.JSONTime `json:"createTime" form:"createTime" gorm:"column:create_time;comment:注册时间;type:datetime"`
}

// TableName MallUser 表名
func (Permission) TableName() string {
	return "plat_permission"
}

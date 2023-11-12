package mall

import "main.go/model/common"

type FavouriteItem struct {
	UserId         int             `json:"user_id" form:"userId" gorm:"column:user_id;comment:用户主键id;type:bigint"`
	ValidationCode int64           `json:"validation_code" gorm:"primarykey;column:validation_code;comment:房源核验码，作为主键"`
	CreateTime     common.JSONTime `json:"createTime" form:"createTime" gorm:"column:create_time;comment:创建时间;type:datetime"`
}

// TableName MallUser 表名
func (FavouriteItem) TableName() string {
	return "plat_favourite"
}

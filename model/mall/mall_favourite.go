package mall

import "main.go/model/common"

type FavouriteItem struct {
	UserId     int             `json:"user_id" form:"userId" gorm:"column:user_id;comment:用户主键id;type:bigint"`
	GoodsId    int             `json:"goodsId" form:"goodsId" gorm:"column:goods_id;comment:关联商品id;type:bigint"`
	CreateTime common.JSONTime `json:"createTime" form:"createTime" gorm:"column:create_time;comment:创建时间;type:datetime"`
}

// TableName MallUser 表名
func (FavouriteItem) TableName() string {
	return "plat_favourite"
}

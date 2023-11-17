package response

import "main.go/model/common"

type FavouriteResponse struct {
	ValidationCode int64           `json:"validation_code"`
	CreateTime     common.JSONTime `json:"createTime" form:"createTime" `
	Title          string          `json:"title"`
	Picture        string          `json:"picture"`
	TotalPrice     float64         `json:"totalPrice"`
	Community      string          `json:"community"`
	HangTime       common.JSONTime `json:"hangTime" gorm:"column:hang_time;comment:挂牌时间;type:datetime"`
	Location       string          `json:"location" gorm:"column:location;comment:区域名称;type:varchar(100)"`
	Purpose        string          `json:"purpose"`
}

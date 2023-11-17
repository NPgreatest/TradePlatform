package response

import "main.go/model/common"

type GoodsSearchResponse struct {
	ValidationCode int64           `json:"validation_code"`
	Title          string          `json:"title"`
	SellingPoint   string          `json:"selling_point"`
	Picture        string          `json:"picture"`
	SellingPrice   float64         `json:"selling_price"`
	HangTime       common.JSONTime `json:"hangTime" gorm:"column:hang_time;comment:挂牌时间;type:datetime"`
	Location       string          `json:"location" gorm:"column:location;comment:区域名称;type:varchar(100)"`
	Community      string          `json:"community" gorm:"column:community;comment:小区名称;type:varchar(100)"`
}

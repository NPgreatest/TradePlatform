package response

import "main.go/model/common"

type FavouriteResponse struct {
	ValidationCode int64           `json:"validation_code"`
	CreateTime     common.JSONTime `json:"createTime" form:"createTime" `
	Title          string          `json:"title"`
	Picture        string          `json:"picture"`
	TotalPrice     float64         `json:"totalPrice"`
	Community      string          `json:"community"`
	Purpose        string          `json:"purpose"`
}

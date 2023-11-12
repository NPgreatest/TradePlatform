package response

import "main.go/model/manage"

type GoodsCategoryResponse struct {
	GoodsCategory manage.HouseCategory `json:"mallGoodsCategory"`
}

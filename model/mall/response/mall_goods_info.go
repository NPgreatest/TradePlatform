package response

type GoodsSearchResponse struct {
	ValidationCode int64   `json:"goodsId"`
	Title          string  `json:"goodsName"`
	SellingPoint   string  `json:"goodsIntro"`
	Picture        string  `json:"goodsCoverImg"`
	SellingPrice   float64 `json:"sellingPrice"`
}

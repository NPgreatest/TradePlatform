package response

type GoodsSearchResponse struct {
	ValidationCode int64   `json:"validation_code"`
	Title          string  `json:"title"`
	SellingPoint   string  `json:"selling_point"`
	Picture        string  `json:"picture"`
	SellingPrice   float64 `json:"selling_price"`
}

package response

type MallIndexConfigGoodsResponse struct {
	ValidationCode int64   `json:"validationCode" `
	Title          string  `json:"title" `
	Purpose        string  `json:"purpose" `
	Picture        string  `json:"picture"`
	TotalPrice     float64 `json:"totalPrice"`
	Community      string  `json:"community" `
}

package manage

type HouseForeCast struct {
	ValidationCode int64   `json:"validation_code" gorm:"primarykey;column:validation_code;comment:房源核验码，作为主键"`
	ForeCast       float64 `json:"forecast" gorm:"column:forecast;comment:预测结果;type:double"`
}

// TableName HouseInfo 表名
func (HouseForeCast) TableName() string {
	return "plat_forecast"
}

package mall

import (
	"main.go/global"
	"main.go/model/mall/response"
	"main.go/model/manage"
)

type MallIndexInfoService struct {
}

// GetConfigGoodsForIndex 首页返回相关IndexConfig
func (m *MallIndexInfoService) GetConfigGoodsForIndex(configType int, num int) (err error, list interface{}) {
	var indexConfigs []manage.HouseIndexConfig
	err = global.GVA_DB.Where("config_type = ?", configType).Where("is_deleted = 0").Order("config_rank desc").Limit(num).Find(&indexConfigs).Error
	if err != nil {
		return
	}
	// 获取商品id
	var ids []int
	for _, indexConfig := range indexConfigs {
		ids = append(ids, indexConfig.GoodsId)
	}
	// 获取商品信息
	var goodsList []manage.HouseInfo
	err = global.GVA_DB.Where("validation_code in ?", ids).Find(&goodsList).Error
	var indexGoodsList []response.MallIndexConfigGoodsResponse
	// 超出30个字符显示....
	for _, indexGoods := range goodsList {
		res := response.MallIndexConfigGoodsResponse{
			ValidationCode: indexGoods.ValidationCode,
			Title:          indexGoods.Title,
			Purpose:        indexGoods.Purpose,
			Picture:        indexGoods.Picture,
			TotalPrice:     indexGoods.TotalPrice,
			Community:      indexGoods.Community,
		}
		indexGoodsList = append(indexGoodsList, res)
	}
	return err, indexGoodsList
}

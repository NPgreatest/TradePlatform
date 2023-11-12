package mall

import (
	"main.go/global"
	mallRes "main.go/model/mall/response"
	"main.go/model/manage"
	"main.go/utils"
)

type MallGoodsInfoService struct {
}

// MallGoodsListBySearch 商品搜索分页
func (m *MallGoodsInfoService) MallGoodsListBySearch(pageSize int, pageNumber int, goodsCategoryId int, keyword string, orderBy string) (err error, searchGoodsList []mallRes.GoodsSearchResponse, total int64) {
	// 根据搜索条件查询
	var goodsList []manage.HouseInfo
	db := global.GVA_DB.Model(&manage.HouseInfo{})
	if keyword != "" {
		keyword_ := "%" + keyword + "%"
		db.Where("title like ? or selling_point like ? or community like ? or location like ? or side like ? or type_describe like ? or suitable like ? or perimeter like ? or traffic like ?",
			keyword_, keyword_, keyword_, keyword_, keyword_, keyword_, keyword_, keyword_, keyword_)
	}
	if goodsCategoryId > 0 {
		db.Where("category_id= ?", goodsCategoryId)
	}
	err = db.Count(&total).Error
	switch orderBy {
	case "new":
		db.Order("hang_time desc")
	case "price":
		db.Order("total_price desc")
	case "unit_price":
		db.Order("unit_price desc")
	default:
		db.Order("validation_code desc")
	}
	limit := pageSize
	offset := pageSize * (pageNumber - 1)
	err = db.Limit(limit).Offset(offset).Find(&goodsList).Error
	// 返回查询结果
	for _, goods := range goodsList {
		searchGoods := mallRes.GoodsSearchResponse{
			ValidationCode: goods.ValidationCode,
			Title:          utils.SubStrLen(goods.Title, 28),
			SellingPoint:   utils.SubStrLen(goods.SellingPoint, 28),
			Picture:        goods.Picture,
			SellingPrice:   goods.TotalPrice,
		}
		searchGoodsList = append(searchGoodsList, searchGoods)
	}
	return
}

// GetMallGoodsInfo 获取商品信息
func (m *MallGoodsInfoService) GetMallGoodsInfo(id int) (err error, res manage.HouseInfo) {
	var mallGoodsInfo manage.HouseInfo
	err = global.GVA_DB.Where("validation_code = ?", id).First(&mallGoodsInfo).Error
	res = mallGoodsInfo
	return
}

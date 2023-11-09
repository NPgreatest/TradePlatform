package mall

import (
	"errors"
	"main.go/global"
	"main.go/model/common"
	"main.go/model/mall"
	mallReq "main.go/model/mall/request"
	"strconv"
	"time"
)

type MallFavouriteService struct {
}

// RegisterUser 注册用户
func (m *MallFavouriteService) GetMyFavourite(token string) (err error, list []interface{}) {
	err = global.GVA_DB.Where("user_id = ?", token).Find(&list).Error
	return err, list

}

func (m *MallFavouriteService) AddFavourite(userID string, req mallReq.AddFavouriteParams) (err error) {
	var total int64
	err = global.GVA_DB.Where("user_id = ? AND goods_id = ?", userID, req.GoodsId).Count(&total).Error
	if err != nil {
		return err
	}
	if total > 0 {
		return errors.New("该物品已收藏")
	}
	userID_, err := strconv.ParseInt(userID, 10, 10)
	return global.GVA_DB.Where("user_id = ?", userID).Create(mall.FavouriteItem{UserId: int(userID_), GoodsId: req.GoodsId, CreateTime: common.JSONTime{Time: time.Now()}}).Error
}

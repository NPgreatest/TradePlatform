package mall

import (
	"errors"
	"main.go/global"
	"main.go/model/common"
	"main.go/model/mall"
	mallReq "main.go/model/mall/request"
	"time"
)

type MallFavouriteService struct {
}

// RegisterUser 注册用户
func (m *MallFavouriteService) GetMyFavourite(userID string) (err error, res []mall.FavouriteItem) {
	var userInfo mall.User
	err = global.GVA_DB.Where("login_name =?", userID).First(&userInfo).Error
	if err != nil {
		return
	}
	err = global.GVA_DB.Where("user_id = ?", userInfo.UserId).Find(&res).Error
	return err, res

}

func (m *MallFavouriteService) AddFavourite(userID string, req mallReq.AddFavouriteParams) (err error) {
	var total int64
	db := global.GVA_DB.Model(&mall.FavouriteItem{})
	err = db.Where("user_id = ? AND validation_code = ?", userID, req.ValidationCode).Count(&total).Error
	if err != nil {
		return err
	}
	if total > 0 {
		return errors.New("该物品已收藏")
	}
	var userInfo mall.User
	err = global.GVA_DB.Where("login_name =?", userID).First(&userInfo).Error
	if err != nil {
		return
	}
	return db.Where("user_id = ?", userID).Create(mall.FavouriteItem{UserId: userInfo.UserId, ValidationCode: req.ValidationCode, CreateTime: common.JSONTime{Time: time.Now()}}).Error
}

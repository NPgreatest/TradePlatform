package mall

import (
	"errors"
	"main.go/global"
	"main.go/model/common"
	"main.go/model/mall"
	mallReq "main.go/model/mall/request"
	mallRes "main.go/model/mall/response"
	"main.go/model/manage"
	"time"
)

type MallFavouriteService struct {
}

// GetMyFavourite 查看我喜欢的列表
func (m *MallFavouriteService) GetMyFavourite(userID string) (err error, res []mallRes.FavouriteResponse) {
	var userInfo mall.User
	err = global.GVA_DB.Where("login_name =?", userID).First(&userInfo).Error
	if err != nil {
		return
	}
	var favourite []mall.FavouriteItem
	err = global.GVA_DB.Where("user_id = ?", userInfo.UserId).Find(&favourite).Error
	for _, v := range favourite {
		var houseItem manage.HouseInfo
		err = global.GVA_DB.Where("validation_code = ?", v.ValidationCode).First(&houseItem).Error
		if err != nil {
			continue
		}
		res = append(res, mallRes.FavouriteResponse{ValidationCode: v.ValidationCode, Title: houseItem.Title, Picture: houseItem.Picture, TotalPrice: houseItem.TotalPrice,
			Community: houseItem.Community, Purpose: houseItem.Purpose, CreateTime: v.CreateTime})
	}
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

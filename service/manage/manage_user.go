package manage

import (
	"main.go/global"
	"main.go/model/mall"
	manageReq "main.go/model/manage/request"
)

type ManageUserService struct {
}

// GetMallUserInfoList 分页获取商城注册用户列表
func (m *ManageUserService) GetMallUserInfoList(info manageReq.MallUserSearch) (err error, list interface{}, total int64) {
	limit := info.PageSize
	offset := info.PageSize * (info.PageNumber - 1)
	// 创建db
	db := global.GVA_DB.Model(&mall.User{})
	var mallUsers []mall.User
	// 如果有条件搜索 下方会自动创建搜索语句
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("create_time desc").Find(&mallUsers).Error
	return err, mallUsers, total
}

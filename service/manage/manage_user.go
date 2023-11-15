package manage

import (
	"fmt"
	"main.go/global"
	"main.go/model/mall"
	manageReq "main.go/model/manage/request"
	manageResponse "main.go/model/manage/response"
)

type ManageUserService struct {
}

// GetMallUserInfoList 分页获取商城注册用户列表
func (m *ManageUserService) GetMallUserInfoList(info manageReq.MallUserSearch) (err error, list []*manageResponse.GetMallUserInfoListResponse, total int64) {
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
	for _, v := range mallUsers {
		var userPermission []mall.Permission
		permissionDB := global.GVA_DB.Model(&mall.Permission{})
		err = permissionDB.Where("user_id = ?", v.UserId).Find(&userPermission).Error
		if err != nil {
			global.GVA_LOG.Error(fmt.Sprintf("获取用户权限失败 %v", err))
			return
		}
		list = append(list, &manageResponse.GetMallUserInfoListResponse{UserId: v.UserId,
			NickName:       v.NickName,
			Email:          v.Email,
			LoginName:      v.LoginName,
			PasswordMd5:    v.PasswordMd5,
			IntroduceSign:  v.IntroduceSign,
			IsDeleted:      v.IsDeleted,
			LockedFlag:     v.LockedFlag,
			CreateTime:     v.CreateTime,
			PermissionList: userPermission})
	}
	return err, list, total
}

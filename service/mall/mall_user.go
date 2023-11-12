package mall

import (
	"errors"
	"fmt"
	"github.com/jinzhu/copier"
	"gorm.io/gorm"
	"main.go/global"
	"main.go/model/common"
	"main.go/model/mall"
	mallReq "main.go/model/mall/request"
	mallRes "main.go/model/mall/response"
	"main.go/utils"
	"time"
)

type MallUserService struct {
}

// RegisterUser 注册用户
func (m *MallUserService) RegisterUser(req mallReq.RegisterUserParam) (err error) {
	if !errors.Is(global.GVA_DB.Where("login_name =?", req.UserName).First(&mall.User{}).Error, gorm.ErrRecordNotFound) {
		return errors.New("存在相同用户名")
	}

	return global.GVA_DB.Create(&mall.User{
		LoginName:     req.UserName,
		PasswordMd5:   utils.MD5V([]byte(req.Password)),
		IntroduceSign: req.IntroduceSign,
		CreateTime:    common.JSONTime{Time: time.Now()},
		NickName:      req.UserName,
		Email:         req.Email}).Error

}

func (m *MallUserService) UpdateUserInfo(userID string, req mallReq.UpdateUserInfoParam) (err error) {
	var userInfo mall.User
	err = global.GVA_DB.Where("login_name =?", userID).First(&userInfo).Error
	if err != nil {
		return errors.New("用户信息获取失败")
	}
	// 若密码为空字符，则表明用户不打算修改密码，使用原密码保存
	if !(req.Password == "") {
		userInfo.PasswordMd5 = utils.MD5V([]byte(req.Password))
	}
	userInfo.NickName = req.NickName
	userInfo.IntroduceSign = req.IntroduceSign
	err = global.GVA_DB.Where("login_name =?", userID).UpdateColumns(&userInfo).Error
	return
}

func (m *MallUserService) GetUserDetail(userID string) (err error, userDetail mallRes.MallUserDetailResponse) {
	var userInfo mall.User
	err = global.GVA_DB.Where("login_name =?", userID).First(&userInfo).Error
	if err != nil {
		return errors.New("用户信息获取失败"), userDetail
	}
	err = copier.Copy(&userDetail, &userInfo)
	return
}

func (m *MallUserService) UserLogin(params mallReq.UserLoginParam) (err error, userToken string) {
	var user mall.User
	err = global.GVA_DB.Where("login_name=? AND password_md5=?", params.UserName, utils.MD5V([]byte(params.Password))).First(&user).Error
	if user != (mall.User{}) {
		userToken, err = utils.CreateToken(params.UserName, time.Hour*24)
		if err != nil {
			fmt.Println(user, err)
			return err, ""
		}
	}
	return
}
func (m *MallUserService) UserResetPassword(userID string, params mallReq.UserResetPasswordParam) (err error) {
	var userInfo mall.User
	err = global.GVA_DB.Where("login_name =?", userID).First(&userInfo).Error
	if err != nil {
		return errors.New("查找用户信息失败")
	}
	// 若密码为空字符，则表明用户不打算修改密码，使用原密码保存
	if !(params.Password == "") {
		userInfo.PasswordMd5 = utils.MD5V([]byte(params.Password))
	}
	userInfo.Email = params.Email
	err = global.GVA_DB.Where("login_name =?", userID).UpdateColumns(&userInfo).Error
	return
}
func (m *MallUserService) PermissionList(userID string) (list []int, err error) {
	var userInfo mall.User
	var userPermission []mall.Permission
	err = global.GVA_DB.Where("login_name =?", userID).First(&userInfo).Error
	if err != nil {
		return nil, errors.New("查找用户信息失败")
	}
	err = global.GVA_DB.Where("user_id =?", userInfo.UserId).Find(&userPermission).Error
	for _, v := range userPermission {
		list = append(list, v.PermissionID)
	}
	return
}

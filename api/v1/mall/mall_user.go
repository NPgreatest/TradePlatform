package mall

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"main.go/global"
	"main.go/model/common/response"
	mallReq "main.go/model/mall/request"
	"main.go/utils"
)

type UserApi struct {
}

func (m *UserApi) UserRegister(c *gin.Context) {
	var req mallReq.RegisterUserParam
	_ = c.ShouldBindJSON(&req)
	if err := utils.Verify(req, utils.MallUserRegisterVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := mallUserService.RegisterUser(req); err != nil {
		global.GVA_LOG.Error("创建失败", zap.Error(err))
		response.FailWithMessage("创建失败:"+err.Error(), c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (m *UserApi) UserInfoUpdate(ctx *gin.Context) {
	var req mallReq.UpdateUserInfoParam
	_ = ctx.ShouldBindJSON(&req)
	userID, _ := utils.VerifyToken(ctx.GetHeader("Authorization"))
	if err := mallUserService.UpdateUserInfo(userID, req); err != nil {
		global.GVA_LOG.Error("更新用户信息失败", zap.Error(err))
		response.FailWithMessage("更新用户信息失败"+err.Error(), ctx)
		return
	}
	response.OkWithMessage("更新成功", ctx)
}

func (m *UserApi) GetUserInfo(ctx *gin.Context) {
	userID, _ := utils.VerifyToken(ctx.GetHeader("Authorization"))
	if err, userDetail := mallUserService.GetUserDetail(userID); err != nil {
		global.GVA_LOG.Error("未查询到记录", zap.Error(err))
		response.FailWithMessage("未查询到记录", ctx)
		return
	} else {
		response.OkWithData(userDetail, ctx)
	}
}

func (m *UserApi) UserLogin(ctx *gin.Context) {
	var req mallReq.UserLoginParam
	_ = ctx.ShouldBindJSON(&req)
	if err, userToken := mallUserService.UserLogin(req); err != nil {
		response.FailWithMessage("登陆失败", ctx)
	} else {
		response.OkWithData(userToken, ctx)
	}
}

func (m *UserApi) UserResetPassword(ctx *gin.Context) {
	var req mallReq.UserResetPasswordParam
	_ = ctx.ShouldBindJSON(&req)
	if err := mallUserService.UserResetPassword(req); err != nil {
		response.FailWithMessage("更新密码失败", ctx)
	} else {
		response.OkWithMessage("更新密码成功", ctx)
	}
}

func (m *UserApi) PermissionList(ctx *gin.Context) {
	userID, _ := utils.VerifyToken(ctx.GetHeader("Authorization"))
	if list, err := mallUserService.PermissionList(userID); err != nil {
		response.FailWithMessage("获取权限失败", ctx)
	} else {
		response.OkWithData(list, ctx)
	}
}

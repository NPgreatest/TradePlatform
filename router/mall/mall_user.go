package mall

import (
	"github.com/gin-gonic/gin"
	v1 "main.go/api/v1"
	"main.go/middleware"
)

type MallUserRouter struct {
}

func (m *MallUserRouter) InitMallUserRouter(Router *gin.RouterGroup) {
	mallUserRouter := Router.Group("v1").Use(middleware.LoginAuthenticationMiddleware())
	userRouter := Router.Group("v1")
	var mallUserApi = v1.ApiGroupApp.MallApiGroup.UserApi
	{
		mallUserRouter.POST("/user/info", mallUserApi.UserInfoUpdate)      //修改用户信息
		mallUserRouter.GET("/user/info", mallUserApi.GetUserInfo)          //获取用户信息
		mallUserRouter.GET("/user/permission", mallUserApi.PermissionList) //获取用户权限列表

	}
	{
		userRouter.POST("/user/register", mallUserApi.UserRegister) //用户注册
		userRouter.POST("/user/login", mallUserApi.UserLogin)       //登陆
	}
}

package mall

import (
	"github.com/gin-gonic/gin"
	v1 "main.go/api/v1"
	"main.go/middleware"
)

type MallUserRouter struct {
}

func (m *MallUserRouter) InitMallUserRouter(Router *gin.RouterGroup) {
	mallUserRouter := Router.Group("users").Use(middleware.LoginAuthenticationMiddleware())
	userRouter := Router.Group("users")
	var mallUserApi = v1.ApiGroupApp.MallApiGroup.MallUserApi
	{
		mallUserRouter.PUT("/info", mallUserApi.UserInfoUpdate)               //修改用户信息
		mallUserRouter.GET("/info", mallUserApi.GetUserInfo)                  //获取用户信息
		mallUserRouter.POST("/reset_password", mallUserApi.UserResetPassword) //重置密码
	}
	{
		userRouter.POST("/register", mallUserApi.UserRegister) //用户注册
		userRouter.POST("/login", mallUserApi.UserLogin)       //登陆
	}

}

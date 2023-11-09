package mall

import (
	"github.com/gin-gonic/gin"
	v1 "main.go/api/v1"
	"main.go/middleware"
)

type MallUserRouter struct {
}

func (m *MallUserRouter) InitMallUserRouter(Router *gin.RouterGroup) {
	mallUserRouter := Router.Group("v1").Use(middleware.UserJWTAuth())
	userRouter := Router.Group("v1")
	var mallUserApi = v1.ApiGroupApp.MallApiGroup.MallUserApi
	{
		mallUserRouter.PUT("/users/info", mallUserApi.UserInfoUpdate)               //修改用户信息
		mallUserRouter.GET("/users/info", mallUserApi.GetUserInfo)                  //获取用户信息
		mallUserRouter.POST("/users/logout", mallUserApi.UserLogout)                //登出
		mallUserRouter.POST("/users/reset_password", mallUserApi.UserResetPassword) //重置密码
	}
	{
		userRouter.POST("/users/register", mallUserApi.UserRegister) //用户注册
		userRouter.POST("/users/login", mallUserApi.UserLogin)       //登陆

	}

}

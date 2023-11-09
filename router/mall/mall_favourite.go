package mall

import (
	"github.com/gin-gonic/gin"
	v1 "main.go/api/v1"
	"main.go/middleware"
)

type MallFavouriteRouter struct {
}

func (m *MallFavouriteRouter) InitMallFavouriteRouter(Router *gin.RouterGroup) {
	mallFavouriteRouter := Router.Group("favourite").Use(middleware.LoginAuthenticationMiddleware())
	var mallFavouriteApi = v1.ApiGroupApp.MallApiGroup.MallFavouriteApi
	{
		mallFavouriteRouter.GET("/get", mallFavouriteApi.GetMyFavourite) //获取用户喜欢列表
		mallFavouriteRouter.POST("/add", mallFavouriteApi.AddFavourite)  //添加用户喜欢列表
	}

}

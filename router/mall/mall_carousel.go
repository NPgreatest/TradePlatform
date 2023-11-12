package mall

import (
	"github.com/gin-gonic/gin"
	v1 "main.go/api/v1"
)

type MallCarouselIndexRouter struct {
}

func (m *MallCarouselIndexRouter) InitMallCarouselIndexRouter(Router *gin.RouterGroup) {
	mallCarouselRouter := Router.Group("v1")
	var mallCarouselApi = v1.ApiGroupApp.MallApiGroup.MallIndexApi
	{
		mallCarouselRouter.GET("recommend", mallCarouselApi.MallIndexInfo) // 获取首页数据
	}
}

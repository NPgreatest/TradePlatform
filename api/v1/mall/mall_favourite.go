package mall

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"main.go/global"
	"main.go/model/common/response"
	mallReq "main.go/model/mall/request"
	"main.go/utils"
)

type MallFavouriteApi struct {
}

// return my facourite list
func (m *MallFavouriteApi) GetMyFavourite(ctx *gin.Context) {
	userID, _ := utils.VerifyToken(ctx.GetHeader("Authorization"))
	err, list := mallFavouriteService.GetMyFavourite(userID)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败"+err.Error(), ctx)
	}
	response.OkWithData(list, ctx)
}

// add shop into my favourite
func (m *MallFavouriteApi) AddFavourite(ctx *gin.Context) {
	userID, _ := utils.VerifyToken(ctx.GetHeader("Authorization"))
	var req mallReq.AddFavouriteParams
	_ = ctx.ShouldBindJSON(&req)
	err := mallFavouriteService.AddFavourite(userID, req)
	if err != nil {
		global.GVA_LOG.Error("添加失败!", zap.Error(err))
		response.FailWithMessage("添加失败"+err.Error(), ctx)
		return
	}
	response.Ok(ctx)
}

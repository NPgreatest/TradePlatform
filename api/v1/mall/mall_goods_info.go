package mall

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"main.go/global"
	"main.go/model/common/response"
	"strconv"
)

type MallGoodsInfoApi struct {
}

// 商品搜索
func (m *MallGoodsInfoApi) GoodsSearch(c *gin.Context) {
	pageSize, _ := strconv.Atoi(c.Query("ps"))
	pageNumber, _ := strconv.Atoi(c.Query("pn"))
	goodsCategoryId, _ := strconv.Atoi(c.Query("category_id"))
	keyword := c.Query("keyword")
	orderBy := c.Query("orderBy")
	if err, list, total := mallGoodsInfoService.MallGoodsListBySearch(pageSize, pageNumber, goodsCategoryId, keyword, orderBy); err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败"+err.Error(), c)
	} else {
		response.OkWithDetailed(response.PageResult{
			List:       list,
			TotalCount: total,
			CurrPage:   pageNumber,
			PageSize:   pageSize,
		}, "获取成功", c)
	}
}

func (m *MallGoodsInfoApi) GoodsDetail(c *gin.Context) {
	id, _ := strconv.Atoi(c.Query("id"))
	err, goodsInfo := mallGoodsInfoService.GetMallGoodsInfo(id)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败"+err.Error(), c)
		return
	}
	response.OkWithData(goodsInfo, c)
}

func (m *MallGoodsInfoApi) GoodsForecast(c *gin.Context) {
	id, _ := strconv.Atoi(c.Query("id"))
	err, goodsInfo := mallGoodsInfoService.GetMallGoodsForeCast(id)
	if err != nil {
		global.GVA_LOG.Error("查询失败!", zap.Error(err))
		response.FailWithMessage("查询失败"+err.Error(), c)
		return
	}
	response.OkWithData(goodsInfo, c)
}

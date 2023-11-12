package middleware

import (
	"github.com/gin-gonic/gin"
	"main.go/model/common/response"
	"main.go/utils"
)

func LoginAuthenticationMiddleware() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		token := ctx.GetHeader("Authorization")
		if token == "" {
			response.FailWithDetailed(nil, "未登录或非法访问", ctx)
			ctx.Abort()
			return
		}

		if _, ok := utils.VerifyToken(token); !ok {
			response.FailWithDetailed(nil, "未登录或非法访问", ctx)
			ctx.Abort()
			return
		}
		ctx.Next()
	}
}

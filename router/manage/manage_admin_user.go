package manage

import (
	"github.com/gin-gonic/gin"
	v1 "main.go/api/v1"
	"main.go/middleware"
)

type ManageAdminUserRouter struct {
}

func (r *ManageAdminUserRouter) InitManageAdminUserRouter(Router *gin.RouterGroup) {
	mallAdminUserRouter := Router.Group("v1").Use(middleware.LoginAuthenticationMiddleware())
	var mallAdminUserApi = v1.ApiGroupApp.ManageApiGroup.ManageAdminUserApi
	{
		mallAdminUserRouter.GET("users", middleware.AuthPermit(3), mallAdminUserApi.UserList)
		mallAdminUserRouter.POST("users/add_permit", middleware.AuthPermit(3), mallAdminUserApi.AdminUserAddPermit) // 添加权限
		mallAdminUserRouter.POST("upload/file", mallAdminUserApi.UploadFile)                                        //上传图片
		mallAdminUserRouter.POST("import", middleware.AuthPermit(4), mallAdminUserApi.ImportDataFromJson)
	}

}

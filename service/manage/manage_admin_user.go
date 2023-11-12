package manage

import (
	"main.go/global"
	"main.go/model/mall"
	manageReq "main.go/model/manage/request"
	"main.go/utils"
	"time"
)

type ManageAdminUserService struct {
}

// AdminUserAddPermit 创建MallAdminUser记录
func (m *ManageAdminUserService) AdminUserAddPermit(addPermit []manageReq.MallAdminAddPermitParam) (err error) {
	for _, v := range addPermit {
		db := global.GVA_DB.Model(&mall.Permission{})
		jsonTime, _ := utils.ParseJSONTime(time.Now().Format("2006-01-02"))
		tmp := mall.Permission{PermissionID: v.PermissionID, UserId: v.UserId, CreateTime: jsonTime}
		err := db.Where("user_id = ?", v.UserId).Create(tmp).Error
		if err != nil {
			return err
		}
	}
	return
}

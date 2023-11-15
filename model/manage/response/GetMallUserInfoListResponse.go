package response

import "main.go/model/common"
import "main.go/model/mall"

type GetMallUserInfoListResponse struct {
	UserId         int               `json:"user_id"`
	NickName       string            `json:"nickName"`
	Email          string            `json:"email" `
	LoginName      string            `json:"loginName"`
	PasswordMd5    string            `json:"passwordMd5"`
	IntroduceSign  string            `json:"introduceSign" `
	IsDeleted      int               `json:"isDeleted"`
	LockedFlag     int               `json:"lockedFlag" `
	CreateTime     common.JSONTime   `json:"createTime"`
	PermissionList []mall.Permission `json:"permission_list" form:"permission_list"`
}

package response

import "main.go/model/common"

type MallUserDetailResponse struct {
	NickName      string          `json:"nickName"`
	Email         string          `json:"email"`
	LoginName     string          `json:"loginName"`
	IntroduceSign string          `json:"introduceSign"`
	CreateTime    common.JSONTime `json:"createTime" `
}

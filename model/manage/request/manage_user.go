package request

import (
	"main.go/model/common/request"
	"main.go/model/mall"
)

type MallUserSearch struct {
	mall.User
	request.PageInfo
}

package manage

import "main.go/service"

type ManageGroup struct {
	ManageAdminUserApi
}

var mallAdminUserService = service.ServiceGroupApp.ManageServiceGroup.ManageAdminUserService
var mallUserService = service.ServiceGroupApp.ManageServiceGroup.ManageUserService
var fileUploadAndDownloadService = service.ServiceGroupApp.ExampleServiceGroup.FileUploadAndDownloadService

package request

type MallAdminAddPermitParam struct {
	UserId       int `json:"user_id" form:"user_id"`
	PermissionID int `json:"permission_id" form:"permission_id" `
}

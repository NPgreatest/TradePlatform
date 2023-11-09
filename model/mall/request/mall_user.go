package request

// 用户注册
type RegisterUserParam struct {
	UserName string `json:"username"`
	Password string `json:"password"`
	Email    string `json:"email"`
	UserType string `json:"user_type"`
}

// 更新用户信息
type UpdateUserInfoParam struct {
	NickName      string `json:"nickName"`
	PasswordMd5   string `json:"passwordMd5"`
	IntroduceSign string `json:"introduceSign"`
}

type UserLoginParam struct {
	UserName string `json:"username"`
	Password string `json:"password"`
	UserType string `json:"user_type"`
}

type UserResetPasswordParam struct {
	Password string `json:"password"`
	Email    string `json:"email"`
}

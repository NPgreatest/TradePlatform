package request

// 用户注册
type RegisterUserParam struct {
	UserName      string `json:"username"`
	Password      string `json:"password"`
	Email         string `json:"email"`
	UserType      string `json:"user_type"`
	IntroduceSign string `json:"introduce_sign"`
}

// 更新用户信息
type UpdateUserInfoParam struct {
	NickName      string `json:"nickName"`
	Password      string `json:"password"`
	IntroduceSign string `json:"introduce_sign"`
}

type UserLoginParam struct {
	UserName string `json:"username"`
	Password string `json:"password"`
}

type UserResetPasswordParam struct {
	Password string `json:"password"`
	Email    string `json:"email"`
}

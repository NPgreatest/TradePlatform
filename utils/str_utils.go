package utils

import (
	"fmt"
	"main.go/model/common"
	"regexp"
	"time"
)

func SubStrLen(str string, length int) string {
	nameRune := []rune(str)
	fmt.Println("string(nameRune[:4]) = ", string(nameRune[:4]))
	if len(str) > length {
		return string(nameRune[:length-1]) + "..."
	}
	return string(nameRune)
}

func RemoveNonNumeric(str string) string {
	re := regexp.MustCompile("[^0-9]+")
	return re.ReplaceAllString(str, "")
}

func ParseJSONTime(str string) (common.JSONTime, error) {
	t, err := time.Parse("2006-01-02", str)
	if err != nil {
		return common.JSONTime{}, err
	}
	return common.JSONTime{Time: t}, nil
}

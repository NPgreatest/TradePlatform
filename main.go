package main

import (
	"fmt"
	"log"
	"main.go/core"
	"main.go/global"
	"main.go/initialize"
	"time"
)

const maxAttempts = 50
const retryDelay = 5 * time.Second

func main() {

	global.GVA_VP = core.Viper() // 初始化Viper
	global.GVA_LOG = core.Zap()  // 初始化zap日志库

	var err error

	// 尝试连接到数据库
	for i := 1; i <= maxAttempts; i++ {
		global.GVA_DB, err = initialize.Gorm() // gorm连接数据库
		if err == nil {
			fmt.Println("Successfully connected to MySQL!")
			break
		} else {
			log.Printf("Failed to connect to MySQL (attempt %d/%d): %v\n", i, maxAttempts, err)
			if i < maxAttempts {
				log.Printf("Retrying in %s...\n", retryDelay)
				time.Sleep(retryDelay)
			} else {
				log.Fatal("Reached maximum number of attempts. Exiting.")
			}
		}
	}

	core.RunWindowsServer()
}

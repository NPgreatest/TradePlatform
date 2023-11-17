package manage

import (
	"encoding/json"
	"github.com/gin-gonic/gin"
	"github.com/jinzhu/copier"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"io/ioutil"
	"main.go/global"
	"main.go/model/common/response"
	"main.go/model/example"
	"main.go/model/manage"
	manageReq "main.go/model/manage/request"
	"main.go/utils"
	"os"
	"strconv"
	"strings"
	"time"
)

type ManageAdminUserApi struct {
}

// AdminUserAddPermit 添加其它用户权限
func (m *ManageAdminUserApi) AdminUserAddPermit(c *gin.Context) {
	var addPermit []manageReq.MallAdminAddPermitParam
	_ = c.ShouldBindJSON(&addPermit)
	if err := mallAdminUserService.AdminUserAddPermit(addPermit); err != nil {
		global.GVA_LOG.Error("添加权限失败", zap.Error(err))
		response.FailWithMessage("添加权限失败", c)
	} else {
		response.Ok(c)
	}
}

// UserList 商城注册用户列表
func (m *ManageAdminUserApi) UserList(c *gin.Context) {
	var pageInfo manageReq.MallUserSearch
	_ = c.ShouldBindQuery(&pageInfo)
	if err, list, total := mallUserService.GetMallUserInfoList(pageInfo); err != nil {
		global.GVA_LOG.Error("获取失败!", zap.Error(err))
		response.FailWithMessage("获取失败", c)
	} else {
		response.OkWithDetailed(response.PageResult{
			List:       list,
			TotalCount: total,
			CurrPage:   pageInfo.PageNumber,
			PageSize:   pageInfo.PageSize,
		}, "获取成功", c)
	}
}

// UploadFile 上传单图
// 此处上传图片的功能可用，但是原前端项目的图片链接为服务器地址，如需要显示图片，需要修改前端指向的图片链接
func (m *ManageAdminUserApi) UploadFile(c *gin.Context) {
	var file example.ExaFileUploadAndDownload
	noSave := c.DefaultQuery("noSave", "0")
	_, header, err := c.Request.FormFile("file")
	if err != nil {
		global.GVA_LOG.Error("接收文件失败!", zap.Error(err))
		response.FailWithMessage("接收文件失败", c)
		return
	}
	err, file = fileUploadAndDownloadService.UploadFile(header, noSave) // 文件上传后拿到文件路径
	if err != nil {
		global.GVA_LOG.Error("修改数据库链接失败!", zap.Error(err))
		response.FailWithMessage("修改数据库链接失败", c)
		return
	}
	//这里直接使用本地的url
	response.OkWithData("http://localhost:8888/"+file.Url, c)
}

// HouseData 定义与JSON结构匹配的结构体
type HouseData struct {
	ValidationCode   string `json:"validation_code"`
	Title            string `json:"title"`
	Picture          string `json:"picture"`
	TotalPrice       string `json:"total_price"`
	UnitPrice        string `json:"unit_price"`
	Community        string `json:"community"`
	Location         string `json:"location"`
	HouseType        string `json:"house_type"`
	Area             string `json:"area"`
	InArea           string `json:"in_area"`
	Side             string `json:"side"`
	Decoration       string `json:"decoration"`
	Elevator         string `json:"elevator"`
	Floor            string `json:"floor"`
	Structure        string `json:"structure"`
	ArchType         string `json:"arch_type"`
	ArchStruct       string `json:"arch_struct"`
	ElevatorResident string `json:"elevator_resident"`
	HangTime         string `json:"hang_time"`
	LastTrade        string `json:"last_trade"`
	HouseTime        string `json:"house_time"`
	Mortgage         string `json:"mortgage"`
	Ownership        string `json:"ownership"`
	Purpose          string `json:"purpose"`
	PropertyRight    string `json:"property_right"`
	SellingPoint     string `json:"selling_point"`
	TypeDescribe     string `json:"type_describe"`
	Suitable         string `json:"suitable"`
	Perimeter        string `json:"perimeter"`
	Traffic          string `json:"traffic"`
}
type pairInt struct {
	meID     int
	parentID int
}

func (m *ManageAdminUserApi) ImportDataFromJson(c *gin.Context) {
	var currentID = 1
	jsonFile, err := os.Open("lianjia.json")
	if err != nil {
		panic(err.Error())
	}
	defer jsonFile.Close()
	index1 := make(map[string]pairInt)
	index2 := make(map[string]pairInt)
	index3 := make(map[string]pairInt)
	byteValue, _ := ioutil.ReadAll(jsonFile)
	fileContent := string(byteValue)
	jsonStrings := strings.Split(fileContent, "},")
	var allInfo []manage.HouseCategory
	err = global.GVA_DB.Find(&allInfo).Error
	if err != nil {
		return
	}
	for _, v := range allInfo {
		if v.CategoryLevel == 1 {
			index1[v.CategoryName] = pairInt{meID: v.CategoryId, parentID: v.ParentId}
		}
		if v.CategoryLevel == 2 {
			index2[v.CategoryName] = pairInt{meID: v.CategoryId, parentID: v.ParentId}
		}
		if v.CategoryLevel == 3 {
			index3[v.CategoryName] = pairInt{meID: v.CategoryId, parentID: v.ParentId}
		}
	}

	for _, jsonString := range jsonStrings {
		jsonString = strings.TrimSpace(jsonString)
		if jsonString == "" {
			continue
		}
		if !strings.HasSuffix(jsonString, "}") {
			jsonString += "}"
		}
		var rawData HouseData
		var data manage.HouseInfo
		json.Unmarshal([]byte(jsonString), &rawData)
		rawData.ValidationCode = utils.RemoveNonNumeric(rawData.ValidationCode)
		rawData.Area = utils.RemoveNonNumeric(rawData.Area)
		rawData.InArea = utils.RemoveNonNumeric(rawData.InArea)
		rawData.UnitPrice = utils.RemoveNonNumeric(rawData.UnitPrice)
		rawData.TotalPrice = utils.RemoveNonNumeric(rawData.TotalPrice)
		hang, _ := utils.ParseJSONTime2(rawData.HangTime)
		last, _ := utils.ParseJSONTime2(rawData.LastTrade)
		err = copier.Copy(&data, &rawData)
		if err != nil {
			continue
		}
		data.ValidationCode, _ = strconv.ParseInt(rawData.ValidationCode, 10, 64)
		data.Area, _ = strconv.ParseFloat(rawData.Area, 10)
		data.InArea, _ = strconv.ParseFloat(rawData.InArea, 10)
		data.UnitPrice, _ = strconv.ParseFloat(rawData.UnitPrice, 10)
		data.TotalPrice, _ = strconv.ParseFloat(rawData.TotalPrice, 10)
		data.HangTime = hang
		data.LastTrade = last
		// 处理分类信息
		locationParts := strings.Split(data.Location, " ")
		if len(locationParts) < 2 {
			continue
		}
		var (
			ok1, ok2, ok3 bool
		)
		firstCategory, secondCategory := locationParts[0], locationParts[1]
		if _, ok1 = index1[firstCategory]; !ok1 {
			index1[firstCategory] = pairInt{meID: currentID, parentID: 0}
			currentID++
		}
		if _, ok2 = index2[secondCategory]; !ok2 {
			index2[secondCategory] = pairInt{meID: currentID, parentID: index1[firstCategory].meID}
			currentID++
		}
		if _, ok3 = index3[data.Community]; !ok3 {
			index3[data.Community] = pairInt{meID: currentID, parentID: index2[secondCategory].meID}
			currentID++
		}
		currentTime, _ := utils.ParseJSONTime(time.Now().Format("2006-01-02"))
		global.GVA_DB.Transaction(
			func(tx *gorm.DB) error {
				if !ok1 {
					err = tx.Create(&manage.HouseCategory{CategoryId: index1[firstCategory].meID, CategoryLevel: 1, ParentId: 0, CategoryName: firstCategory,
						CategoryRank: currentID,
						CreateTime:   currentTime,
						UpdateTime:   currentTime,
					}).Error
				}
				if err != nil {
					return err
				}
				if !ok2 {
					err = tx.Create(&manage.HouseCategory{CategoryId: index2[secondCategory].meID,
						CategoryLevel: 2,
						ParentId:      index2[secondCategory].parentID,
						CategoryName:  secondCategory,
						CategoryRank:  currentID,
						CreateTime:    currentTime,
						UpdateTime:    currentTime,
					}).Error
				}
				if err != nil {
					return err
				}
				if !ok3 {
					err = tx.Create(&manage.HouseCategory{CategoryId: index3[data.Community].meID, CategoryLevel: 3, ParentId: index3[data.Community].parentID, CategoryName: data.Community,
						CategoryRank: currentID,
						CreateTime:   currentTime,
						UpdateTime:   currentTime,
					}).Error
				}
				if err != nil {
					return err
				}
				data.CategoryId = int64(index3[data.Community].meID)
				err = tx.Create(&data).Error
				return err
			})
		if err != nil {
			continue
		}
	}
	response.Ok(c)
}

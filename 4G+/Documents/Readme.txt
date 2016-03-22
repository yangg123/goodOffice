一、结构说明
1、AppDelegate（整个应用的入口）
2、Model（模型层所在路径）
2.1、CommonModel（公用model所在路径）
2.2、……（对应某个模块的model）
3、View（视图层所在路径）
3.1、CommonView（公用view所在路径）
3.2、……（对应某个模块的view）
4、Controller（控制器层所在路径）
4.1、BaseController（controller基类所在路径）
4.2、CommonController（公用controller所在路径）
4.3、……（其他controller）
5、Vendors（第三方的类库/SDK，如UMeng、WeiboSDK、WeixinSDK等等。）
6、Util（工具类）
6.1、自定义工具类（全局静态文件、发布appstore隐藏配置类）
6.2、第三方工具类（拼音、加密、编码等）
7、Resources（工程所需资源所在路径）
8、Document（文档所在路径,plist、josn、txt、cer等）
9、Macro（整个应用会用到的宏定义）


二、其他
1、请在自己添加的controller名字前加上所属模块的名字，例如：MessageFriendsViewController
2、项目中所有的controller都必须继承：Controller -> Base -> BaseViewController


Macro 说明：
|- AppMacro.h          （app相关的宏定义）
|- NotificationMacro.h （放app相关的宏定义）
|- VendorMacro.h       （一些方便使用的宏定义，如颜色RGB）
|- UtilsMacro.h         (一些第三方应用常量，如百度、友盟、环信)
|- Enum.h               (全局枚举)
当前appstore 版本信息： 1.1.1 (1.0)

三、应用用到的色值说明

APP全画幅底色       #f1f4f7
列表分割线          #d3d9de
底部导航栏底色       #fbfcfc
导航栏背景色   绿色： #00bf8f
导航栏字体颜色 白色： #ffffff
TabbarItem 字体颜色 #3c4856

键盘数字字体         #5d6b79
键盘英文字母         #758c9e
键盘底色            #fbfcfc
键盘的分割线         #d3d9de

通话记录：福建福州-电信     #727a83
底部导航栏上面一个像素的分割线颜色    60%透明 #c9d9de

<#欢迎添加其他注意事项#>


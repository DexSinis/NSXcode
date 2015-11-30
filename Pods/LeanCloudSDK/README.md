# AVOSCloud-iOS-SDK 与leancloud官方同步（包括实时通信SDK）

## 3.1.6 发布日期：2015-11-02

- 通信模块支持单点登录，调用 -[AVIMClient openWithClientId:tag:callback:]来使用，tag 为 nil 时是默认的多点登录，否则将把tag相同的其它设备踢下线，下线通知将回调于[AVIMClientDelegate client:didOfflineWithError]
- 基础模块和通信模块支持 OSX 平台，以后将与 iOS 平台同步更新
- 修复有时不返回 AVUser 子类的问题。另外，请调用 [CustomUser registerSubclass] 注册 AVUser 子类
- 修复文件下载进度可能为负数的问题
- AVFileQuery 增加 getFileWithId:、findFiles: 等接口，支持返回 AVFile 而非 AVObject
- 修改密码后更新 Session Token，无须重新登录
- 优化通信模块的请求，防止请求被 DNS 劫持

## 3.1.5.2 发布日期：2015-10-15
- 修复网络请求中，POST 数据不能正确处理的问题
- AVQuery 支持 GeoPoint 最小距离（minDistance）查询条件


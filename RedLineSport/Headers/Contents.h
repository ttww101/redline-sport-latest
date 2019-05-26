#ifndef Contents_h
#define Contents_h
#define NotificationupdateUnreadLabNum @"updateUnreadLabNum"
#define NotificationOpenMainTableBarTimer @"OpenMainTableBarTimer"
#define NotificationRefreshOneDayEvent @"RefreshOneDayEvent"
#define NotificationupdatePeiLv @"updatePeiLv"
#define NotificationupdateAttentionView @"updateAttentionView"
#define NotificationupdateByselectedSaishi @"updateByselectedSaishi"
#define NotificationupdateByselectedJingCaiSaishi @"updateByselectedJingCaiSaishi"
#define NotificationupdateByselectedinfo @"updateByselectedfabuInfo"
#define NotificationupdateByselectedQingBao  @"updateByselectedQingBao"
#define NotificationtouchDetailHeaderView @"touchDetailHeaderView"
#define NotificationpushToNewsWeb @"Notification"
#define NotificationchangePushSwitch @"changePushSwitch"
#define NotificationsetFirstTableViewContentOffsetZero @"setFirstTableViewContentOffsetZero"
#define NotificationsetSecondTableViewContentOffsetZero @"setSecondTableViewContentOffsetZero"
#define NotificationsetThirdTableViewContentOffsetZero @"setThirdTableViewContentOffsetZero"
#define NotificationsetForthTableViewContentOffsetZero @"setForthTableViewContentOffsetZero"
#define NotificationsetForth2TableViewContentOffsetZero @"setForth2TableViewContentOffsetZero"
#define NotificationsetFifthTableViewContentOffsetZero @"setFifthTableViewContentOffsetZero"
#define LettersAndNum   @"_.ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define Nunbers @"0123456789"
#define DateFormatterYear                   @"yyyy-MM-dd"
#define DateFormatterYearH                   @"yy-MM-dd"
#define DateFormatterhour                   @"HH:mm"
#define DateFormatterMonth                  @"yyyy-MM"
#define DateFormatter                  @"yyyy-MM-dd"
#define dateStyleFormatter @"yyyy-MM-dd HH:mm:ss"
#define dateStyleFormatterWeek @"yyyy-MM-dd HH:mm:ss EEEE"
#define dateStyleFormatterMdHm @"MM-dd HH:mm"
#define islogin @"login"
#define arrSaveBifenAllSelectedPath @"arrSaveBifenAllSelectedPath.plist"
#define arrSaveBifenJingcaiSelectedPath @"arrSaveBifenJingcaiSelectedPath.plist"
#define arrSaveBifenChupanSelectedPath @"arrSaveBifenChupanSelectedPath.plist"
#define arrSaveAllSelectedPathTuijianJingcai @"arrSaveTuijianJingcaiAllSelectedPath.plist"
#define arrSaveJingcaiSelectedPathTuijianJingcai @"arrSaveTuijianJingcaiJingcaiSelectedPath.plist"
#define arrSaveChupanSelectedPathTuijianJingcai @"arrSavetuijianjingcaiChupanSelectedPath.plist"
#define arrSaveAllSelectedPathinfo @"arrSaveinfoAllSelectedPath.plist"
#define arrSaveJingcaiSelectedPathinfo @"arrSaveinfoJingcaiSelectedPath.plist"
#define arrSaveChupanSelectedPathinfo @"arrSaveinfoChupanSelectedPath.plist"
#define biFenTitleChange @"biFenTitleChange"
#define BifenPageAttentionArray @"BifenPageAttentionArray.plist"
#define QingBaoPagettentionArray @"QingBaoPagettentionArray.plist"
#define default_loadFailure @"加载失败，再刷新试试"
#define default_noMatch @"没有比赛，休息一下哦"
#define default_isLoading @"载入数据中，稍候"
#define default_noGame @"没有关注的比赛"
#define default_1 @"等待指数更新"
#define default_2 @"等待阵容公布"
#define default_3 @"球队无伤停，给力"
#define default_4 @"本场暂无比赛统计"
#define default_5 @"两队无交锋"
#define default_6 @"暂无未来赛事"
#define default_7 @"暂无必发数据"
#define default_8 @"暂无数据"
#define default_9 @"Ta还没发布过情报"
#define default_10 @"Ta还没发布过推荐"
#define default_11 @"Ta还没竞猜过比赛"
#define default_12 @"暂无情报，你要做头条吗"
#define default_13 @"暂无推荐，你要做头条吗"
#define default_14 @"懒人，还没发过情报呢"
#define default_15 @"懒人，还没发过推荐呢"
#define default_16 @"懒人，还没猜过比赛呢"
#define default_17 @"加油，去拉您的第一个粉丝"
#define default_18 @"您还没有关注过他人"
#define default_19 @"还没有关注过其他人"
#define default_20 @"暂无粉丝"
#define default_21 @"没有相关情报"
#define default_22 @"本场无数据"
#define RICHTEXT_IMAGE (@"[UIImageView]")
#define isNUll(str) (str == nil || [str isEqualToString:@""])


// 程序进入退出前台时 发送通知记录当前输入内容
#define ResignActiveNotificarion @"savePublishContent"
#define RecordsFormEditContentPath [NSString stringWithFormat:@"%@/FormEdit.plist",[RLSMethods getDocumentsPath]]
#define RecordsRecommendEditContentPath [NSString stringWithFormat:@"%@/RecommendEdit.plist",[RLSMethods getDocumentsPath]]


#endif
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define NSLog(format, ...)











#endif

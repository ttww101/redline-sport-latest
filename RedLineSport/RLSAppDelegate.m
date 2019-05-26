//
//  RLSAppDelegate.m
//  GQapp
//
//  Created by WQ_h on 16/3/28.
//  Copyright © 2016年 GQXX. All rights reserved.
//
/*
 
 */


#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#import "RLSAppDelegate.h"
#import <Photos/Photos.h>
#import "UIImage+ScreenPic.h"
#import "PictureModel.h"
#import <Bugly/Bugly.h>
#import "RLSTuijianDetailVC.h"
#import "RLSAppleIAPService.h"
#import "XHPayKit.h"
#import <UMPush/UMessage.h>
#import "RLSAppConfig.h"
#import "RLSTabConfig.h"
#import "ArchiveFile.h"
#import "RLSStartViewController.h"
#import "RLSLaunchView.h"
#import "RLSAspectManager.h"
#import "Contents.h"

#define Config_Version @"configVersion"


#if defined(DEBUG) || defined(_DEBUG)
//#import <GDPerformanceView/GDPerformanceMonitor.h>
#endif

//#ifndef __OPTIMIZE__
//#import "RRFPSBar.h"
//#endif

@interface RLSAppDelegate ()
@property (nonatomic, strong) NSDictionary *pushInfo;
@property (nonatomic, assign) BOOL successGetPushInfo;

//底部图片
@property (nonatomic, strong) UIImageView * imageView;

/**
 分享根视图
 */
@property (nonatomic, strong) UIView * sharView;

@property (nonatomic, strong) UIImageView *showView;

@property (nonatomic, strong) UIImageView *snaView;



@end

@implementation RLSAppDelegate

/**
 遗留在本地的内购验证
 */
- (void)resumePuchase {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[RLSAppleIAPService sharedInstance]VerifyingLocalCredentialsWithBlock:^(NSString *message, NSError *error) {
            if (error) {
                NSString *errMse = error.userInfo[@"NSLocalizedDescription"];
                [SVProgressHUD showErrorWithStatus:errMse];
            } else{

            }
        }];
    });
}

/**
 统计页面路径
 */

- (void)configPageStatistics {
    NSMutableDictionary *dic = [RLSAspectManager GQ_PathForPageDic];
    if (dic) {
        NSString *lastVersion = dic[@"appVersion"];
        NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if (![lastVersion isEqualToString:currentVersion]) {
            [RLSAspectManager GQ_SavePageDic];
        }
    } else {
        [RLSAspectManager GQ_SavePageDic];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

    // 根视图 默认是透明的,也就是黑色的
    self.window.backgroundColor = [UIColor whiteColor];
    
    RLSStartViewController *launchControl = [[RLSStartViewController alloc]init];
    self.window.rootViewController = launchControl;
    [self.window makeKeyAndVisible];
    [self loadLaunchImageView]; // 开屏广告

    
    [self getUrlSerPath];

    [self isFirstLaunched];
    [self resumePuchase];  // 遗留在本地的内购验证
    [self configPageStatistics];
    
    [self setupUM];
    [self setUMShare];
    [self setUpBugly];
    [self svPreferrenceConf];
//    [self setupXGpush:application WithOptions:launchOptions];
    [self setupUPushWith:application WithOptions:launchOptions];
//    [self setUpMessageSound];
   // [self setUpFPS];
//    [self addTimerForHomeAndScore];
    //点击通知栏,启动app的时候从这里获取推送信息,
    NSDictionary *launchOptionPushInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (launchOptionPushInfo) {
        NSLog(@"%@",launchOptionPushInfo);
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:launchOptionPushInfo] forKey:@"launchOptionPushInfo"];
        
    }
    
    
//    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeNone categories:nil]];//注册本地推送
//    [self initLocalNotification];
    
    [self getScreenShot];
    
    [[RLSAppConfig shareInstance]initialize];

//    [self loadrefreshtoken];
    

    return YES;
}


- (void)loadConfig {
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [RLSHttpString getCommenParemeter]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *localVerson = [defaults objectForKey:Config_Version];
    if (!localVerson) {
        localVerson = @"0";
    }
    NSInteger configVerson = [localVerson integerValue];
    [parameter setObject:@"1" forKey:@"platform"];
    [parameter setObject:@(configVerson) forKey:Config_Version];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ConfigjSon] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        NSMutableArray *array = responseOrignal[@"pay"];
        NSMutableArray *tabBarArray = responseOrignal[@"tabBar"];
        NSInteger ver = [responseOrignal[@"ver"] integerValue];
        if (ver > configVerson) {
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%zi",ver] forKey:Config_Version];
            [[NSUserDefaults standardUserDefaults]setObject:PARAM_IS_NIL_ERROR(responseOrignal[@"currency"]) forKey:@"currency"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            // 配置支付
            if (array) {
                if (array.count == 0) {
                    [ArchiveFile clearCachesWithFilePath:Buy_Type_Path];
                } else {
                    [ArchiveFile saveDataWithPath:Buy_Type_Path data:array];
                }
            }
            
            // 配置tabBar
            if (tabBarArray) {
                if (tabBarArray.count == 0) {
                    [ArchiveFile clearCachesWithFilePath:TableConfig];
                    [self initRootViewCotroller];
                } else {
                    [tabBarArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSString *imageUrl = obj[@"defaultImage"];
                        NSString *selectImageUrl = obj[@"selectImage"];
                        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            
                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        }];
                        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:selectImageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            
                        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            
                        }];
                        
                    }];
                    [ArchiveFile saveDataWithPath:TableConfig data:tabBarArray];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self initRootViewCotroller];
                    });
                }
            } else {
                [self initRootViewCotroller];
            }
        } else {
            [self initRootViewCotroller];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [self initRootViewCotroller];
    }];
}


#pragma mark - setUpMessageSound -
- (void)setUpMessageSound {
    
    //设置系统音效
    [RLSMessageSoundMgr sharedInstanceForSound];
    //设置系统震动
    [RLSMessageSoundMgr sharedInstanceForVibrate];
}

#pragma mark --- SVProgressHUD 偏好设置
-(void)svPreferrenceConf {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@""]];
    [SVProgressHUD setMaximumDismissTimeInterval:1.5];
}

//获取截屏事件
- (void)getScreenShot
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(takeScreenShot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidScreenShort:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];

}


#pragma mark 获取到截屏的通知后在此做处理
-(void)userDidScreenShort:(NSNotification *)notice{
    
    UIImage *footerImage = [UIImage imageNamed:@"codeimage@2x"];
    UIImage *image_ = [UIImage imageWithScreenshot];
//    UIImage *newImage = [UIImage imageCompressWithSimple:footerImage scale:footerImage.size.height * Screen_Base_Width / footerImage.size.width];
    UIImage *codeImage = [UIImage composeWithHeader:image_ footer:footerImage];
    
    self.showView.image = codeImage;
    
    NSMutableArray *imageArr = [NSMutableArray new];
    [imageArr addObject:codeImage];
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.showView.frame = CGRectMake(30, KScreenHeight *0.5 - KScreenHeight *0.25, KScreenWidth - 60, KScreenHeight *0.5);
            self.sharView.frame = CGRectMake(20, KScreenHeight - 120, KScreenWidth - 40, 70);
            
        } completion:^(BOOL finished) {
            
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                
                
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.showView.frame = CGRectMake(30, KScreenHeight, KScreenWidth - 60, KScreenHeight *0.5);
                    self.sharView.frame = CGRectMake(20, KScreenHeight, KScreenWidth - 40, 70);
                } completion:^(BOOL finished) {
                   
                   
//                    [[RLSDependetNetMethods sharedInstance] uploadImageWithImageArr:imageArr completion:^(BOOL finished, NSArray *arrUrl) {
//                        
//                        if (finished) {
//                            
//                            PictureModel *pic = [arrUrl firstObject];
//                            self.shareViews.shareImageUrl = pic.imageurl;
//                            [self.shareViews shareViewShow];
//
//                        }
//                        
//                    }];
                }];
                
            });
            
        }];
        
    });
    
}

- (void)initRootViewCotroller
{
    //每次初始化的时候清除首页缓存
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstPageDataLocal"];
    RLSTabConfig *config = [[RLSTabConfig alloc]init];
    APPDELEGATE.customTabbar = config.tabBarController;
    config.tabBarController.selectedIndex = 0;
    self.window.rootViewController = config.tabBarController;
    [self.window makeKeyWindow];
    //启动程序后请求看有没有未读通知
    if ([RLSMethods login]) {
        [APPDELEGATE.customTabbar loadUreadNotificationNum];
    }
    [self loadFirstData];
    //第二天打开app的时候重新初始化根视图
//    NSString *currentLocalDay = [RLSMethods getDateByStyle:DateFormatter withDate:[NSDate date]];
//    [[NSUserDefaults standardUserDefaults] setObject:currentLocalDay forKey:@"currentLocalDay"];
    
}


//添加本地推送
- (void)initLocalNotification
{
//    
//   /*
//    因为since1970得出的时间本身就是早上8点，你又加了八个小时，变成了下午4点提醒了，你这个函数本身是没错的，是你没搞清楚格林尼治时间，since1970并非是在1970年1月1日的早上零点开始算的，而是根据安装该软件的手机的系统时区所对应的时区的得出来的时间，换算成北京时间，这个since1970所得出的起始时间就是1970年1月1日早上8点
//    */
//    
//    UILocalNotification*notification = [[UILocalNotification alloc]init];
//    NSDate * pushDate = [NSDate dateWithTimeIntervalSince1970:0];
//    if (notification != nil) {
//        notification.fireDate = pushDate;
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        notification.repeatInterval = kCFCalendarUnitDay;
////                notification.soundName = UILocalNotificationDefaultSoundName;
////                notification.alertBody = @"hello，world";
////                notification.applicationIconBadgeNumber = 0;
//        NSDictionary*info = [NSDictionary dictionaryWithObject:@"bifenLoadata" forKey:@"localNotifaBifenLoadata"];
//        notification.userInfo = info;
//        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//        
//    }

}

//判断是以什么情况进入app的
- (void)isFirstLaunched
{
    
    

    
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"localAppVersion"]) {
        //第一次安装app

        [self updataLocalSaveData];
    }else{
    
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"localAppVersion"] isEqualToString:currentVersion]) {
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstPageDataLocal"];
            //不清除在本地保存的信息
////           app更新之后,把存在本地的内容清除
//                NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
//            
//                NSDictionary* dict = [defs dictionaryRepresentation];
//                NSLog(@"%@",dict);
//                for(id key in dict) {
//            
//                    [defs removeObjectForKey:key];
//            
//                }
//                [defs synchronize];

            [self updataLocalSaveData];
            
        }else{
        //平时关闭程序之后,再次打开

            //标示不是第一次打开
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunched"];
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showGuideVC"];

        }
        
    }
    

}
//第一次或者更新之后重新设置本地的数据
- (void)updataLocalSaveData
{
    
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];

    //第一次安装app
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"localAppVersion"];
    //提示是第一次登陆
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunched"];
    //显示引导页
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showGuideVC"];

    
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaishijian"];

    //默认显示爆料推荐
       [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiu"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitishi"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpai"];
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huangpai"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"banchang"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"qiuduipaiming"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"bianhao"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jiaoqiu"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shengyin"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"zhendong"];
    
    
    
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"hasSetted"] isEqualToString:@"1"]) {
        
        [[NSUserDefaults standardUserDefaults]setObject:@[@"8001",@"8002"] forKey:@"befenSetingPeilv"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiutanchuan"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiushengying"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitanchuang"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitishi"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaishenying"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitishi"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"koushao"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huanhu"];

        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionMe"];

        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    
//    [[NSUserDefaults standardUserDefaults]setObject:@[@"0",@"1"] forKey:@"beforeXianShi"];
//    [[NSUserDefaults standardUserDefaults]setObject:@[@"0",@"1"] forKey:@"BeforeMoRenBF"];
//    [[NSUserDefaults standardUserDefaults]setObject:@[@"0",@"1"] forKey:@"BeforeTiShiFW"];
//    [[NSUserDefaults standardUserDefaults]setObject:@[@"0",@"1"] forKey:@"BeforeTiShiSY"];
//    [[NSUserDefaults standardUserDefaults]setObject:@[@"0",@"1"] forKey:@"BeforeJinQiuTS"];
//    [[NSUserDefaults standardUserDefaults]setObject:@[@"0",@"1"] forKey:@"BeforeHongPaiTS"];
    

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //第一次开启app的时候放在本地一个用来存储关注的比赛的数组
    
    NSString *documentsPath = [RLSMethods getDocumentsPath];
    
    NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
    
    NSString *qingArr = [documentsPath stringByAppendingPathComponent:QingBaoPagettentionArray];
    
    [NSKeyedArchiver archiveRootObject:[NSMutableArray array] toFile:qingArr];
    
    [NSKeyedArchiver archiveRootObject:[NSMutableArray array] toFile:arrayPath];

}





//获取服务器地址
- (void)getUrlSerPath
{

    //设备唯一标示
    [[NSUserDefaults standardUserDefaults] setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:@"deviceTokenStr"];
//
////    正式环境
    APPDELEGATE.url_Server = @"https://mobile.gunqiu.com/interface/v3.6";
    APPDELEGATE.url_jsonHeader = @"http://mobile.gunqiu.com";
    APPDELEGATE.url_ServerWWW = @"http://www.gunqiu.com";
    APPDELEGATE.url_ServerAgreement = @"http://www.gunqiu.com";
    APPDELEGATE.url_ServerQiuTan = @"http://mobile.gunqiu.com";
    APPDELEGATE.url_upLoadImg = @"http://mobile.gunqiu.com:8897";
   // 新加
    APPDELEGATE.url_JISHUIDATA=@"http://mobile.gunqiu.com:8803";//及时更新数据-及时指数的
    APPDELEGATE.url_ip = @"https://mobile.gunqiu.com";


    //    本地测试环境
//    APPDELEGATE.url_Server = @"http://10.0.80.95/interface";
////    APPDELEGATE.url_Server = @"http://mobile.gunqiu.com/interface";
//    APPDELEGATE.url_jsonHeader = @"http://10.0.80.95";
//    APPDELEGATE.url_ip = @"http://10.0.80.95";
//    APPDELEGATE.url_ServerWWW = @"http://pctest.gunqiu.com";
//    APPDELEGATE.url_ServerAgreement = @"http://www.gunqiu.com";
//    APPDELEGATE.url_ServerQiuTan = @"http://mobile.gunqiu.com";
//    APPDELEGATE.url_upLoadImg = @"http://mobile.gunqiu.com:8897";

    //上线的时候关闭--wt
//    APPDELEGATE.url_Server = @"http://mobiledev.gunqiu.com:81/interface";
//    APPDELEGATE.url_jsonHeader = @"http://mobiledev.gunqiu.com";
//    APPDELEGATE.url_ip = @"http://mobiledev.gunqiu.com:81";
//    APPDELEGATE.url_ServerWWW = @"http://pctest.gunqiu.com";
//    APPDELEGATE.url_ServerAgreement = @"http://www.gunqiu.com";
//    APPDELEGATE.url_ServerQiuTan = @"http://mobile.gunqiu.com";
//    APPDELEGATE.url_upLoadImg = @"http://mobile.gunqiu.com:8897";
//    APPDELEGATE.url_JISHUIDATA=@"http://mobile.gunqiu.com:8803";//及时更新数据-及时指数的
    
//    预发布
//        APPDELEGATE.url_Server = @"https://mobile.gunqiu.com:82/interface/v3.6";
//        APPDELEGATE.url_jsonHeader = @"http://mobile.gunqiu.com/";
//        APPDELEGATE.url_ip = @"https://mobile.gunqiu.com";
//        APPDELEGATE.url_ServerWWW = @"http://pctest.gunqiu.com";
//        APPDELEGATE.url_ServerAgreement = @"http://www.gunqiu.com";
//        APPDELEGATE.url_ServerQiuTan = @"http://mobile.gunqiu.com";
//        APPDELEGATE.url_upLoadImg = @"http://mobile.gunqiu.com:8897";
//        APPDELEGATE.url_JISHUIDATA=@"http://mobile.gunqiu.com:8803";//及时更新数据-及时指数的

////    上线的时候开启
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"APPDELEGATE.url_Server"] isEqualToString:@"http://mobile.gunqiu.com/interface"]) {
//        APPDELEGATE.url_Server = @"http://mobiledev.gunqiu.com/interface";
//        APPDELEGATE.url_jsonHeader = @"http://mobiledev.gunqiu.com";
//
//        [self GetServerUrl];
//        
//    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"APPDELEGATE.url_Server"] isEqualToString:@"http://mobile.gunqiu.com/interface"]){
//        APPDELEGATE.url_Server = @"http://mobile.gunqiu.com/interface";
//        APPDELEGATE.url_jsonHeader = @"http://mobile.gunqiu.com";
//
//    }
}

//友盟推送


- (void)setupUPushWith:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions
{
    
    
    // Push功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    //如果你期望使用交互式(只有iOS 8.0及以上有)的通知，请参考下面注释部分的初始化代码
    if (([[[UIDevice currentDevice] systemVersion]intValue]>=8)&&([[[UIDevice currentDevice] systemVersion]intValue]<10)) {
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"打开应用";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"忽略";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        UIMutableUserNotificationCategory *actionCategory1 = [[UIMutableUserNotificationCategory alloc] init];
        actionCategory1.identifier = @"category1";//这组动作的唯一标示
        [actionCategory1 setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        NSSet *categories = [NSSet setWithObjects:actionCategory1, nil];
        entity.categories=categories;
    }
    //如果要在iOS10显示交互式的通知，必须注意实现以下代码
    if ([[[UIDevice currentDevice] systemVersion]intValue]>=10) {
        UNNotificationAction *action1_ios10 = [UNNotificationAction actionWithIdentifier:@"action1_identifier" title:@"打开应用" options:UNNotificationActionOptionForeground];
        UNNotificationAction *action2_ios10 = [UNNotificationAction actionWithIdentifier:@"action2_identifier" title:@"忽略" options:UNNotificationActionOptionForeground];
        //UNNotificationCategoryOptionNone
        //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
        //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
        UNNotificationCategory *category1_ios10 = [UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1_ios10,action2_ios10]   intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        NSSet *categories = [NSSet setWithObjects:category1_ios10, nil];
        entity.categories=categories;
    }
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    
    //设置 AppKey 及 LaunchOptions
//    [UMessage startWithAppkey:UPushAppKey launchOptions:launchOptions];
//
//    //1.3.0版本开始简化初始化过程。如不需要交互式的通知，下面用下面一句话注册通知即可。
//    [UMessage registerForRemoteNotifications];
//
//    [UMessage setLogEnabled:YES];
//
//    [UMessage setBadgeClear:YES];
//    [UMessage setAutoAlert:NO];
//    + (void)setLogEnabled:(BOOL)value;
//
//    /** 设置是否允许SDK自动清空角标（默认开启）
//     @param value 是否开启角标清空
//     */
//    + (void)setBadgeClear:(BOOL)value;
//
//    /** 设置是否允许SDK当应用在前台运行收到Push时弹出Alert框（默认开启）
//     @warning 建议不要关闭，否则会丢失程序在前台收到的Push的点击统计,如果定制了 Alert，可以使用`sendClickReportForRemoteNotification`补发 log
//     @param value 是否开启弹出框
//     */
//    + (void)setAutoAlert:(BOOL)value;

}

//友盟统计
- (void)setupUM
{
    [UMConfigure initWithAppkey:UMAppkey channel:@"App Store"];
//    [UMConfigure setLogEnabled:YES]; // 上线时必须关掉
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
    }
    completionHandler(UIBackgroundFetchResultNewData);
    [UMessage didReceiveRemoteNotification:userInfo];

}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
       
    }
    
    
    
    // 程序出于前台时 收到推送 
//    _successGetPushInfo = YES;
//    _pushInfo = [[NSDictionary alloc] initWithDictionary:userInfo];
//    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        
    }
    _successGetPushInfo = YES;
    _pushInfo = [[NSDictionary alloc] initWithDictionary:userInfo];
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{

    [UMessage didReceiveRemoteNotification:userInfo];

    _successGetPushInfo = YES;
    _pushInfo = [[NSDictionary alloc] initWithDictionary:userInfo];

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken + %@ ",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                  stringByReplacingOccurrencesOfString: @">" withString: @""]
                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
}


#pragma mark -- tecent Bugly
- (void)setUpBugly {

    [Bugly startWithAppId:BuglyID];
}



#pragma mark -- FPS
- (void)setUpFPS {

//#ifndef __OPTIMIZE__
//    [[RRFPSBar sharedInstance] setHidden:NO];
//#endif
 

#if defined(DEBUG) || defined(_DEBUG)
//    [[GDPerformanceMonitor sharedInstance] startMonitoring];
//    [[GDPerformanceMonitor sharedInstance] setAppVersionHidden:YES];
//    [[GDPerformanceMonitor sharedInstance] setDeviceVersionHidden:YES];
//    [[GDPerformanceMonitor sharedInstance] startMonitoringWithConfiguration:^(UILabel *textLabel) {
//       
//        [textLabel setBackgroundColor:[UIColor clearColor]];
//        [textLabel setTextColor:[UIColor greenColor]];
//        textLabel.font = [UIFont systemFontOfSize:11];
//        [textLabel.layer setBorderColor:[[UIColor blackColor] CGColor]];
//    }];
#endif
}

//友盟分享和第三方登录
- (void)setUMShare {
    /*
     * 打开图片水印
     */
    [UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppID appSecret:WXAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID  appSecret:QQAppkey redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:SinaAppKey  appSecret:SinaAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
}

// 支持目前所有iOS系统
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}
    
    // 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
    {
        
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
        if (!result) {
            // 其他如支付等SDK的回调
            return [[XHPayKit defaultManager] handleOpenURL:url];
        }
        return result;
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_9_0
/** iOS9及以后 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    BOOL result = [[XHPayKit defaultManager] handleOpenURL:url];
    if (!result) {//这里处理其他SDK(例如QQ登录,微博登录等)
        return [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    }
    return result;
}
#endif


- (void)applicationWillResignActive:(UIApplication *)application {
    // 发送广播 当正在编辑发布内容时记录当前内容
    [[NSNotificationCenter defaultCenter]postNotificationName:ResignActiveNotificarion object:nil];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if ([RLSMethods login]) {      // 用户登出，清除 OutOfRefreshTokenTime / refreshTokentime
        
        
        //        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"] != 0) {
        
        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"] < [[NSDate date] timeIntervalSince1970] * 1000) {
            
            [APPDELEGATE.customTabbar loadUreadNotificationNum];
        }
        //        }
        
//        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"OutOfRefreshTokenTime"] >= [[NSDate date] timeIntervalSince1970] * 1000) {
//            
//            [APPDELEGATE.customTabbar loadUreadNotificationNum];
//        }
    }


    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if ([RLSMethods login]) {      // 用户登出，清除 OutOfRefreshTokenTime / refreshTokentime
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshPayPage" object:nil];
        
//        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"] != 0) {
        
            if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"] < [[NSDate date] timeIntervalSince1970] * 1000) {
                [APPDELEGATE.customTabbar loadUreadNotificationNum];
            }
//        }
        
//        if ([[NSUserDefaults standardUserDefaults] doubleForKey:@"OutOfRefreshTokenTime"] >= [[NSDate date] timeIntervalSince1970] * 1000) {
//            
//            [APPDELEGATE.customTabbar loadUreadNotificationNum];
//        }
        
    }
    
    



    //不写去除角标,因为若是去除的话会把通知栏里面所有的角标都去除,
    //服务器发送推送的时候传的角标默认为0,不再去除
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    //如果当前页面停留在个人中心模块,更新推送按钮的状态
    if (self.customTabbar.selectedIndex ==4) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationchangePushSwitch object:nil];

    }
    //允许推送信息跳转VC
        if (_successGetPushInfo) {
             if (_pushInfo!= nil) {
                _successGetPushInfo = NO;
                APPDELEGATE.customTabbar.selectedIndex = 0;
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationpushToNewsWeb object:nil userInfo:_pushInfo];
                
            }
        }
    
    if (self.customTabbar.selectedIndex ==1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationTogetAllJishibifen" object:nil];
        
    }
    //app 每次打开都去请求即时比分页面的大对阵

    
    
    
    
////上线的时候开启
//    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"APPDELEGATE.url_Server"] isEqualToString:@"http://mobile.gunqiu.com/interface"]) {
//        
//        APPDELEGATE.url_Server = @"http://mobiledev.gunqiu.com/interface";
//        APPDELEGATE.url_jsonHeader = @"http://mobiledev.gunqiu.com";
//
//        [self GetServerUrl];
//        
//    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"APPDELEGATE.url_Server"] isEqualToString:@"http://mobile.gunqiu.com/interface"]){
//        APPDELEGATE.url_Server = @"http://mobile.gunqiu.com/interface";
//        APPDELEGATE.url_jsonHeader = @"http://mobile.gunqiu.com";
//
//    }
    
    
    

}

//- (void)addTimerForHomeAndScore {
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"addTimerForHomeAndScore" object:@"Home"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"addTimerForHomeAndScore" object:@"Score"];
//}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    [RLSCacheObject delete_Data_urlKey:@"jiaoyi"];
//    [RLSCacheObject delete_Data_urlKey:@"touzhu"];
//    [RLSCacheObject delete_Data_urlKey:@"jixian"];
}


- (void)GetServerUrl
{
    
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
//    [parameter setObject:@"1" forKey:@"flag"];
//    [parameter setObject:@"v1.5.3" forKey:@"version"];
//    [parameter setObject:@"1" forKey:@"platform"];
//    [parameter setObject:@"1" forKey:@"visit"];
//
//    
//    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:@"http://mobile.gunqiu.com/interface/version" Start:^(id requestOrignal) {
//        
//    } End:^(id responseOrignal) {
//        
//    } Success:^(id responseResult, id responseOrignal){
//        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
//            
//            if ([[responseOrignal objectForKey:@"data"] objectForKey:@"interfaceurl"]) {
//                
//                
//                if ([[[responseOrignal objectForKey:@"data"] objectForKey:@"interfaceurl"] isEqualToString:@"mobile"]) {
//                    
//                    APPDELEGATE.url_Server = @"http://mobile.gunqiu.com/interface";
//                    APPDELEGATE.url_jsonHeader = @"http://mobile.gunqiu.com";
//                    
//                    
//                }else{
//                
//                    APPDELEGATE.url_Server = @"http://mobiledev.gunqiu.com/interface";
//                    APPDELEGATE.url_jsonHeader = @"http://mobiledev.gunqiu.com";
//
//                }
//                
//            }else{
//            
//                APPDELEGATE.url_Server = @"http://mobiledev.gunqiu.com/interface";
//                APPDELEGATE.url_jsonHeader = @"http://mobiledev.gunqiu.com";
//
//            }
//            
//            
//            
//            NSLog(@"APPDELEGATE.url_Server----%@",APPDELEGATE.url_Server);
//            [[NSUserDefaults standardUserDefaults] setObject:APPDELEGATE.url_Server forKey:@"APPDELEGATE.url_Server"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//        }else{
//            APPDELEGATE.url_Server = @"http://mobiledev.gunqiu.com/interface";
//            APPDELEGATE.url_jsonHeader = @"http://mobiledev.gunqiu.com";
//
//            [[NSUserDefaults standardUserDefaults] setObject:APPDELEGATE.url_Server forKey:@"APPDELEGATE.url_Server"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//
//        }
//        
//    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//        APPDELEGATE.url_Server = @"http://mobiledev.gunqiu.com/interface";
//        APPDELEGATE.url_jsonHeader = @"http://mobiledev.gunqiu.com";
//
//        [[NSUserDefaults standardUserDefaults] setObject:APPDELEGATE.url_Server forKey:@"APPDELEGATE.url_Server"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }];

}
////发送设备UDID
//- (void)senddeviceTokenStr:(NSString *)deviceTokenStr
//{
//    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
//    [parameter setObject:@"1" forKey:@"platform"];
//    [parameter setObject:deviceTokenStr forKey:@"uuid"];
//    [parameter setObject:@"13" forKey:@"flag"];
//
//    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] Start:^(id requestOrignal) {
//        
//    } End:^(id responseOrignal) {
//        
//    } Success:^(id responseResult, id responseOrignal){
//    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
//            }];
//}



- (void)loadLaunchImageView {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter] ];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_startpage] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
        
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSDictionary *dataDic = [responseOrignal objectForKey:@"data"];
             [self loadConfig];
            if (!(dataDic.allKeys.count == 0)) {
                RLSLaunchView *launchV = [[RLSLaunchView alloc] initWithFrame:self.window.bounds];
                launchV.dataDic = dataDic;
                [[RLSMethods getMainWindow] addSubview:launchV];
            }
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
         [self loadConfig];
    }];
}

//加载首页的数据存在本地，为了避免第一次进来的时候没有任何数据
- (void)loadFirstData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter] ];
    [parameter setObject:@"0" forKey:@"ver"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_firstIndex] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseOrignal];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"firstPageDataLocal"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //            NSLog(@"%@",responseOrignal);
            
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
        //        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
//加载首页的数据存在本地，为了避免第一次进来的时候没有任何数据
- (void)loadrefreshtoken
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter] ];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_firstIndex] Start:^(id requestOrignal) {
        
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
//        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
        
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:responseOrignal];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"firstPageDataLocal"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //            NSLog(@"%@",responseOrignal);
            
//        }else{
//        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        
        //        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}


@end

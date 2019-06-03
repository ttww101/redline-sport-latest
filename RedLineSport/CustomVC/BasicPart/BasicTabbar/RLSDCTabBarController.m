#import "RLSDCTabBarController.h"
#import "RLSFirstViewController.h"
#import "RLSBifenViewController.h"
#import "RLSTuijianDTViewController.h"
#import "RLSNewQingBaoViewController.h"
#import "RLSOldMineViewController.h"
#import "UITabBar+badge.h"
#import "RLSDCNavViewController.h"
#import "RLSTuijianDetailVC.h"
#import "RLSToolWebViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "RLSCustmerTableBar.h"
#import "RLSLotteryWebViewController.h"
#import "JANALYTICSService.h"
NSString *const GQTableBarControllerName = @"GQTableBarControllerName";
NSString *const GQTabBarItemTitle = @"GQTabBarItemTitle";
NSString *const GQTabBarItemImage = @"GQTabBarItemImage";
NSString *const GQTabBarItemSelectedImage = @"GQTabBarItemSelectedImage";
NSString *const GQTabBarItemLoadH5 = @"GQTabBarItemLoadH5";
NSString *const GQTabBarItemWbebModel = @"GQTabBarItemWbebModel";
@interface RLSDCTabBarController ()<UIGestureRecognizerDelegate, TabBarDelegate>
{
    RLSDCNavViewController *_firstNav;
    RLSDCNavViewController *_secondNav;
    RLSDCNavViewController *_thirdNav;
    RLSDCNavViewController *_forthNav;
    RLSDCNavViewController *_mineNav;
}
@property (strong, nonatomic)NSTimer *refreshUnreadCountTimer;
@property (nonatomic, copy) NSArray *tabBarItemArray;
@property (nonatomic , strong) UIView *recordView;
@property (nonatomic , copy) NSDictionary *activityDic;
@property (nonatomic , strong) RLSCustmerTableBar *taBar;
@property (nonatomic, assign) BOOL isToFenxi;
@end
static CGFloat imageHeight = 66.f;
@implementation RLSDCTabBarController
- (instancetype)initWithItemArray:(NSArray *)itemArray {
    if (self) {
        _tabBarItemArray = [itemArray copy];
    }
    return self;
}
- (void)viewDidLoad {
     [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openOrCloseRefreshUnreadCountTimer:) name:NotificationOpenMainTableBarTimer object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToNewsWeb:) name:NotificationpushToNewsWeb object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configActivityEntrance) name:@"reloadTableBarActivity" object:nil];
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
//    NSLog(@"status width - %f", rectStatus.size.width);
//    NSLog(@"status height - %f", rectStatus.size.height);
    UINavigationController *nav = [[UINavigationController alloc] init];
    CGRect rectNav = nav.navigationBar.frame;
    self.height_myStateBar = rectStatus.size.height;
    self.height_myNavigationBar = rectStatus.size.height + rectNav.size.height;
    self.height_myTabBar = self.tabBar.frame.size.height;
    [self setupTabbarItems];
    [self setupTabBarStyle];
    if ([RLSMethods login]) {
        [self creatRefreshUnreadCountTimer];
    }
//    [self configActivityEntrance];
    [self update];
    [[UITabBar appearance]setTranslucent:false];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)update {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_update] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSString *code = responseOrignal[@"code"];
        if ([code isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal[@"data"];
            NSString *messageTitle = dic[@"title"];
            NSString *content = dic[@"content"];
            NSString *url = dic[@"downloadurl"];
            NSInteger isforced = [dic[@"isforced"] integerValue];
            NSString *version = dic[@"version"];
            NSString *localVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
            if (![version isEqualToString:localVersion]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:messageTitle message:content preferredStyle:UIAlertControllerStyleAlert];
                if (isforced == 0) {
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    }];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alertController addAction:okAction];           
                    [alertController addAction:cancelAction];
                } else {
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
                    }];
                    [alertController addAction:okAction];
                }
//                [APPDELEGATE.customTabbar presentViewController:alertController animated:YES completion:nil];
            }
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
#pragma mark - Config Activity
- (void)configActivityEntrance {
    if (_recordView) {
        [self.recordView removeFromSuperview];
        self.recordView = nil;
    }
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    for (NSDictionary *dic in activityArray) {
        if (dic[@"main"]) {
            NSDictionary *itemDic = dic[@"main"];
            self.activityDic = itemDic;
            CGFloat windowWidth = Width / 5;
            UIView *recoverView = [[UIView alloc]initWithFrame:CGRectMake(windowWidth * 2, -20, windowWidth, imageHeight)];
            recoverView.clipsToBounds = YES;
            recoverView.backgroundColor = [UIColor clearColor];
            UIImageView *activityView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, windowWidth, imageHeight)];
            activityView.contentMode = UIViewContentModeScaleAspectFill;
            activityView.clipsToBounds = YES;
            [activityView sd_setImageWithURL:[NSURL URLWithString:PARAM_IS_NIL_ERROR(itemDic[@"icon"])] placeholderImage:nil];
            activityView.userInteractionEnabled = YES;
            [recoverView addSubview:activityView];
            [self.tabBar addSubview:recoverView];
            [recoverView bringSubviewToFront:self.tabBar];
            self.recordView = recoverView;
            RLSDCNavViewController *nav = [self.childViewControllers objectAtIndex:2];
            nav.tabBarItem.title = @"123";
            nav.tabBarItem.image = nil;
            nav.tabBarItem.selectedImage = nil;
            break;
        } else {
            if (self.recordView) {
                [self.recordView removeFromSuperview];
                self.recordView = nil;
            }
        }
    }
}
- (void)updateUnreadCount:(NSNotification *)notification
{
    NSNumber *unreadNumber = [notification.userInfo objectForKey:@"unreadCount"];
    _forthNav.tabBarItem.badgeValue = unreadNumber.integerValue>Zero? unreadNumber.stringValue :nil;
}
- (void)openOrCloseRefreshUnreadCountTimer:(NSNotification *)notification{
    if ([[notification.userInfo objectForKey:@"timer"] isEqualToString:@"open"])
    {
        [self creatRefreshUnreadCountTimer];
    }else if ([[notification.userInfo objectForKey:@"timer"] isEqualToString:@"close"])
    {
        [self.refreshUnreadCountTimer invalidate];
        self.refreshUnreadCountTimer = nil;
        [self.tabBar hideBadgeOnItemIndex:4];
    }
}
- (void)creatRefreshUnreadCountTimer
{
    if (!self.refreshUnreadCountTimer) {
        self.refreshUnreadCountTimer = [NSTimer scheduledTimerWithTimeInterval:RefreshTokenAndUnreadCountTimer target:self selector:@selector(loadUreadNotificationNum) userInfo:nil repeats:YES];
    }
}
-  (void)loadUreadNotificationNum
{
    if ([RLSMethods login]) {
            if (([[NSUserDefaults standardUserDefaults] doubleForKey:@"refreshTokentime"]) < ([[NSDate date] timeIntervalSince1970]*1000)) {
                NSLog(@"token 过期");
                [self requestRefreshToken];
            }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"1" forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSNumber *unreadNoticeCount = [responseOrignal objectForKey:@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateUnreadLabNum object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:unreadNoticeCount,@"unreadNoticeCount", nil]];
            if ([unreadNoticeCount integerValue]>0) {
                [self.tabBar showBadgeOnItemIndex:4];
            }else{
                [self.tabBar hideBadgeOnItemIndex:4];
            }
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
    }
}
- (void)loadUreadNotificationNumInMineView
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"1" forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSNumber *unreadNoticeCount = [responseOrignal objectForKey:@"data"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationupdateUnreadLabNum object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:unreadNoticeCount,@"unreadNoticeCount", nil]];
            if ([unreadNoticeCount integerValue]>0) {
                [self.tabBar showBadgeOnItemIndex:4];
            }else{
                [self.tabBar hideBadgeOnItemIndex:4];
            }
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
-  (void)requestRefreshToken
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    NSString *refreshToken = [RLSMethods getTokenModel].refreshToken;
    if (!refreshToken) {
        refreshToken = @"";
    }
    [parameter setObject:refreshToken forKey:@"refreshToken"]; 
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_refreshtoken] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSString *tokenStr = [[responseOrignal objectForKey:@"data"] objectForKey:@"token"];
            NSString *refreshTokenStr = [[responseOrignal objectForKey:@"data"] objectForKey:@"refreshToken"];
            RLSTokenModel *tokenModel =  [RLSMethods getTokenModel];
            tokenModel.token = tokenStr;
            tokenModel.refreshToken = refreshTokenStr;
            [RLSMethods updateTokentModel:tokenModel];
            [[NSUserDefaults standardUserDefaults] setDouble:[[responseOrignal objectForKey:@"time"] doubleValue] forKey:@"refreshTokentime"];
            [[NSUserDefaults standardUserDefaults] setDouble:[[responseOrignal objectForKey:@"time"] doubleValue] + OutOfRefreshTokenTime forKey:@"OutOfRefreshTokenTime"];
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
#pragma mark - refreshToken 过期 -  
- (void)OutOfRefreshTokenTimeFunc {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"登陆过期" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"重新登录"];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"close",@"timer", nil]];
        [self.navigationController popViewControllerAnimated:YES];
        RLSTokenModel *tokenModel = [RLSMethods getTokenModel];
        tokenModel.token = @"";
        tokenModel.refreshToken = @"";
        [RLSMethods updateTokentModel:tokenModel];
    }];
    [alertOne setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertOne];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (BOOL)tabBar:(RLSCustmerTableBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
    self.tabBar.hidden = NO;
    [self.viewControllers[self.selectedIndex] popToRootViewControllerAnimated:NO];
    return YES;
}
- (void)setupTabbarItems {
    [_tabBarItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dic = (NSDictionary *)obj;
        BOOL loadH5 = [dic[GQTabBarItemLoadH5] integerValue];
        if (loadH5) {
            [self addChildWebControllerWithVcStr:dic[GQTableBarControllerName]
                                       imageName:dic[GQTabBarItemImage]
                                   selectedImage:dic[GQTabBarItemSelectedImage]
                                           title:dic[GQTabBarItemTitle]
                                             tag:idx
                                        webModel:dic[GQTabBarItemWbebModel]
             ];
            
        } else {
            [self addChildControllerWithVcStr:dic[GQTableBarControllerName] imageName:dic[GQTabBarItemImage] selectedImage:dic[GQTabBarItemSelectedImage] title:dic[GQTabBarItemTitle] tag:idx];
        }
    }];
}
- (void)loadTableBarViewWithArray:(NSMutableArray *)array {
    [self.tabBar removeAllSubViews];
    _taBar.itemsArr = [array copy];
    BOOL weatherAddBarView = NO;
    for (UIView *view in [self.tabBar subviews]) {
        if ([view isKindOfClass:[RLSCustmerTableBar class]]) {
            weatherAddBarView = YES;
            break;
        }
    }
    if (weatherAddBarView == NO) {
        [self.tabBar addSubview:_taBar];
    }
}
- (void)addChildControllerWithVcStr:(NSString *)vcStr
                          imageName:(UIImage *)defaultImage
                      selectedImage:(UIImage *)selectedImage
                              title:(NSString *)title
                                tag:(NSInteger)tag {
    UIEdgeInsets insets = UIEdgeInsetsMake(Zero, Zero, Zero, Zero);
    Class targetClass = NSClassFromString(vcStr);
    UIViewController *target = [[targetClass alloc]init];
    target.tabBarItem.title = title;
    target.tabBarItem.image = defaultImage;
    target.tabBarItem.selectedImage = selectedImage;
    RLSDCNavViewController *nav = [[RLSDCNavViewController alloc] initWithRootViewController:target];
    nav.interactivePopGestureRecognizer.delegate = self;
    nav.tabBarItem.imageInsets = insets;
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:redcolor} forState:UIControlStateSelected];
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBWithOX(0x646464)} forState:UIControlStateNormal];
    [self addChildViewController:nav];
}
- (void)addChildWebControllerWithVcStr:(NSString *)vcStr
                             imageName:(UIImage *)defaultImage
                         selectedImage:(UIImage *)selectedImage
                                 title:(NSString *)title
                                   tag:(NSInteger)tag
                              webModel:(RLSWebModel *)model {
    UIEdgeInsets insets = UIEdgeInsetsMake(Zero, Zero, Zero, Zero);
    Class targetClass = NSClassFromString(vcStr);
    RLSToolWebViewController *target = [[targetClass alloc]init];
    target.tabBarItem.title = title;
    target.model = model;
    target.tabBarItem.image = defaultImage;
    target.tabBarItem.selectedImage = selectedImage;
    RLSDCNavViewController *nav = [[RLSDCNavViewController alloc] initWithRootViewController:target];
    nav.interactivePopGestureRecognizer.delegate = self;
    nav.tabBarItem.imageInsets = insets;
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:redcolor} forState:UIControlStateSelected];
    [target.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBWithOX(0x646464)} forState:UIControlStateNormal];
    [self addChildViewController:nav];
}
- (void)setupTabBarStyle
{
    self.delegate = self;
}
- (void)p_didSelectCenterTabBarItem
{
    if (![self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        return;
    }
    Class targetCalss = NSClassFromString([NSString stringWithFormat:@"RLS%@",self.activityDic[@"n"]]);
    RLSToolWebViewController *target =[[targetCalss alloc] init];
    UINavigationController *nc = (UINavigationController *)self.selectedViewController;
    RLSWebModel *model = [[RLSWebModel alloc]init];
    NSDictionary *pDic = self.activityDic[@"v"];
    model.title = PARAM_IS_NIL_ERROR(pDic[@"title"]);
    model.webUrl = PARAM_IS_NIL_ERROR(pDic[@"url"]);
    model.hideNavigationBar = [pDic[@"nav_hidden"] integerValue];
    model.parameter = pDic[@"nav"];
    target.model = model;
    [nc pushViewController:target animated:YES];
    [MobClick event:@"syjc2" label:@""];
}
#pragma mark -- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([self.viewControllers indexOfObject:viewController] == 2 && self.recordView) {
        if(![RLSMethods login]) {
            [RLSMethods toLogin];
            return false;
        }

        [self p_didSelectCenterTabBarItem];
        
        return NO;
    }
    if ([self.viewControllers indexOfObject:viewController] == 0) {
        [MobClick event:@"faxian" label:@""];
        JANALYTICSBrowseEvent * event = [[JANALYTICSBrowseEvent alloc] init];
        event.name = @"home";
        [JANALYTICSService eventRecord:event];
    } else if ([self.viewControllers indexOfObject:viewController] == 1) {
        [MobClick event:@"bifen" label:@""];
        JANALYTICSBrowseEvent * event = [[JANALYTICSBrowseEvent alloc] init];
        event.name = @"expert";
        [JANALYTICSService eventRecord:event];
    } else if ([self.viewControllers indexOfObject:viewController] == 2) {
        [MobClick event:@"qingbao" label:@""];
        JANALYTICSBrowseEvent * event = [[JANALYTICSBrowseEvent alloc] init];
        event.name = @"game";
        [JANALYTICSService eventRecord:event];
    } else if ([self.viewControllers indexOfObject:viewController] == 3) {
        [MobClick event:@"tjsy" label:@""];
        JANALYTICSBrowseEvent * event = [[JANALYTICSBrowseEvent alloc] init];
        event.name = @"info";
        [JANALYTICSService eventRecord:event];
    } else if ([self.viewControllers indexOfObject:viewController] == 4) {
        [MobClick event:@"wode" label:@""];
        JANALYTICSBrowseEvent * event = [[JANALYTICSBrowseEvent alloc] init];
        event.name = @"me";
        [JANALYTICSService eventRecord:event];
    }
    if (self.selectedIndex == [self.viewControllers indexOfObject:viewController]) {
        switch (tabBarController.selectedIndex) {
            case 0:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetFirstTableViewContentOffsetZero object:nil];
            }
                break;
            case 1:
            {
            }
                break;
            case 2:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetThirdTableViewContentOffsetZero object:nil];
            }
                break;
            case 3:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetForthTableViewContentOffsetZero object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationsetForth2TableViewContentOffsetZero object:nil];
            }
                break;
            case 4:
            {
            }
                break;
            default:
                break;
        }
        return NO;
    }
    CATransition *animation  = [CATransition animation];
    [animation setType:kCATransitionFade];
    [animation setDuration:0.25];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [self.view.window.layer addAnimation:animation forKey:@"fadeTransition"];
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
- (void)pushToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation pushViewController:viewController animated:animated];
    }
}
- (void)presentToViewController:(UIViewController *__nonnull)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation presentViewController:viewController animated:animated completion:completion];
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pushToNewsWeb:(NSNotification *)nofication
{
    NSDictionary *pushInfo = nofication.userInfo;
     UIViewController *currentControl = [RLSMethods help_getCurrentVC];
    if ([pushInfo objectForKey:@"catalog"]== nil) {
        [SVProgressHUD showErrorWithStatus:@"请配置正确的内容"];
    }else{
        NSInteger eventID = [[pushInfo objectForKey:@"catalog"]integerValue];
        switch (eventID) {
            case 0://首页
            {
                self.tabBarController.selectedIndex = 0;
            }
                break;
            case 2://推荐
            {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:3 toItemIndex:0];
            }
                break;
            case 1://情报
            {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:2 toItemIndex:0];
            }
                break;
            case 3://新闻呢
            {
                RLSWebDetailViewController *webDetailVC = [[RLSWebDetailViewController alloc] init];
                webDetailVC.urlTitle = [pushInfo objectForKey:@"title"];
                webDetailVC.url = [pushInfo objectForKey:@"url"];
                webDetailVC.urlId = [pushInfo objectForKey:@"targetid"];
                webDetailVC.hidesBottomBarWhenPushed = YES;
                [currentControl.navigationController pushViewController:webDetailVC animated:YES];
            }
                break;
            case 4://直播
            {
                [ self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:4 toItemIndex:0];
            }
                break;
            case 5:
            {
                RLSTuijianDetailVC *tuijianDT = [[RLSTuijianDetailVC alloc] init];
                tuijianDT.modelId =[[pushInfo objectForKey:@"targetid"] integerValue];
                tuijianDT.typeTuijianDetailHeader = typeTuijianDetailHeaderCellDanchang;
                tuijianDT.status = 2;
                tuijianDT.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
            }
                break;
            case 6: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"胜平负";
                webModel.webUrl = [NSString stringWithFormat:@"%@/%@/spfmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 7: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"亚指";
                webModel.webUrl = [NSString stringWithFormat:@"%@/%@/yamode.html", APPDELEGATE.url_ip,H5_Host];;
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 8: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"进球数";
                webModel.webUrl = [NSString stringWithFormat:@"%@/%@/dxmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 9: {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:2 toItemIndex:0];
            }
                break;
            case 10: {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:0 toItemIndex:0];
            }
                break;
            case 11: {
                [self toFenxiWithMatchId:[pushInfo objectForKey:@"targetid"] toPageindex:1 toItemIndex:0];
            }
                break;
            case 12: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"胜平负";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/cpspfmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 13: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"亚指";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/cpyamode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 14: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"";
                webModel.webUrl =  [NSString stringWithFormat:@"https://tok-fungame.github.io/message.html?index=2", APPDELEGATE.url_ip,H5_Host];
                webModel.hideNavigationBar = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 15: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"";
                webModel.hideNavigationBar = YES;
                webModel.webUrl =  [NSString stringWithFormat:@"https://tok-fungame.github.io/message.html?index=1", APPDELEGATE.url_ip,H5_Host];
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 16: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"爆冷";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/blmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            default:
                [SVProgressHUD showErrorWithStatus:@"请配置正确的内容"];
                break;
        }
    }
}
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                RLSLiveScoreModel *model = [RLSLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                model.neutrality = NO;
                RLSFenxiPageVC *fenxiVC = [[RLSFenxiPageVC alloc] init];
                fenxiVC.model = model;
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                UIViewController *currentControl = [RLSMethods help_getCurrentVC];
                [currentControl.navigationController pushViewController:fenxiVC animated:YES];
            }
            _isToFenxi = NO;
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
        }];
    }else{
    }
}
@end

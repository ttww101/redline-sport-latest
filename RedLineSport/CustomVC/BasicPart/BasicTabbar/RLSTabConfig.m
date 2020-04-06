#import "RLSTabConfig.h"
#import "ArchiveFile.h"
#import "RLSWebModel.h"

//NSString *homePageUrl = @"http://localhost:8888/Switch/tuijianIndex.html";

@interface RLSTabConfig ()
@property (nonatomic, readwrite, strong) RLSDCTabBarController *tabBarController;
@end
@implementation RLSTabConfig
- (RLSDCTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        _tabBarController = [[RLSDCTabBarController alloc]initWithItemArray:[self loadLocalTabBarConfig]];
        [[UITabBar appearance] setTranslucent:false];
    }
    return _tabBarController;
}

- (NSArray *)loadLocalTabBarConfig {
    NSDictionary *gameTabBarItemsAttributes = [self tabBarItemControllerName:@"RLSBifenViewController" title:@"赛事" defaultImage:@"bifen" selectImage:@"bifen-1"];
    NSDictionary *newsTabBarItemsAttributes = [self tabBarItemControllerName:@"RLSNewQingBaoViewController" title:@"资讯" defaultImage:@"qingbao" selectImage:@"qingbao-1"];
    
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"首页";
    model.webUrl = [NSString stringWithFormat:homePageUrl, APPDELEGATE.url_ip,H5_Host];
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"tuijianIndex" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
//    model.webUrl = [NSString stringWithFormat:@"file://%@", path];
    model.hideNavigationBar = YES;
    NSDictionary *homeTabBarItemsAttributes = @{
                                                 GQTableBarControllerName : @"RLSToolWebViewController",
                                                 GQTabBarItemTitle : @"首页",
                                                 GQTabBarItemImage : [[UIImage imageNamed:@"shouye"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                 GQTabBarItemSelectedImage : [[UIImage imageNamed:@"shouye-select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                 GQTabBarItemWbebModel : model,
                                                 GQTabBarItemLoadH5 : @(1)
                                                 };
    RLSWebModel *expertModel = [[RLSWebModel alloc]init];
    expertModel.title = @"首页";
    expertModel.webUrl = [NSString stringWithFormat:@"https://tok-fungame.github.io/speciallist-hots.html?type=0", APPDELEGATE.url_ip,H5_Host];
    expertModel.hideNavigationBar = YES;
    NSDictionary *expertTabBarItemsAttributes = @{
                                                GQTableBarControllerName : @"RLSToolWebViewController",
                                                GQTabBarItemTitle : @"专家",
                                                GQTabBarItemImage : [[UIImage imageNamed:@"tab-find"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                GQTabBarItemSelectedImage : [[UIImage imageNamed:@"tab-find-select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
                                                GQTabBarItemWbebModel : expertModel,
                                                GQTabBarItemLoadH5 : @(1)
                                                };
    
    NSDictionary *aboutMeTabBarItemsAttributes = [self tabBarItemControllerName:@"RLSMineViewController" title:@"我的" defaultImage:@"wode" selectImage:@"wode-1"];
    NSArray *array = @[homeTabBarItemsAttributes, expertTabBarItemsAttributes, gameTabBarItemsAttributes,  newsTabBarItemsAttributes, aboutMeTabBarItemsAttributes];
    return array;
}
- (NSDictionary *)tabBarItemControllerName:(NSString *)name
                                       title:(NSString *)title
                                defaultImage:(NSString *)defaultImaeg
                                 selectImage:(NSString *)selectImage; {
    return @{
             GQTableBarControllerName : name,
             GQTabBarItemTitle : title,
             GQTabBarItemImage : [[UIImage imageNamed:defaultImaeg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             GQTabBarItemSelectedImage : [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
             };
}
@end

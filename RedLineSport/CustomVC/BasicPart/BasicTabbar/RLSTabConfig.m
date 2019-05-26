#import "RLSTabConfig.h"
#import "ArchiveFile.h"
#import "RLSWebModel.h"
@interface RLSTabConfig ()
@property (nonatomic, readwrite, strong) RLSDCTabBarController *tabBarController;
@end
@implementation RLSTabConfig
- (RLSDCTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        _tabBarController = [[RLSDCTabBarController alloc]initWithItemArray:[self tabBarItemArray]];
        [[UITabBar appearance] setTranslucent:false];
    }
    return _tabBarController;
}
- (NSArray *)tabBarItemArray {
//    NSMutableArray *array = [ArchiveFile getDataWithPath:TableConfig];
//    if (array.count > 0) {
//        return [self loadServerTableBarConfigWithArray:array];
//    } else {
//        return [self loadLocalTableBarConfig];
//    }
    return [self loadLocalTableBarConfig];
}
//- (NSArray *)loadServerTableBarConfigWithArray:(NSArray *)array {
//    __block NSMutableArray *dataArray = [NSMutableArray new];
//    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *imageUrl = obj[@"defaultImage"];
//        NSString *selectImageUrl = obj[@"selectImage"];
//        UIImage *defaultImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl];
//        UIImage *selectImage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:selectImageUrl];
//        BOOL loadLineImage = false;
//        if (!defaultImage) {
//            if (idx == 0) {
//                defaultImage = [UIImage imageNamed:@"shouye"];
//            } else if (idx == 1) {
//                defaultImage = [UIImage imageNamed:@"bifen"];
//            } else if (idx == 2) {
//                 defaultImage = [UIImage imageNamed:@"qingbao"];
//            } else if (idx == 3) {
//                 defaultImage = [UIImage imageNamed:@"tuijian"];
//            } else if (idx == 4) {
//                 defaultImage = [UIImage imageNamed:@"wode"];
//            } else if (idx == 5) {
//                defaultImage = [UIImage imageNamed:@"qingbao"];
//            }
//            loadLineImage = YES;
//        }
//        if (!selectImage) {
//            if (idx == 0) {
//                selectImage = [UIImage imageNamed:@"shouye-1"];
//            } else if (idx == 1) {
//                selectImage = [UIImage imageNamed:@"bifen-1"];
//            } else if (idx == 2) {
//                selectImage = [UIImage imageNamed:@"qingbao-1"];
//            } else if (idx == 3) {
//                selectImage = [UIImage imageNamed:@"tuijian-1"];
//            } else if (idx == 4) {
//                selectImage = [UIImage imageNamed:@"wode-1"];
//            } else if (idx == 5) {
//                selectImage = [UIImage imageNamed:@"qingbao-1"];
//            }
//            loadLineImage = YES;
//        }
//        BOOL loadH5 = [obj[@"loadH5"] integerValue];
//        if (loadH5) {
//            RLSWebModel *model = [[RLSWebModel alloc]init];
//            model.title = obj[@"title"];
//            model.webUrl = obj[@"url"];
//            model.parameter = @{@"nav": PARAM_IS_NIL_ERROR(obj[@"nav"])};
//            model.hideNavigationBar = [obj[@"nav_hidden"] integerValue];
//            model.fromTab = YES;
//            [dataArray addObject:@{
//                                   GQTableBarControllerName : @"RLSToolWebViewController",
//                                   GQTabBarItemTitle : obj[@"title"],
//                                   GQTabBarItemImage : [defaultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                                   GQTabBarItemSelectedImage : [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                                   GQTabBarItemLoadH5 : @(loadH5),
//                                   GQTabBarItemWbebModel : model
//                                   }];
//        } else {
//            NSString *className = [NSString stringWithFormat:@"RLS%@",PARAM_IS_NIL_ERROR(obj[@"className"])];
//            if ([className isEqualToString:@"RLSGQMineViewController"]) {
//                className = @"RLSMineViewController";
//            }
//            [dataArray addObject:@{
//                                   GQTableBarControllerName : className,
//                                   GQTabBarItemTitle : obj[@"title"],
//                                   GQTabBarItemImage : [defaultImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],
//                                   GQTabBarItemSelectedImage : [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                   }];
//        }
//        if (idx == array.count - 1) {
//            if (loadLineImage) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [self reloadTableBarImage];
//                });
//            }
//        }
//    }];
//    return dataArray;
//}
//- (void)reloadTableBarImage {
//    NSMutableArray *array = [ArchiveFile getDataWithPath:TableConfig];
//    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSString *imageUrl = obj[@"defaultImage"];
//        NSString *selectImageUrl = obj[@"selectImage"];
//        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:imageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        }];
//        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:selectImageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        }];
//    }];
//}
- (NSArray *)loadLocalTableBarConfig {
    NSDictionary *gameTabBarItemsAttributes = [self tableBarItemControllerName:@"RLSBifenViewController" title:@"赛事" defaultImage:@"bifen" selectImage:@"bifen-1"];
    NSDictionary *newsTabBarItemsAttributes = [self tableBarItemControllerName:@"RLSNewQingBaoViewController" title:@"资讯" defaultImage:@"qingbao" selectImage:@"qingbao-1"];
    
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"首页";
    model.webUrl = [NSString stringWithFormat:@"https://tok-fungame.github.io/tuijianIndex.html", APPDELEGATE.url_ip,H5_Host];
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
    
    NSDictionary *aboutMeTabBarItemsAttributes = [self tableBarItemControllerName:@"RLSMineViewController" title:@"我的" defaultImage:@"wode" selectImage:@"wode-1"];
    NSArray *array = @[homeTabBarItemsAttributes, expertTabBarItemsAttributes, gameTabBarItemsAttributes,  newsTabBarItemsAttributes, aboutMeTabBarItemsAttributes];
    return array;
}
- (NSDictionary *)tableBarItemControllerName:(NSString *)name
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

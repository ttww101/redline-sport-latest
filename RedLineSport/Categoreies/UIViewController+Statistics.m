//
//  UIViewController+Statistics.m
//  newGQapp
//
//  Created by genglei on 2018/8/3.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "UIViewController+Statistics.h"
#import "RLSAspectManager.h"

@implementation UIViewController (Statistics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalViewWillAppear = @selector(viewWillAppear:);
        SEL swiz_ViewWillAppear = @selector(swiz_viewWillAppear:);
        Method originAppearMethod = class_getInstanceMethod([self class], originalViewWillAppear);
        Method swizAppearMethod = class_getInstanceMethod([self class], swiz_ViewWillAppear);
        BOOL didAddAppearMethod = class_addMethod([self class], originalViewWillAppear, method_getImplementation(swizAppearMethod), method_getTypeEncoding(swizAppearMethod));
        if (didAddAppearMethod) {
            class_replaceMethod([self class], swiz_ViewWillAppear, method_getImplementation(originAppearMethod), method_getTypeEncoding(originAppearMethod));
        } else {
            method_exchangeImplementations(originAppearMethod, swizAppearMethod);
        }
        
        SEL disappearSelector = @selector(viewWillDisappear:);
        SEL swiz_DisappearSelector = @selector(swiz_ViewDisappear:);
        Method disappearMethod = class_getInstanceMethod([self class], disappearSelector);
        Method swiz_disappearMethod = class_getInstanceMethod([self class], swiz_DisappearSelector);
        BOOL didAddDisappearMethod = class_addMethod([self class], disappearSelector, method_getImplementation(swiz_disappearMethod), method_getTypeEncoding(swiz_disappearMethod));
        if (didAddDisappearMethod) {
            class_replaceMethod([self class], swiz_DisappearSelector, method_getImplementation(disappearMethod), method_getTypeEncoding(disappearMethod));
        } else {
            method_exchangeImplementations(disappearMethod, swiz_disappearMethod);
        }
        
    });
}

- (void)swiz_viewWillAppear:(BOOL)animated {
    NSString *classNmae = NSStringFromClass([self class]);
    NSMutableDictionary *dic = [RLSAspectManager GQ_PathForPageDic];
    NSDictionary *pageDic = dic[@"pageDic"];
    NSString *pageName = pageDic[classNmae];
    if (pageName.length > 0 && pageName != nil) {
        [MobClick beginLogPageView:pageName];
    }
    [self swiz_viewWillAppear:animated];
}

- (void)swiz_ViewDisappear:(BOOL)animated {
    NSString *classNmae = NSStringFromClass([self class]);
    NSMutableDictionary *dic = [RLSAspectManager GQ_PathForPageDic];
    NSDictionary *pageDic = dic[@"pageDic"];
    NSString *pageName = pageDic[classNmae];
    if (pageName.length > 0 && pageName != nil) {
        [MobClick endLogPageView:pageName];
    }
    [self swiz_ViewDisappear:animated];
}



@end

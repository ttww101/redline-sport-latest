#ifndef GunQiuLive_Device_h
#define GunQiuLive_Device_h
#define isOniPhone4 ([UIScreen mainScreen].bounds.size.height == 480)
#define isOniPhone5 ([UIScreen mainScreen].bounds.size.height == 568)
#define isOniphone6 ([UIScreen mainScreen].bounds.size.height == 667)
#define isOniphone7 ([UIScreen mainScreen].bounds.size.height == 667)
#define isOniphone6p ([UIScreen mainScreen].bounds.size.height >= 736)
#define Height [UIScreen mainScreen].bounds.size.height
#define Width  [UIScreen mainScreen].bounds.size.width
#define Screen_Base_Width 375.0
#define Scale_Ratio_width [UIScreen mainScreen].bounds.size.width/375.0
#define Scale_Ratio_height [UIScreen mainScreen].bounds.size.height/667.0
#define Scale_Ratio (1)
#define Scale_Value(a) a * Scale_Ratio_width
#define _StatusBarHeight (![UIApplication sharedApplication].statusBarHidden ? [UIApplication sharedApplication].statusBarFrame.size.height : 0)
#define _ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define _ScrrenWidth ([UIScreen mainScreen].bounds.size.width)
#define _TabBarHeight (self.tabBarController ? (!self.tabBarController.hidesBottomBarWhenPushed ? self.tabBarController.tabBar.frame.size.height : 0): 0)
#define _NaviBarHeight (self.navigationController ? (!self.navigationController.navigationBarHidden ? (self.navigationController.navigationBar.frame.size.height + _StatusBarHeight) : 0): 0)
#define _ContentHeight (_ScreenHeight - _TabBarHeight - _NaviBarHeight)
#define STOREAPPID @"1116339458"
#define FONT_DIN_Bold_SIZE(s)                         [UIFont fontWithName:@"DIN-Bold" size:s]
#define font7 [UIFont systemFontOfSize:(7*Scale_Ratio)]
#define font8 [UIFont systemFontOfSize:(8*Scale_Ratio)]
#define font9 [UIFont systemFontOfSize:(9*Scale_Ratio)]
#define font10 [UIFont systemFontOfSize:(10*Scale_Ratio)]
#define font11 [UIFont systemFontOfSize:(11*Scale_Ratio)]
#define font12 [UIFont systemFontOfSize:(12*Scale_Ratio)]
#define font13 [UIFont systemFontOfSize:(13*Scale_Ratio)]
#define font14 [UIFont systemFontOfSize:(14*Scale_Ratio)]
#define font15 [UIFont systemFontOfSize:(15*Scale_Ratio)]
#define font16 [UIFont systemFontOfSize:(16*Scale_Ratio)]
#define font17 [UIFont systemFontOfSize:(17*Scale_Ratio)]
#define font18 [UIFont systemFontOfSize:(18*Scale_Ratio)]
#define font20 [UIFont systemFontOfSize:(20*Scale_Ratio)]
#define font22 [UIFont systemFontOfSize:(22*Scale_Ratio)]
#define font23 [UIFont systemFontOfSize:(23*Scale_Ratio)]
#define font24 [UIFont systemFontOfSize:(24*Scale_Ratio)]
#define font25 [UIFont systemFontOfSize:(25*Scale_Ratio)]
#define font20 [UIFont systemFontOfSize:(20*Scale_Ratio)]
#define font28 [UIFont systemFontOfSize:(28*Scale_Ratio)]
#define font30 [UIFont systemFontOfSize:(30*Scale_Ratio)]
#define font32 [UIFont systemFontOfSize:(32*Scale_Ratio)]
#define fontSize7 (7*Scale_Ratio)
#define fontSize8 (8*Scale_Ratio)
#define fontSize9 (9*Scale_Ratio)
#define fontSize10 (10*Scale_Ratio)
#define fontSize11 (11*Scale_Ratio)
#define fontSize12 (12*Scale_Ratio)
#define fontSize13 (13*Scale_Ratio)
#define fontSize14 (14*Scale_Ratio)
#define fontSize15 (15*Scale_Ratio)
#define fontSize16 (16*Scale_Ratio)
#define fontSize17 (17*Scale_Ratio)
#define fontSize18 (18*Scale_Ratio)
#define fontSize19 (19*Scale_Ratio)
#define fontSize20 (20*Scale_Ratio)
#define fontSize21 (21*Scale_Ratio)
#define fontSize22 (22*Scale_Ratio)
#define fontSize23 (23*Scale_Ratio)
#define fontSize24 (24*Scale_Ratio)
#define fontSize25 (25*Scale_Ratio)
#define fontSize26 (26*Scale_Ratio)
#define fontSize27 (27*Scale_Ratio)
#define fontSize28 (28*Scale_Ratio)
#define fontSize29 (29*Scale_Ratio)
#define fontSize30 (30*Scale_Ratio)
#define fontSize31 (31*Scale_Ratio)
#define navFont BoldFont6(fontSize18)
#
#define BoldFont0(size) [UIFont systemFontOfSize:size weight:UIFontWeightUltraLight]
#define BoldFont1(size) [UIFont systemFontOfSize:size weight:UIFontWeightThin]
#define BoldFont2(size) [UIFont systemFontOfSize:size weight:UIFontWeightLight]
#define BoldFont3(size) [UIFont systemFontOfSize:size weight:UIFontWeightRegular]
#define BoldFont4(size) [UIFont systemFontOfSize:size weight:UIFontWeightMedium]
#define BoldFont5(size) [UIFont systemFontOfSize:size weight:UIFontWeightSemibold]
#define BoldFont6(size) [UIFont systemFontOfSize:size weight:UIFontWeightBold]
#define BoldFont7(size) [UIFont systemFontOfSize:size weight:UIFontWeightHeavy]
#define BoldFont8(size) [UIFont systemFontOfSize:size weight:UIFontWeightBlack]
#define ONE_PX_LINE 1.0f / [UIScreen mainScreen].scale
#endif

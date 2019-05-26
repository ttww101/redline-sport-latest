#import "RLSMethods.h"
#ifndef GunQiuLive_Numbers_h
#define GunQiuLive_Numbers_h
#define Zero             (0)
#define UnreadCountTimer (600)
#define RefreshTokenAndUnreadCountTimer (60*9)
#define heightBifenTitleView (44)
#define heightFormLine  (30)
#define spaceFanTitle (10)
#define cellTongjiHeight (29)
#define heightLabtextOneline ([@"一行特定文字的高度" boundingRectWithSize:CGSizeMake(Width - 20, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil] context:nil].size.height + 4)
#define heightLabtextOnelineWithoutSpace ([@"一行特定文字的高度" boundingRectWithSize:CGSizeMake(Width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil] context:nil].size.height)
#define widthOneWordFont13 ([@"家" boundingRectWithSize:CGSizeMake(Width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil] context:nil].size.width)
#define heightLineSpace (4)
#define heightHeaderIndent (25)
#define RequestRefreshTokenTime (60*60*1000)
#define OutOfRefreshTokenTime (60*60*1000*24*31*1000)
#define PARAM_IS_NIL_ERROR(param) ((param == nil || [param isKindOfClass:[NSNull class]]) ? @"" : param)
#define ScreenRatio (Width / 375.f)
#define PADDING_OF_LEFT_STEP_LINE 21
#define PADDING_OF_LEFT_RIGHT 15
#define WIDTH_OF_PROCESS_LABLE (300 *[UIScreen mainScreen].bounds.size.width / 375)

#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)
#endif

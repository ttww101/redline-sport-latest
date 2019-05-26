typedef NS_ENUM(NSInteger, weekType)
{
    weekTypeXingqi = 0,
    weekTypeZhou = 1,
};
#import <Foundation/Foundation.h>
#import "RLSUserModel.h"
#import "RLSTokenModel.h"
@interface RLSMethods : NSObject
@property (nonatomic) weekType weektype;
+ (NSArray *)seperateNSString:(NSString *)str
                     bySimple:(NSString *)simple;
+ (NSString *)getCurrentDateByStyle:(NSString *)dateStyle;
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
+ (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day;
+ (NSArray *)getDateByDate:(NSDate *)dateDate withWeekType:(weekType)type;
+ (NSDate *)changeDateToChineseDateWithDate:(NSDate *)OOdate;
+ (NSString *)getDateByStyle:(NSString *)dateStyle withDate:(NSDate *)date;
+ (int)getIntNumberComparedWithNowDate:(NSString *)nowDate ForDate:(NSString *)date;
+ (int)getIndexNumberForDate:(NSString *)date withNowDate:(NSDate *)nowDate;
+ (NSDate *)getDateFromString:(NSString *)dateString byformat:(NSString *)format;
+ (NSString *)timeToNowWith:(NSTimeInterval)time;
+ (CATransition *)setTransitionwithType:(NSString *)transitonType;
+ (UIWindow *)getMainWindow;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
+ (UIImage*) imageBlackToTransparent:(UIImage*) image withRed:(float)r Green:(float)g Blue:(float)b;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isNameValid:(NSString *)name;
+ (BOOL) chk18PaperId:(NSString *) sPaperId;
+ (NSString *)getDocumentsPath;
+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;
+ (NSString *)intervalFromLastDateAnd45: (NSString *) dateString1  toTheDate:(NSString *) dateString2;
+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isPureFloat:(NSString*)string;
+ (UIColor *)getColor:(NSString *)hexColor;
+ (CGFloat)getTextWidthSize:(NSString *)home strfont:(UIFont *)fontNum;
+ (CGFloat)getTextHeightStationWidth:(NSString *)string anWidthTxtt:(CGFloat)widthText anfont:(CGFloat)fontSize andLineSpace:(CGFloat)linespace andHeaderIndent:(CGFloat)indent;
+ (NSMutableAttributedString *)setTextStyleWithString:(NSString *)str WithLineSpace:(CGFloat)linespace WithHeaderIndent:(CGFloat)indet;
+ (NSString *)md5WithString:(NSString *)str;
+ (RLSUserModel *)getUserModel;
+ (RLSTokenModel *)getTokenModel;
+ (void)updateUsetModel:(RLSUserModel *)model;
+ (void)updateTokentModel:(RLSTokenModel *)model;
+(void)clearUserModel;
+ (BOOL)login;
+ (void)toLogin;
+ (NSMutableAttributedString *)withContent:(NSString *)content contentColor:(UIColor *)contentColor WithColorText:(NSString *)text textColor:(UIColor *)textColor;
+ (NSMutableAttributedString *)withContent:(NSString *)content  WithColorText:(NSString *)text  textColor:(UIColor *)textColor strFont:(UIFont *)stringfont;
+ (NSMutableAttributedString *)withContent:(NSString *)content
                             WithContColor:(UIColor *)ContentColor
                           WithContentFont:(UIFont *)contentFont
                                  WithText:(NSString *)text
                             WithTextColor:(UIColor *)textColor
                              WithTextFont:(UIFont *)textFont;
+ (NSString *)getTextByMatchState:(NSInteger)matchState;
+ (BOOL)panduan:(NSInteger)mode permission:(NSInteger)permission;
+ (UIImage *)captureImageFromView:(UIView *)view;
+ (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL;
+ (CGFloat)widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height;
+ (CGFloat) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width;
+ (UIImage *)defaultPlaceHolderImage:(NSString *)imageName;


+ (NSString *)formatHHSSStamp:(NSUInteger)timeStamp;
+ (NSString *)formatMMDDWithStamp:(NSUInteger)timeStamp;
+ (NSUInteger)formatTimeStr:(NSString *)timeStr;
+ (NSInteger)amountWithProductId:(NSString *)productId;
+ (NSString *)compareCurrentTime:(NSString *)str;
+ (NSString*)iphoneType;
+ (NSString *)amountFormater:(NSString *)amountValue;
+ (NSString *)formatYYMMDDWithStamp:(NSUInteger)timeStamp;
+ (UIViewController *)help_getCurrentVC;
+ (NSString *)getPersonLeavelImageName:(NSInteger)leavel;
+ (NSString *)removeHTML:(NSString *)html;
+ (NSString *)filterHTML:(NSString *)html;

@end

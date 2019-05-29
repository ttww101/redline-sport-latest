typedef NS_ENUM(NSInteger, loadDataType)
{
    loadDataFirst = 1,
    loadDataByindex = 2,
    loadDataByorderindex = 3,
    loadDataMoredata =4,
    loadDataHeaderRefesh = 5,
    loadDataReload = 6,
};
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^requestStart)(id requestOrignal);
typedef void(^requestEnd)(id responseOrignal);
typedef void(^requestSuccess)(id responseResult,id responseOrignal);
typedef void(^requestFailure)(NSError *error, NSString *errorDict,id responseOrignal);
@interface RLSDCHttpRequest : NSObject
@property (nonatomic, copy) NSString        *contentType;
+ (RLSDCHttpRequest *)shareInstance;
+ (RLSDCHttpRequest *)guestInstance;
- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure;
- (void)sendGetRequestByMethod:(NSString *)post
                WithParamaters:(NSDictionary *)parameters
                      PathUrlL:(NSString *)pathUrl
                         Start:(requestStart)start
                           End:(requestEnd)end
                       Success:(requestSuccess)success
                       Failure:(requestFailure)failure;
- (void)sendHtmlGetRequestByMethod:(NSString *)post
                WithParamaters:(NSDictionary *)parameters
                      PathUrlL:(NSString *)pathUrl
                         Start:(requestStart)start
                           End:(requestEnd)end
                       Success:(requestSuccess)success
                       Failure:(requestFailure)failure;
- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                   FileName:(NSString *)filename
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure;
@end

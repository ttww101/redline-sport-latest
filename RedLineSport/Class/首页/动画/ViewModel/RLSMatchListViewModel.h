#import <Foundation/Foundation.h>
#import "RLSLiveListModel.h"
typedef void (^requestCallBack)(BOOL isSuccess, id response);
@interface RLSMatchListViewModel : NSObject
- (void)fetchMatchDateInterfaceWithParameter:(id)parameter  callBack:(requestCallBack)response;
@end

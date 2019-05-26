#import <Foundation/Foundation.h>
@interface RLSWebModel : NSObject
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* category;
@property (nonatomic, copy) NSString* webUrl;
@property (nonatomic, copy) NSString* htmlUrl;
@property (nonatomic, strong) id parameter;
@property (nonatomic , copy) NSString *registerActionName;
@property (nonatomic , copy) NSString *callHandleActionName;
@property (nonatomic , assign) BOOL hideNavigationBar;
@property (nonatomic , assign) BOOL showBuyBtn;
@property (nonatomic , copy) NSString *modelType;
@property (nonatomic , assign) BOOL fromTab;
@end

#import <UIKit/UIKit.h>
@class RLSCustmerTableBar;
@protocol TabBarDelegate <NSObject>
@optional
- (BOOL)tabBar:(RLSCustmerTableBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to;
- (void)tabBar:(RLSCustmerTableBar *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to viewController:(UIViewController *)viewController;
@end
@interface RLSCustmerTableBar : UIView
@property (nonatomic, assign) BOOL isLoad; 
@property(nonatomic, strong) NSArray *itemsArr;
@property(nonatomic, weak) id <TabBarDelegate> delegate;
@property(nonatomic, assign) NSInteger selected;
@property(nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray* arrayDefluts;
@property (nonatomic, strong) NSArray* arraySelects;
@end

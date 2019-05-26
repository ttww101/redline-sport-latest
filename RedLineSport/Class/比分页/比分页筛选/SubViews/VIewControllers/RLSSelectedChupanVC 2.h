#import "RLSSelectedAllVC.h"
#import "RLSBasicViewController.h"
@protocol SelectedChupanVCDelegate <NSObject>
@optional
- (void)confirmSelectedChupanWithData:(NSArray *)arrSaveData;
@end
@interface RLSSelectedChupanVC : RLSBasicViewController
@property (nonatomic, weak) id<SelectedChupanVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic) typeSaishiSelecterdVC type;
@property (nonatomic , copy) NSString *date; //timeline 是live时 date 变量无效，赛程或赛果 传入具体的查询日期 2018-11-26
@property (nonatomic , copy) NSString *filterParameters;
@end

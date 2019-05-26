#import "RLSSelectedAllVC.h"
#import "RLSBasicViewController.h"
@protocol SelectedJincaiVCDelegate <NSObject>
@optional
- (void)confirmSelectedJincaiWithData:(NSArray *)arrSaveData;
@end
@interface RLSSelectedJincaiVC : RLSBasicViewController
@property (nonatomic, weak) id<SelectedJincaiVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic) typeSaishiSelecterdVC type;

@property (nonatomic) NSString *tab; //sclass （赛事,默认）or pankou_rq （让球盘口）or pankou_dx （大小盘口）
@property (nonatomic) NSString *timeline; // live 即时(默认)，old 赛果，new 赛程
@property (nonatomic , copy) NSString *date; //timeline 是live时 date 变量无效，赛程或赛果 传入具体的查询日期 2018-11-26
@property (nonatomic , copy) NSString *filterParameters;

@end

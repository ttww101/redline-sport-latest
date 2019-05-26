#import <UIKit/UIKit.h>
@protocol NewQingbaoTableViewDelegate <NSObject>
- (void)headerRefreshNewQB;
@end
@interface RLSNewQingbaoTableView : RLSBasicTableView
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrhomeInfo;
@property (nonatomic, strong) NSArray *arrawayInfo;
@property (nonatomic, strong) NSArray *arrneutralInfo;
@property (nonatomic, strong) NSMutableArray *jiDianArr;
@property (nonatomic, weak) id<NewQingbaoTableViewDelegate>delegateNewQB;
@property (nonatomic, assign) BOOL cellCanScroll;

@property (nonatomic, assign) NSInteger matchID;

@property (nonatomic , copy) NSDictionary *feeDic;


@end

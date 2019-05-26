typedef NS_ENUM(NSInteger, typeSaishiSelecterdVC)
{
    typeSaishiSelecterdVCBifen = 0,
    typeSaishiSelecterdVCTuijian = 1,
    typeSaishiSelecterdVCInfo = 2,
};

typedef NS_ENUM(NSUInteger, PlayType) {
    PlayTypeAll,
    PlayTypejingcai,
    PlayTypezucai,
    PlayTypebeidan,
};
#import "RLSBasicViewController.h"
@protocol SelectedAllVCDelegate <NSObject>
@optional
- (void)confirmSelectedAllWithData:(NSArray *)arrSaveData;
@end
@interface RLSSelectedAllVC : RLSBasicViewController

@property (nonatomic, weak) id<SelectedAllVCDelegate> delegate;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic) typeSaishiSelecterdVC type;

@property (nonatomic) PlayType playType;
@property (nonatomic) NSString *sub; // jc 竞猜 or zc 足彩 or bd 北单 or all 全部，默认
@property (nonatomic) NSString *timeline; // live 即时(默认)，old 赛果，new 赛程
@property (nonatomic , copy) NSString *date; //timeline 是live时 date 变量无效，赛程或赛果 传入具体的查询日期 2018-11-26
@property (nonatomic , copy) NSString *filterParameters;

@end

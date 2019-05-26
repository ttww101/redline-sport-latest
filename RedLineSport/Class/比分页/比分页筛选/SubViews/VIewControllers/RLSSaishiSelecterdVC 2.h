#import "RLSViewPagerController.h"
#import "RLSSelectedAllVC.h"
#import "RLSSelectedJincaiVC.h"
#import "RLSSelectedChupanVC.h"
#import "RLSBasicViewController.h"


UIKIT_EXTERN NSString *const FilterPageNotification;
UIKIT_EXTERN NSString *const ParamtersTab;   // sclass （赛事,默认）or pankou_rq （让球盘口）or pankou_dx （大小盘口）
UIKIT_EXTERN NSString *const ParamtersSub;   // jc 竞猜 or zc 足彩 or bd 北单 or all 全部，默认
UIKIT_EXTERN NSString *const ParamtersTimeline;  // live 即时(默认)，old 赛果，new 赛程
UIKIT_EXTERN NSString *const ParamtersFilters;  // {“key”:”sclasss” ,”val”:[44,55,66,88]} key 检索项目 sclasss，pankou_rq，pankou_dx 三选一 ,val检索值
UIKIT_EXTERN NSString *const ParamtersType;

UIKIT_EXTERN NSString *const localLive; // 及时筛选存本地
UIKIT_EXTERN NSString *const localOld; // 及时筛选存本地
UIKIT_EXTERN NSString *const localNew; // 及时筛选存本地



@interface RLSSaishiSelecterdVC : RLSViewPagerController
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSArray *arrDataJingcai;
@property (nonatomic, strong) NSArray *arrDataChupan;
@property (nonatomic, assign)NSInteger jincai;
@property (nonatomic) typeSaishiSelecterdVC type;
@property (nonatomic, strong) NSArray *arrBifenData;
@property (nonatomic, strong) NSArray *arrTuijianSelectedData;
@property (nonatomic, strong) NSArray *arrInfoSelectedData;

@property (nonatomic , copy) NSString *timeline; // live 即时(默认)，old 赛果，new 赛程
@property (nonatomic , copy) NSString *date; //timeline 是live时 date 变量无效，赛程或赛果 传入具体的查询日期 2018-11-26
@property (nonatomic , copy) NSString *filterParameters;

@end

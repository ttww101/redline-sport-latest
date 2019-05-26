#import "RLSLiveViewController.h"
#import "RLSLiveListViewController.h"
@interface RLSLiveViewController () <TYTabPagerControllerDataSource, TYTabPagerControllerDelegate, TYTabPagerBarDelegate>
@property (nonatomic, strong) NSArray *newsPageInfos;
@end
@implementation RLSLiveViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self configurePagerStyles];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configurePagerStyles];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self configureTabButtonPager];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
}
- (void)dealloc {
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)configurePagerStyles
{
    self.tabBarHeight = 44;
}
- (void)configureTabButtonPager {
    self.dataSource = self;
    self.delegate = self;
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    self.tabBar.layout.normalTextFont = [UIFont systemFontOfSize:17];
    self.tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:20];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.layout.normalTextColor = ColorWithRGBA(111, 111, 111, 1);
    self.tabBar.layout.selectedTextColor = UIColorFromRGBWithOX(0x37B1DA);
    self.tabBar.layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.tabBar.layout.cellWidth = 0;
    self.tabBar.layout.cellEdging = 0;
    self.tabBar.layout.adjustContentCellsCenter = YES;
    self.tabBar.delegate = self;
    self.tabBar.layout.cellSpacing = 20;
    self.tabBar.layout.progressColor = UIColorFromRGBWithOX(0x37B1DA);
}
#pragma mark - load data
- (void)loadData{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:@"http://api.live.gunqiu.com:88/radar?action=getDays" Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSDictionary *dic = (NSDictionary *)responseOrignal;
        NSString *code = [dic[@"code"] stringValue];
        if ([code isEqualToString:@"1"]) {
            NSDictionary *listDic = dic[@"data"];
            NSArray *array = listDic[@"data"];
            NSInteger index = [listDic[@"active"] integerValue];
            self.newsPageInfos = array;
            [self reloadData];
            [self scrollToControllerAtIndex:index animate:YES];
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
        NSLog(@"%@ ",responseOrignal);
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
         [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)tryAgainAtExceptionView {
    [self loadData];
}
#pragma mark - TYTabPagerBarDelegate
- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSDictionary *newsPageInfo = _newsPageInfos[index];
    CGFloat width = [RLSMethods widthForString:newsPageInfo[@"name"] fontSize:17.f andHeight:0];
    return width;
}
#pragma mark - TYPagerControllerDataSource
- (NSInteger)numberOfControllersInTabPagerController
{
    return _newsPageInfos.count;
}
- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index
{
    NSDictionary *newsPageInfo = _newsPageInfos[index];
    NSString *title = [newsPageInfo objectForKey:@"name"];
    return title ? title : @"";
}
- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    NSDictionary *newsPageInfo = _newsPageInfos[index];
    RLSLiveListViewController *control = [[RLSLiveListViewController alloc]init];
    control.dayID = newsPageInfo[@"day"];
    return control;
}
#pragma mark - Config UI
- (void)configUI {
    self.navigationItem.title = @"足球";
}
@end

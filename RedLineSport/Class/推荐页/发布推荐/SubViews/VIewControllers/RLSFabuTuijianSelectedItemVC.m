#import "RLSTitleIndexView.h"
#import "RLSFabuTuijianSelectedItemVC.h"
#import "RLSDan_StringGuanVC.h"
@interface RLSFabuTuijianSelectedItemVC ()<ViewPagerDataSource,ViewPagerDelegate,TitleIndexViewDelegate>
@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, strong)RLSTitleIndexView *titleView;
@end
@implementation RLSFabuTuijianSelectedItemVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"发布推荐";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    _titleView = [[RLSTitleIndexView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, 44)];
    _titleView.selectedIndex = 0;
    _titleView.nalColor = color33;
    _titleView.seletedColor = redcolor;
    _titleView.lineColor = redcolor;
    _titleView.bottomLineColor = colorCellLine;
    _titleView.backgroundColor = [UIColor whiteColor];
    _titleView.arrData = @[@"竞彩",@"北单",@"足彩",@"全部"];
    _titleView.delegate =self;
    [self.view addSubview:_titleView];
    self.delegate = self;
    self.dataSource = self;
    self.manualLoadData = YES;
    self.currentIndex = 0;
    self.scrollingLocked = NO;
    [self reloadData];
}
- (void)didSelectedAtIndex:(NSInteger)index
{
    UIPageViewControllerNavigationDirection direction;
    if (index < _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else{
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    UIViewController *viewController = [self viewControllerAtIndex:index];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}
- (NSUInteger)numberOfTabsForViewPager:(RLSViewPagerController *)viewPager;
{
    return 4;
}
- (UIViewController *)viewPager:(RLSViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            RLSDan_StringGuanVC *fabuTuijianVC = [[RLSDan_StringGuanVC alloc] init];
            fabuTuijianVC.jsonStr = @"jc";
            return fabuTuijianVC;
        }
            break;
        case 1:
        {
            RLSDan_StringGuanVC *fabuTuijianVC = [[RLSDan_StringGuanVC alloc] init];
            fabuTuijianVC.jsonStr = @"bd";
            return fabuTuijianVC;
        }
            break;
        case 2:
        {
            RLSDan_StringGuanVC *fabuTuijianVC = [[RLSDan_StringGuanVC alloc] init];
            fabuTuijianVC.jsonStr = @"zc";
            return fabuTuijianVC;
        }
            break;
        case 3:
        {
            RLSDan_StringGuanVC *fabuTuijianVC = [[RLSDan_StringGuanVC alloc] init];
            fabuTuijianVC.jsonStr = @"all";
            return fabuTuijianVC;
        }
            break;
        default:
            break;
    }
    return [UIViewController new];
}
- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    [self.titleView updateSelectedIndex:_currentIndex];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (self.currentIndex != 0 && contentOffsetX <= Width * 4) {
        contentOffsetX += Width * self.currentIndex;
    }
}
- (void)scrollEnabled:(BOOL)enabled {
    self.scrollingLocked = !enabled;
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = enabled;
            view.bounces = enabled;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

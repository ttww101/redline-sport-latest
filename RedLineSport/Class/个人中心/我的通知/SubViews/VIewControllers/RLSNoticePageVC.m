#import "RLSNoticePageVC.h"
#import "RLSNoticeViewController.h"
#import "RLSRemindViewController.h"
@interface RLSNoticePageVC ()<ViewPagerDelegate,ViewPagerDataSource,NavViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UISegmentedControl *segmentEvent;
@end
@implementation RLSNoticePageVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    self.dataSource = self;
    self.currentIndex = 0;
    [self reloadData];
    [self setNavView];
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
    self.segmentEvent.center = CGPointMake(nav.labTitle.center.x, nav.labTitle.center.y);
    [nav addSubview:self.segmentEvent];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (UISegmentedControl *)segmentEvent
{
    if (!_segmentEvent) {
        _segmentEvent = [[UISegmentedControl alloc] initWithItems:@[@"提醒",@"通知"]];
        _segmentEvent.frame = CGRectMake(0, 0, 100, 25);
        _segmentEvent.tintColor =[UIColor whiteColor] ;
        _segmentEvent.backgroundColor= redcolor;
        _segmentEvent.selectedSegmentIndex = 0;
        _segmentEvent.layer.cornerRadius = 3;
        _segmentEvent.layer.borderColor = [UIColor whiteColor].CGColor;
        _segmentEvent.layer.borderWidth = 1;
        [_segmentEvent addTarget:self action:@selector(segmentEventValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentEvent;
}
- (void)segmentEventValueChanged:(UISegmentedControl *)segmentC
{
    UIPageViewControllerNavigationDirection direction;
    if (segmentC.selectedSegmentIndex < _currentIndex) {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }else{
        direction = UIPageViewControllerNavigationDirectionForward;
    }
    UIViewController *viewController = [self viewControllerAtIndex:segmentC.selectedSegmentIndex];
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = segmentC.selectedSegmentIndex;
        }];
    }
}
- (NSUInteger)numberOfTabsForViewPager:(RLSViewPagerController *)viewPager
{
    return 2;
}
- (UIViewController *)viewPager:(RLSViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            RLSRemindViewController *noticeVC = [[RLSRemindViewController alloc] init];
            return noticeVC;
        }
            break;
        case 1:
        {
            RLSNoticeViewController *noticeVC = [[RLSNoticeViewController alloc] init];
            return noticeVC;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if (self.currentIndex != 0 && contentOffsetX <= Width * 1) {
        contentOffsetX += Width * self.currentIndex;
    }
    if (contentOffsetX == Width) {
        _segmentEvent.selectedSegmentIndex = 0;
    }else if (contentOffsetX == Width*2){
        _segmentEvent.selectedSegmentIndex = 1;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

#import "RLSDC_JZAPhotoVC.h"
#import "UIImageView+WebCache.h"
#import "RLSDCPhotoView.h"
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height
@interface RLSDC_JZAPhotoVC ()<UIScrollViewDelegate,PhotoViewDelegate>
{
    CGFloat lastScale;
    NSMutableArray *_subViewList;
}
@end
@implementation RLSDC_JZAPhotoVC
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
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
    _subViewList = [[NSMutableArray alloc] init];
    lastScale = 1.0;
    self.view.backgroundColor = [UIColor blackColor];
    [self initScrollView];
    [self addLabels];
    [self setPicCurrentIndex:self.currentIndex];
}
-(void)initScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height);
    self.scrollView.delegate = self;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:self.scrollView];
    for (int i = 0; i < self.imgArr.count; i++) {
        [_subViewList addObject:[NSNull class]];
    }
}
-(void)addLabels{
    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, screen_height-64-49, 60, 30)];
    self.sliderLabel.backgroundColor = [UIColor clearColor];
    self.sliderLabel.textColor = [UIColor whiteColor];
    self.sliderLabel.text = [NSString stringWithFormat:@"%ld/%lu",self.currentIndex+1,(unsigned long)self.imgArr.count];
    [self.view addSubview:self.sliderLabel];
}
-(void)setPicCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.scrollView.contentOffset = CGPointMake(screen_width*currentIndex, 0);
    [self loadPhote:_currentIndex];
    [self loadPhote:_currentIndex+1];
    [self loadPhote:_currentIndex-1];
}
-(void)loadPhote:(NSInteger)index{
    if (index<0 || index >=self.imgArr.count) {
        return;
    }
    id currentPhotoView = [_subViewList objectAtIndex:index];
    if (![currentPhotoView isKindOfClass:[RLSDCPhotoView class]]) {
        CGRect frame = CGRectMake(index*_scrollView.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        RLSDCPhotoView *photoV = [[RLSDCPhotoView alloc] initWithFrame:frame withPhotoUrl:[self.imgArr objectAtIndex:index]];
        photoV.delegate = self;
        [self.scrollView insertSubview:photoV atIndex:0];
        [_subViewList replaceObjectAtIndex:index withObject:photoV];
    }else{
    }
}
#pragma mark - PhotoViewDelegate
-(void)TapHiddenPhotoView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)OnTapView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)pinGes:(UIPinchGestureRecognizer *)sender{
    if ([sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    CGFloat scale = 1.0 - (lastScale -[sender scale]);
    lastScale = [sender scale];
    self.scrollView.contentSize = CGSizeMake(self.imgArr.count*screen_width, screen_height*lastScale);
    NSLog(@"scale:%f   lastScale:%f",scale,lastScale);
    CATransform3D newTransform = CATransform3DScale(sender.view.layer.transform, scale, scale, 1);
    sender.view.layer.transform = newTransform;
    if ([sender state] == UIGestureRecognizerStateEnded) {
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    int i = scrollView.contentOffset.x/screen_width+1;
    [self loadPhote:i-1];
    self.sliderLabel.text = [NSString stringWithFormat:@"%d/%lu",i,(unsigned long)self.imgArr.count];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

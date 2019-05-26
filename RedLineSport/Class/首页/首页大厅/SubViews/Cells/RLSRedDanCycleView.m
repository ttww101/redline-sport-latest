#import "RLSRedDanCell.h"
#import "RLSRedDanCycleView.h"
@interface RLSRedDanCycleView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *mainView; 
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pagecontrol;
@end
@implementation RLSRedDanCycleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     }
    return self;
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    [self setupMainView];
}
- (UIPageControl *)pagecontrol
{
    if (!_pagecontrol) {
        _pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 35 + 110, 200, 35)];
        [_pagecontrol setCenter:CGPointMake(self.width/2, _pagecontrol.center.y)];
        _pagecontrol.numberOfPages = self.arrData.count;
        _pagecontrol.currentPage = 0;
        _pagecontrol.pageIndicatorTintColor = colorEE;
        _pagecontrol.currentPageIndicatorTintColor = redcolor;
    }
    return _pagecontrol;
}
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    _flowLayout.itemSize = CGSizeMake(Width, 110);
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 35, Width, 110) collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[RLSRedDanCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    mainView.dataSource = self;
    mainView.delegate = self;
    mainView.scrollsToTop = NO;
    [self addSubview:mainView];
    _mainView = mainView;
    UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 35)];
    lab_title.center = CGPointMake(self.width/2, lab_title.center.y);
    lab_title.text = @"红单播报";
    lab_title.textAlignment = NSTextAlignmentCenter;
    lab_title.font = font14;
    lab_title.textColor = color33;
    [self addSubview:lab_title];
    UIView *viewleft = [[UIView alloc] initWithFrame:CGRectMake(lab_title.left - 34, 0, 34, 0.5)];
    viewleft.center = CGPointMake(viewleft.center.x, lab_title.center.y);
    viewleft.backgroundColor = colorCellLine;
    [self addSubview:viewleft];
    UIView *viewright = [[UIView alloc] initWithFrame:CGRectMake(lab_title.right + 0, 0, 34, 0.5)];
    viewright.center = CGPointMake(viewright.center.x, lab_title.center.y);
    viewright.backgroundColor = colorCellLine;
    [self addSubview:viewright];
    [self addSubview:self.pagecontrol];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RLSRedDanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.model = [self.arrData objectAtIndex:indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = [self currentIndex];
    NSLog(@"%d",itemIndex);
    _pagecontrol.currentPage = itemIndex;
}
- (int)currentIndex
{
    if (_mainView.width == 0 || _mainView.width == 0) {
        return 0;
    }
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_mainView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    return MAX(0, index);
}
@end

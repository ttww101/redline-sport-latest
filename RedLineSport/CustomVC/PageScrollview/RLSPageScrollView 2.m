#import "RLSPageScrollView.h"
@interface RLSPageScrollView ()<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger totalTableView;
@property (nonatomic, strong) NSMutableArray *arrTableView;
@end
@implementation RLSPageScrollView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.delegate = self;
    }
    return self;
}
- (void)reloadData
{
    [self removeAllSubViews];
    if (_dateSource && [_dateSource respondsToSelector:@selector(numberOfIndexInPageSrollView:)]) {
        _totalTableView = [_dateSource numberOfIndexInPageSrollView:self];
        _arrTableView = [NSMutableArray array];
        self.contentSize = CGSizeMake(Width*_totalTableView, self.height);
        for (int i = 0; i<_totalTableView; i++) {
            UIView *tableView = [_dateSource pageScrollView:self tableViewForIndex:i];
            if (!tableView) {
                tableView = [UIView new];
            }
            tableView.frame = CGRectMake(Width*i, 0, Width, self.height);
            [self addSubview:tableView];
            [_arrTableView addObject:tableView];
        }
        if (_selectedIndex != 0) {
            [self updateSelectedIndex:_selectedIndex];
        }
    }
}
- (void)updateSelectedIndex:(NSInteger)index
{
    [self setContentOffset:CGPointMake(Width*index, 0) animated:NO];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging---%d --- %f",decelerate,scrollView.contentOffset.x/Width);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView    
{
    NSLog(@"scrollViewDidEndDecelerating");
    if (_pageDelegate && [_pageDelegate respondsToSelector:@selector(scrollToPageIndex:)]) {
        NSInteger index = (NSInteger)((scrollView.contentOffset.x + Width*0.5)/Width);
        NSLog(@"%ld",(long)index);
        if (index>=0 && index<=_totalTableView) {
            [_pageDelegate scrollToPageIndex:index];
        }
    }
}
@end

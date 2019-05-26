#import "RLSDataModelView.h"
@interface RLSDataModelView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *pagecontrol;
@end
@implementation RLSDataModelView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat widthSpace = (Width -20*2 -50 *4)/3;
        NSArray *arrtitle = @[@"比分直播",@"动画直播",@"模型预测",@"投注工具"];
        UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width, 95)];
        scrollV.pagingEnabled = YES;
        scrollV.delegate = self;
        scrollV.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollV];
        for (int i  = 0; i<arrtitle.count; i++) {
            CGFloat originX = 0;
            CGFloat originY = 0;
            if (i<4) {
                originY = 0;
                originX = widthSpace*i + 20 + 50 *i;
            }else{
                originY = 90;
                originX = widthSpace*(i-4) + 20 + 50 *(i-4);
            }
            UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(originX,originY, 50, 100)];
            [upBtn setBackgroundImage:[UIImage imageNamed:@"f5f5f5"] forState:UIControlStateHighlighted];
            [upBtn setBackgroundImage:nil forState:UIControlStateNormal];
            upBtn.tag = i;
            upBtn.userInteractionEnabled = YES;
            [upBtn addTarget:self action:@selector(preventFlicker:) forControlEvents:UIControlEventAllTouchEvents];
            [upBtn addTarget:self action:@selector(selectedInfo:) forControlEvents:UIControlEventTouchUpInside];
            [scrollV addSubview:upBtn];
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,19, 50, 50)];
            int imagtag = i;
            [imageV setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tool%d",imagtag]] ];
            [upBtn addSubview:imageV];
            UILabel *labTitle = [[UILabel alloc] init];
            [labTitle setFont:font13 ];
            [labTitle setTextColor:color40 ];
            [labTitle setText:[arrtitle objectAtIndex:i] ];
            [upBtn addSubview:labTitle];
            [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(upBtn.mas_centerX);
                make.top.equalTo(imageV.mas_bottom).offset(10);
            }];
        }
    }
    return self;
}
- (void)selectedInfo:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedDataModelViewIndex:)]) {
        [_delegate didSelectedDataModelViewIndex:btn.tag];
    }
}
- (void)preventFlicker:(UIButton *)button {
    button.highlighted = NO;
}
- (UIPageControl *)pagecontrol
{
    if (!_pagecontrol) {
        _pagecontrol = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 95, 200, 20)];
        [_pagecontrol setCenter:CGPointMake(self.width/2, _pagecontrol.center.y)];
        _pagecontrol.numberOfPages = 2;
        _pagecontrol.currentPage = 0;
        _pagecontrol.pageIndicatorTintColor = colorEE;
        _pagecontrol.currentPageIndicatorTintColor = redcolor;
    }
    return _pagecontrol;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   int  itemIndex = (scrollView.contentOffset.x +Width * 0.5) / Width;
    NSLog(@"%d",itemIndex);
    _pagecontrol.currentPage = itemIndex;
}
@end

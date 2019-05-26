#import "RLSHSTabBarContentView.h"
@interface RLSHSTabBarContentView () <UIScrollViewDelegate>
@property (strong, nonatomic)   UIScrollView                *tabBarScrollView;
@property (strong, nonatomic)   UIScrollView                *contentScrollView;
@property (strong, nonatomic)   NSMutableArray<UIButton *>  *tabBarItems;
@property (strong, nonatomic)   NSMutableArray<UIView *>    *contents;
@property (strong, nonatomic)   UIButton                    *selectedItemButton;
@property (strong, nonatomic)   UIView                      *highlightViewContainer;
@end
@implementation RLSHSTabBarContentView {
    NSInteger   _count;
}
#pragma mark - 重写属性 -
- (UIScrollView *)tabBarScrollView {
    if(_tabBarScrollView == nil) {
        _tabBarScrollView = [UIScrollView new];
        _tabBarScrollView.pagingEnabled = YES;
        _tabBarScrollView.showsHorizontalScrollIndicator = NO;
        _tabBarScrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_tabBarScrollView];
        [_tabBarScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
        if (self.bottomLineHide == NO) {
            [_tabBarScrollView addSubview:bottomLine];
            [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(_tabBarScrollView);
                make.trailing.mas_equalTo(_tabBarScrollView);
                make.width.equalTo(_tabBarScrollView);
                make.height.mas_equalTo(1.0 / [UIScreen mainScreen].scale);
                make.bottom.equalTo(_tabBarScrollView);
            }];
        }
    }
    return _tabBarScrollView;
}
- (UIScrollView *)contentScrollView {
    if(_contentScrollView == nil) {
        _contentScrollView = [UIScrollView new];
        _contentScrollView.userInteractionEnabled = YES;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.delegate = self;
        [self addSubview:_contentScrollView];
        [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.tabBarScrollView.mas_bottom);
        }];
    }
    return _contentScrollView;
}
- (NSMutableArray<UIView *> *)contents {
    if(_contents == nil) {
        _contents = [NSMutableArray array];
    }
    return _contents;
}
- (NSMutableArray<UIButton *> *)tabBarItems {
    if(_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}
- (void)setTabBarBackgroundView:(UIView *)tabBarBackgroundView {
    if(_tabBarBackgroundView != nil) {
        [_tabBarBackgroundView removeFromSuperview];
        _tabBarBackgroundView = nil;
    }
    _tabBarBackgroundView = tabBarBackgroundView;
    [self.tabBarScrollView insertSubview:_tabBarBackgroundView atIndex:0];
    [_tabBarBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.with.height.equalTo(self.tabBarScrollView);
    }];
}
#pragma mark - 私有方法 -
- (CGFloat)tabBarHeight {
    CGFloat tabBarHeight = 30;
    if(self.delegate && [self.delegate respondsToSelector:@selector(heightForTabBarInTabBarContentView:)]) {
        tabBarHeight = [self.delegate heightForTabBarInTabBarContentView:self];
    }
    return tabBarHeight;
}
- (NSInteger)numberOfItems {
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfItemsInTabBarContentView:)]) {
        return [self.dataSource numberOfItemsInTabBarContentView:self];
    }
    return 0;
}
- (void)realoadTabBar {
    [self.tabBarScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo([self tabBarHeight]);
    }];
    for (UIButton *itemButton in self.tabBarItems) {
        [itemButton removeFromSuperview];
    }
    [self.tabBarItems removeAllObjects];
    NSInteger tabBarItemCount = _count;
    for (NSInteger i = 0; i < tabBarItemCount; i++) {
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.tabBarScrollView addSubview:itemButton];
        [itemButton addTarget:self action:@selector(actionSelectItemButton:) forControlEvents:UIControlEventTouchUpInside];
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(tabBarContentView:titleForItemAtIndex:)]) {
            NSString *title = [self.dataSource tabBarContentView:self titleForItemAtIndex:i];
            [itemButton setTitle:title forState:UIControlStateNormal];
        }
        if (self.titleFont) {
            itemButton.titleLabel.font = [UIFont systemFontOfSize:self.titleFont];
        }
        itemButton.titleLabel.font = [UIFont systemFontOfSize:14];
        if(self.delegate && [self.delegate respondsToSelector:@selector(colorForTabBarItemTextInTabBarContentView:)]) {
            [itemButton setTitleColor:[self.delegate colorForTabBarItemTextInTabBarContentView:self] forState:UIControlStateNormal];
        } else {
            [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(highlightColorForTabBarItemInTabBarContentView:)]) {
            [itemButton setTitleColor:[self.delegate highlightColorForTabBarItemInTabBarContentView:self] forState:UIControlStateSelected];
        } else {
            [itemButton setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        }
        [self.tabBarItems addObject:itemButton];
    }
    CGFloat percentWith = 1.0 / tabBarItemCount;
    for (NSInteger i = 0; i < tabBarItemCount; i++) {
        UIButton *itemButton = self.tabBarItems[i];
        [itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0) {
                make.left.equalTo(self.tabBarScrollView.mas_left);
            } else {
                make.left.equalTo(self.tabBarItems[i - 1].mas_right);
            }
            if(i == tabBarItemCount - 1) {
                make.right.equalTo(self.tabBarScrollView.mas_right);
            } else {
                make.right.equalTo(self.tabBarItems[i + 1].mas_left);
            }
            make.top.bottom.height.equalTo(self.tabBarScrollView);
            make.width.equalTo(self.tabBarScrollView).multipliedBy(percentWith);
        }];
    }
    if(self.highlightViewContainer == nil) {
        self.highlightViewContainer = [UIView new];
        self.highlightViewContainer.userInteractionEnabled = NO;
        [self.tabBarScrollView addSubview:self.highlightViewContainer];
        [self.highlightViewContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            if (self.selectedIndex) {
                make.edges.equalTo(self.tabBarItems[self.selectedIndex]);
            }else{
                make.edges.equalTo(self.tabBarItems.firstObject);
            }
        }];
    }
    NSArray *subviews = [self.highlightViewContainer subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(highlightViewForTabBarItemInTabBarContentView:)]) {
        UIView *highlightView = [self.delegate highlightViewForTabBarItemInTabBarContentView:self];
        [self.highlightViewContainer addSubview:highlightView];
        [highlightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.highlightViewContainer);
        }];
    }
        [self actionSelectItemButton:self.tabBarItems[self.selectedIndex]];
        [self actionSelectItemButton:self.tabBarItems.firstObject];
}
- (void)realoadContent {
    for (UIView *contentView in self.contents) {
        [contentView removeFromSuperview];
    }
    [self.contents removeAllObjects];
    for (NSInteger i = 0; i < _count; i++) {
        UIView *contentView = nil;
        if(self.dataSource && [self.dataSource respondsToSelector:@selector(tabBarContentView:contentViewAtIndex:)]) {
            contentView = [self.dataSource tabBarContentView:self contentViewAtIndex:i];
        }
        if(contentView == nil) {
            contentView = [UIView new];
        }
        [self.contentScrollView addSubview:contentView];
        [self.contents addObject:contentView];
    }
    for (NSInteger i = 0; i < _count; i++) {
        UIView *contentView = self.contents[i];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            if(i == 0) {
                make.left.equalTo(self.contentScrollView.mas_left);
            } else {
                make.left.equalTo(self.contents[i - 1].mas_right);
            }
            if(i == _count - 1) {
                make.right.equalTo(self.contentScrollView.mas_right);
            } else {
                make.right.equalTo(self.contents[i + 1].mas_left);
            }
            make.top.height.bottom.width.equalTo(self.contentScrollView);
        }];
    }
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self actionSelectItemButton:self.tabBarItems[selectedIndex]];
}
#pragma mark - 动作方法 -
- (IBAction)actionSelectItemButton:(UIButton *)button {
    if(self.selectedItemButton != nil && self.selectedItemButton == button) return;
    if(self.selectedItemButton != nil) {
        self.selectedItemButton.selected = NO;
        self.selectedItemButton = nil;
    }
    self.selectedItemButton = button;
    self.selectedItemButton.selected = YES;
    NSInteger selectedIndex;
        selectedIndex = [self.tabBarItems indexOfObject:self.selectedItemButton];
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBarContentView:didSelectItemAtIndex:)]) {
        [self.delegate tabBarContentView:self didSelectItemAtIndex:selectedIndex];
    }
    CGPoint offset = CGPointMake(selectedIndex * self.contentScrollView.frame.size.width, 0);
    [self.contentScrollView setContentOffset:offset animated:YES];
}
#pragma mark - 公共方法 -
- (void)reloadData {
    _count = [self numberOfItems];
    [self realoadTabBar];
    [self realoadContent];
}
#pragma mark - UIScrollViewDelegate -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x / (scrollView.contentSize.width - scrollView.frame.size.width) * (self.tabBarScrollView.frame.size.width - self.highlightViewContainer.frame.size.width);
    self.highlightViewContainer.frame = CGRectMake(offsetX, self.highlightViewContainer.frame.origin.y, self.highlightViewContainer.frame.size.width, self.highlightViewContainer.frame.size.height);
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger selectedIndex ;
        selectedIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    UIButton *selectedButton = self.tabBarItems[selectedIndex];
    [self actionSelectItemButton:selectedButton];
    [self.highlightViewContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.selectedItemButton);
    }];
}
@end

//
//  SectionView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "SectionView.h"
#import "CustomPopOverView.h"

@interface SectionView () <CustomPopOverViewDelegate>

@property (nonatomic , strong) PlayControl *leftControl;
@property (nonatomic , strong) PlayControl *rightControl;
@property (nonatomic , strong) UIButton *btn;


@end

@implementation SectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, 40)];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    PlayControl *control1 = [[PlayControl alloc]initWithFrame:CGRectMake(15, 0, 60, 40)];
    control1.title = @"全部";
    control1.isSelected = true;
    [control1 addTarget:self action:@selector(allAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control1];
    self.leftControl = control1;
    PlayControl *control2 = [[PlayControl alloc]initWithFrame:CGRectMake(90, 0, 60, 40)];
    control2.title = @"精华帖";
    control2.isSelected = false;
    [control2 addTarget:self action:@selector(bestAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control2];
    self.rightControl = control2;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - ONE_PX_LINE, self.width, ONE_PX_LINE)];
    line.backgroundColor = UIColorHex(eeeeee);
    [self addSubview:line];
    
    BaseImageView *rightArrowImageView = [[BaseImageView alloc]initWithFrame:CGRectMake(Width - 28, 16, 13, 7)];
    rightArrowImageView.image = [UIImage imageNamed:@"downarrow"];
    [self addSubview:rightArrowImageView];
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(self.width - 100, 0, 70, 40);
    [self.btn setTitle:@"按发表时间" forState:UIControlStateNormal];
    [self.btn setTitleColor:UIColorHex(#383838) forState:UIControlStateNormal];
    self.btn.titleLabel.font = font12;
    [self.btn addTarget:self action:@selector(recentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
}

#pragma mark- CustomPopOverViewDelegate


- (void)popOverViewDidShow:(CustomPopOverView *)pView {
}
- (void)popOverViewDidDismiss:(CustomPopOverView *)pView {
   
}

- (void)popOverView:(CustomPopOverView *)pView didClickMenuIndex:(NSInteger)index{
    [pView dismiss];
    if (_delegate && [_delegate respondsToSelector:@selector(loadWithRecent:)]) {
        [_delegate loadWithRecent:index];
    }
    if (index == 0) {
        [self.btn setTitle:@"按发表时间" forState:UIControlStateNormal];
    } else {
        [self.btn setTitle:@"按最新回复" forState:UIControlStateNormal];
    }
}


#pragma mark - Events

- (void)allAction {
    if (_delegate && [_delegate respondsToSelector:@selector(switchType:)]) {
        [_delegate switchType:0];
    }
    self.leftControl.isSelected = true;
    self.rightControl.isSelected = false;
    
}

- (void)bestAction {
    if (_delegate && [_delegate respondsToSelector:@selector(switchType:)]) {
        [_delegate switchType:1];
    }
    self.leftControl.isSelected = false;
    self.rightControl.isSelected = true;
}

- (void)recentAction:(UIButton *)sender {
    PopOverVieConfiguration *config = [PopOverVieConfiguration new];
    config.containerViewCornerRadius = 3.0;
    config.roundMargin = ONE_PX_LINE;
    config.defaultRowHeight = 30;
    config.tableBackgroundColor = [UIColor whiteColor];
    config.textColor = UIColorHex(323232);
    config.textAlignment = NSTextAlignmentLeft;
    config.font = font12;
    config.showSpace = 5;
    NSArray *arr = @[
                     @{@"name": @" 按发表时间"},
                     @{@"name": @"按最新回复"},
                     ];
    
    CustomPopOverView *view = [[CustomPopOverView alloc]initWithBounds:CGRectMake(0, 0, 100, 30*2) titleInfo:arr config:config];
    view.containerBackgroudColor = UIColorHex(e2e2e2);
    view.layer.borderWidth = ONE_PX_LINE;
    view.layer.borderColor = UIColorHex(eeeeee).CGColor;
    view.delegate = self;
    [view showFrom:sender alignStyle:CPAlignStyleCenter];
}

@end

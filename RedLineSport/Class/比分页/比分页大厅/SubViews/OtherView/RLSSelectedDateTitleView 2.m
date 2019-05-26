#import "RLSSelectedDateTitleView.h"
@interface RLSSelectedDateTitleView()
@property (nonatomic, strong) UIButton *btnDate;
@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIView *viewline;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation RLSSelectedDateTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _btnLeft  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLeft.tag = 2;
        _btnLeft.titleLabel.font = font12;
        [_btnLeft setTitleColor:color33 forState:UIControlStateNormal];
        [_btnLeft setTitleColor:color33 forState:UIControlStateHighlighted];
        _btnLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:_btnLeft];
        [_btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(10);
            make.width.mas_equalTo(Width/2);
            make.height.mas_equalTo(self.mas_height);
        }];
    
        _btnRight  = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRight.tag = 3;
        _btnRight.titleLabel.font = font12;
        [_btnRight setBackgroundImage:[UIImage imageNamed:@"dateTime"] forState:UIControlStateNormal];
        [self addSubview:_btnRight];
        
        [_btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).offset(-10);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        
        _viewline = [[UIView alloc] init];
        [self addSubview:_viewline];
        [_viewline mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.width.mas_equalTo(Width);
            make.height.mas_equalTo(0.5);
        }];
        
        UIControl *control = [[UIControl alloc]initWithFrame:self.bounds];
        [control addTarget:self action:@selector(didAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
    }
    return self;
}


- (void)setArrData:(NSArray *)arrData {
    _arrData = arrData;
    for (NSInteger i = 0; i < arrData.count; i ++) {
        RLSQiciModel *model = arrData[i];
        if (model.selected) {
            [_btnLeft setTitle:model.item forState:UIControlStateNormal];
        }
    }
}

- (void)didAction {
    if (_delegate && [_delegate respondsToSelector:@selector(RLSSelectedDateTitleViewDidAction:)]) {
        [_delegate RLSSelectedDateTitleViewDidAction:self.arrData];
    }
}


@end

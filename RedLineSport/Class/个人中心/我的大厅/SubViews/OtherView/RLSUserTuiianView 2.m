#import "RLSUserTuiianView.h"
@interface RLSUserTuiianView()
@property (nonatomic, strong) UIImageView *imageAnimation;
@end
@implementation RLSUserTuiianView
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setModel:(RLSUserModel *)model
{
    _model = model;
    [self removeAllSubViews];
    CGFloat btnWidth = Width/3;
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth*i, 0, btnWidth, 60);
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        UILabel *labNum = [[UILabel alloc] init];
        labNum.font = font18;
        labNum.textColor = [UIColor whiteColor];
        [btn addSubview:labNum];
        [labNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btn.mas_top).offset(12.5);
            make.centerX.equalTo(btn.mas_centerX);
        }];
        UILabel *labTitle = [[UILabel alloc] init];
        labTitle.font = font12;
        labTitle.textColor = colorFFC5BF;
        [btn addSubview:labTitle];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(labNum.mas_bottom).offset(2.5);
            make.centerX.equalTo(btn.mas_centerX);
        }];
        if (i<2) {
            UIView *viewLine = [[UIView alloc] init];
            viewLine.backgroundColor = colorFB9A81;
            [btn addSubview:viewLine];
            [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(btn.mas_right).offset(-1);
                make.centerY.equalTo(btn.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(0.5, 40));
            }];
        }
        if (i == [[NSUserDefaults standardUserDefaults] integerForKey:@"userTuijianVCIndex"]) {
            _imageAnimation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60 - 9, 17, 9)];
            _imageAnimation.center = CGPointMake(btn.center.x, _imageAnimation.center.y);
            if (isNUll(_imageName)) {
                _imageName = @"clear";
            }
            _imageAnimation.image = [UIImage imageNamed:_imageName];
            [self addSubview:_imageAnimation];
        }
        switch (i) {
            case 0:
            {
                labTitle.text = @"推荐";
                labNum.text = [NSString stringWithFormat:@"%ld",(long)_model.recommendCount];
            }
                break;
            case 1:
            {
                labTitle.text = @"关注";
                labNum.text = [NSString stringWithFormat:@"%ld",(long)_model.focusCount];
            }
                break;
            case 2:
            {
                labTitle.text = @"粉丝";
                labNum.text = [NSString stringWithFormat:@"%ld",(long)_model.followerCount];
            }
                break;
            default:
                break;
        }
    }
}
- (void)btnClick:(UIButton *)btn
{
    [UIView animateWithDuration:0.5 animations:^{
        _imageAnimation.center = CGPointMake(btn.center.x, _imageAnimation.center.y);
    }];
    if (_delegate && [_delegate respondsToSelector:@selector(didTouchItemWithIndex:)]) {
        [_delegate didTouchItemWithIndex:btn.tag];
    }
}
@end

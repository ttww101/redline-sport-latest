#import "RLSTuijianSelectedItemTitleView.h"
@interface RLSTuijianSelectedItemTitleView()
@property (nonatomic, strong) UILabel *lab1;
@property (nonatomic, strong) UILabel *lab2;
@property (nonatomic, strong) UILabel *lab3;
@property (nonatomic, strong) UILabel *lab4;
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@property (nonatomic, strong) UIImageView *image3;
@property (nonatomic, strong) UIImageView *image4;
@end
@implementation RLSTuijianSelectedItemTitleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i =0 ; i<4; i++) {
            UIView *bgView  = [[UIView alloc] initWithFrame:CGRectMake(Width/4*i, 0, Width/4, frame.size.height)];
            [self addSubview:bgView];
            switch (i) {
                case 0:
                {
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Tap)];
                    [bgView addGestureRecognizer:tap];
                    _lab1 = [[UILabel alloc] init];
                    _lab1.textColor = color33;
                    _lab1.font = font12;
                    _lab1.text = @"全部玩法";
                    _lab1.textAlignment = NSTextAlignmentCenter;
                    [bgView addSubview:_lab1];
                    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(bgView.mas_centerX).offset(-9);
                        make.centerY.equalTo(bgView.mas_centerY);
                    }];
                    _image1 = [[UIImageView alloc] init];
                    _image1.image = [UIImage imageNamed:@"btnarrowsGray"];
                    [bgView addSubview:_image1];
                    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_lab1.mas_right).offset(5);
                        make.centerY.equalTo(bgView.mas_centerY);
                        make.size.mas_equalTo(CGSizeMake(13, 7));
                    }];
                }
                    break;
                case 1:
                {
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Tap)];
                    [bgView addGestureRecognizer:tap];
                    _lab2 = [[UILabel alloc] init];
                    _lab2.textColor = color33;
                    _lab2.font = font12;
                    _lab2.text = @"全部状态";
                    _lab2.textAlignment = NSTextAlignmentCenter;
                    [bgView addSubview:_lab2];
                    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(bgView.mas_centerX).offset(-9);
                        make.centerY.equalTo(bgView.mas_centerY);
                    }];
                    _image2 = [[UIImageView alloc] init];
                    _image2.image = [UIImage imageNamed:@"btnarrowsGray"];
                    [bgView addSubview:_image2];
                    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_lab2.mas_right).offset(5);
                        make.centerY.equalTo(bgView.mas_centerY);
                        make.size.mas_equalTo(CGSizeMake(13, 7));
                    }];
                }
                    break;
                case 2:
                {
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Tap)];
                    [bgView addGestureRecognizer:tap];
                    _lab3 = [[UILabel alloc] init];
                    _lab3.textColor = color33;
                    _lab3.font = font12;
                    _lab3.text = @"最近发布";
                    _lab3.textAlignment = NSTextAlignmentCenter;
                    [bgView addSubview:_lab3];
                    [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(bgView.mas_centerX).offset(-9);
                        make.centerY.equalTo(bgView.mas_centerY);
                    }];
                    _image3 = [[UIImageView alloc] init];
                    _image3.image = [UIImage imageNamed:@"btnarrowsGray"];
                    [bgView addSubview:_image3];
                    [_image3 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(_lab3.mas_right).offset(5);
                        make.centerY.equalTo(bgView.mas_centerY);
                        make.size.mas_equalTo(CGSizeMake(13, 7));
                    }];
                }
                    break;
                case 3:
                {
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4Tap)];
                    [bgView addGestureRecognizer:tap];
                    _lab4 = [[UILabel alloc] init];
                    _lab4.textColor = color33;
                    _lab4.font = font12;
                    _lab4.text = @"我的关注";
                    _lab4.textAlignment = NSTextAlignmentCenter;
                    [bgView addSubview:_lab4];
                    [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(bgView.mas_centerX).offset(9);
                        make.centerY.equalTo(bgView.mas_centerY);
                    }];
                    _image4 = [[UIImageView alloc] init];
                    _image4.image = [UIImage imageNamed:@"tuijianAttention"];
                    [bgView addSubview:_image4];
                    [_image4 mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.right.equalTo(_lab4.mas_left).offset(-5);
                        make.centerY.equalTo(bgView.mas_centerY);
                        make.size.mas_equalTo(CGSizeMake(13, 13));
                    }];
                }
                    break;
                default:
                    break;
            }
        }
    }
    return self;
}
- (void)tap1Tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapTuijianSelectedItemTitleViewAtindex:)]) {
        [_delegate tapTuijianSelectedItemTitleViewAtindex:0];
    }
    [self updateSelectedIndexWithindex:0 WithTitle:_lab1.text];
}
- (void)tap2Tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapTuijianSelectedItemTitleViewAtindex:)]) {
        [_delegate tapTuijianSelectedItemTitleViewAtindex:1];
    }
    [self updateSelectedIndexWithindex:1 WithTitle:_lab2.text];
}
- (void)tap3Tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapTuijianSelectedItemTitleViewAtindex:)]) {
        [_delegate tapTuijianSelectedItemTitleViewAtindex:2];
    }
    [self updateSelectedIndexWithindex:2 WithTitle:_lab3.text];
}
- (void)tap4Tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapTuijianSelectedItemTitleViewAtindex:)]) {
        [_delegate tapTuijianSelectedItemTitleViewAtindex:3];
    }
    [self updateSelectedIndexWithindex:3 WithTitle:_lab4.text];
}
- (void)updateSelectedIndexWithindex:(NSInteger)index WithTitle:(NSString *)title
{
    switch (index) {
        case 0:
        {
            _lab1.text = title;
            _lab1.textColor = redcolor;
            _lab2.textColor = color33;
            _lab3.textColor = color33;
            _image1.image = [UIImage imageNamed:@"btnarrows"];
            _image2.image = [UIImage imageNamed:@"btnarrowsGray"];
            _image3.image = [UIImage imageNamed:@"btnarrowsGray"];
        }
            break;
        case 1:
        {
            _lab2.text = title;
            _lab1.textColor = color33;
            _lab2.textColor = redcolor;
            _lab3.textColor = color33;
            _image1.image = [UIImage imageNamed:@"btnarrowsGray"];
            _image2.image = [UIImage imageNamed:@"btnarrows"];
            _image3.image = [UIImage imageNamed:@"btnarrowsGray"];
        }
            break;
        case 2:
        {
            _lab3.text = title;
            _lab1.textColor = color33;
            _lab2.textColor = color33;
            _lab3.textColor = redcolor;
            _image1.image = [UIImage imageNamed:@"btnarrowsGray"];
            _image2.image = [UIImage imageNamed:@"btnarrowsGray"];
            _image3.image = [UIImage imageNamed:@"btnarrows"];
        }
            break;
        case 3:
        {
        }
            break;
        default:
            break;
    }
}
- (void)attentionBtnSelected:(BOOL)selected
{
    _lab4.text = @"我的关注";
    if (selected) {
        _lab4.textColor = redcolor;
        _image4.image = [UIImage imageNamed:@"tuijianAttentionselected"];
    }else{
        _lab4.textColor = color33;
        _image4.image = [UIImage imageNamed:@"tuijianAttention"];
    }
}
@end

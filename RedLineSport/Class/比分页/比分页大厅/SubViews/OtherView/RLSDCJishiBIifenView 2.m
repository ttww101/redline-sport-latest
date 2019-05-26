#import "RLSDCJishiBIifenView.h"
@interface RLSDCJishiBIifenView()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIImageView *bgView;
@property (strong, nonatomic)  UILabel *labTime;
@property (strong, nonatomic)  UIImageView *imageHome;
@property (strong, nonatomic)  UIImageView *imageGuest;
@property (strong, nonatomic)  UILabel *labHome;
@property (strong, nonatomic)  UILabel *labGuest;
@property (strong, nonatomic)  UILabel *labtitleTop;
@property (strong, nonatomic)  UILabel *labtitleBottom;
@property (strong, nonatomic)  UILabel *labHomeScore;
@property (strong, nonatomic)  UILabel *labGuestScore;
@property (strong, nonatomic) UIView *viewLine;
@property (strong, nonatomic)  UILabel *labRedTeam;
@property (strong, nonatomic)  UILabel *labRedCard;
@property (strong, nonatomic)  UILabel *labLeague;
@end
@implementation RLSDCJishiBIifenView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (void)setIshome:(BOOL)ishome
{
    _ishome = ishome;
}
- (void)setModel:(RLSJsbfValue *)model
{
    _model = model;
    _labTime.text = _model.time;
    _labHome.text = _model.home;
    _labGuest.text = _model.guest;
    if (_ishome) {
        _labHome.font = BoldFont4(fontSize14);
        _labtitleTop.font = BoldFont4(fontSize13);
        _labHomeScore.font = BoldFont4(fontSize14);
        _labGuest.font = font12;
        _labtitleBottom.font = font12;
        _labGuestScore.font = font12;
        _labHome.textColor = color33;
        _labtitleTop.textColor = color33;
        _labHomeScore.textColor = color33;
        _labGuest.textColor = color66;
        _labtitleBottom.textColor = color66;
        _labGuestScore.textColor = color66;
        if (_isRed) {
            _imageHome.image = [UIImage imageNamed:@"bifenRedCard"];
            _imageGuest.image = [UIImage imageNamed:@"clear"];
            _labtitleTop.text = @"红牌";
            _labtitleBottom.text = @"";
            _labHomeScore.text = _model.redHome;
            _labGuestScore.text = _model.redGuest;
        }else{
            _imageHome.image = [UIImage imageNamed:@"bifenJinqiu"];
            _imageGuest.image = [UIImage imageNamed:@"clear"];
            _labtitleTop.text = @"进球";
            _labtitleBottom.text = @"";
            _labHomeScore.text = _model.homeScore;
            _labGuestScore.text = _model.guestScore;
        }
    }else{
        _labHome.font = font12;
        _labtitleTop.font = font12;
        _labHomeScore.font = font12;
        _labGuest.font = BoldFont4(fontSize14);
        _labtitleBottom.font = BoldFont4(fontSize13);
        _labGuestScore.font = BoldFont4(fontSize14);
        _labHome.textColor = color66;
        _labtitleTop.textColor = color66;
        _labHomeScore.textColor = color66;
        _labGuest.textColor = color33;
        _labtitleBottom.textColor = color33;
        _labGuestScore.textColor = color33;
        if (_isRed) {
            _imageGuest.image = [UIImage imageNamed:@"bifenRedCard"];
            _imageHome.image = [UIImage imageNamed:@"clear"];
            _labtitleTop.text = @"";
            _labtitleBottom.text = @"红牌";
            _labHomeScore.text = _model.redHome;
            _labGuestScore.text = _model.redGuest;
        }else{
            _imageGuest.image = [UIImage imageNamed:@"bifenJinqiu"];
            _imageHome.image = [UIImage imageNamed:@"clear"];
            _labtitleTop.text = @"";
            _labtitleBottom.text = @"进球";
            _labHomeScore.text = _model.homeScore;
            _labGuestScore.text = _model.guestScore;
        }
    }
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    if (_model) {
           }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        [_basicView addSubview:self.bgView];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labHome];
        [_basicView addSubview:self.labGuest];
        [_basicView addSubview:self.imageHome];
        [_basicView addSubview:self.imageGuest];
        [_basicView addSubview:self.labtitleTop];
        [_basicView addSubview:self.labtitleBottom];
        [_basicView addSubview:self.viewLine];
        [_basicView addSubview:self.labHomeScore];
        [_basicView addSubview:self.labGuestScore];
    }
    return _basicView;
}
- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _basicView.width, _basicView.height)];
        _bgView.image = [UIImage imageNamed:@"jsbifenBG"];
    }
    return _bgView;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45*Scale_Ratio_width, _basicView.height)];
        _labTime.font = font16;
        _labTime.textAlignment = NSTextAlignmentCenter;
        _labTime.textColor = color33;
    }
    return _labTime;
}
- (UILabel *)labHome
{
    if (!_labHome) {
        _labHome = [[UILabel alloc] initWithFrame:CGRectMake(_labTime.right + (15 + 18 + 15)*Scale_Ratio_width, 8, 150*Scale_Ratio_width, 24)];
        _labHome.font = font14;
        _labHome.textColor = colorFFD8D6;
    }
    return _labHome;
}
- (UILabel *)labGuest
{
    if (!_labGuest) {
        _labGuest = [[UILabel alloc] initWithFrame:CGRectMake(_labHome.x, _labHome.bottom, _labHome.width, _labHome.height)];
        _labGuest.font = font14;
        _labGuest.textColor = colorFFD8D6;
    }
    return _labGuest;
}
- (UIImageView *)imageHome
{
    if (!_imageHome) {
        _imageHome = [[UIImageView alloc] initWithFrame:CGRectMake(_labHome.left - (15 + 18)*Scale_Ratio_width, 0, 18, 18)];
        _imageHome.center = CGPointMake(_imageHome.center.x, _labHome.center.y);
    }
    return _imageHome;
}
- (UIImageView *)imageGuest
{
    if (!_imageGuest) {
        _imageGuest = [[UIImageView alloc] initWithFrame:CGRectMake(_imageHome.x, 0, 18, 18)];
        _imageGuest.center = CGPointMake(_imageGuest.center.x, _labGuest.center.y);
    }
    return _imageGuest;
}
- (UILabel *)labtitleTop
{
    if (!_labtitleTop) {
        _labtitleTop = [[UILabel alloc] initWithFrame:CGRectMake(_basicView.width - 48 - 10 - 50, _labHome.y, 50, _labHome.height)];
        _labtitleTop.font = font14;
        _labtitleTop.textColor = [UIColor whiteColor];
        _labtitleTop.textAlignment = NSTextAlignmentRight;
    }
    return _labtitleTop;
}
- (UILabel *)labtitleBottom
{
    if (!_labtitleBottom) {
        _labtitleBottom = [[UILabel alloc] initWithFrame:CGRectMake(_basicView.width - 48 - 10 - 50, _labGuest.y, 50, _labHome.height)];
        _labtitleBottom.font = font14;
        _labtitleBottom.textColor = [UIColor whiteColor];
        _labtitleBottom.textAlignment = NSTextAlignmentRight;
    }
    return _labtitleBottom;
}
- (UILabel *)labHomeScore
{
    if (!_labHomeScore) {
        _labHomeScore  = [[UILabel alloc] initWithFrame:CGRectMake(_basicView.width - 48, _labHome.y, 48, _labHome.height)];
        _labHomeScore.font = font12;
        _labHomeScore.textAlignment = NSTextAlignmentCenter;
        _labHomeScore.textColor = [UIColor whiteColor];
    }
    return _labHomeScore;
}
- (UILabel *)labGuestScore
{
    if (!_labGuestScore) {
        _labGuestScore  = [[UILabel alloc] initWithFrame:CGRectMake(_basicView.width - 48, _labGuest.y, 48, _labHome.height)];
        _labGuestScore.font = font12;
        _labGuestScore.textAlignment = NSTextAlignmentCenter;
        _labGuestScore.textColor = [UIColor whiteColor];
    }
    return _labGuestScore;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] initWithFrame:CGRectMake(_basicView.width - 49, 10, 0.5, _basicView.height - 20)];
        _viewLine.backgroundColor = colorE4a100;
    }
    return _viewLine;
}
@end

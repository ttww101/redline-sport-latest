#import "RLSBaolengDTTitleView.h"
@interface RLSBaolengDTTitleView ()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labLeague;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labHomteam;
@property (nonatomic, strong) UILabel *labGuestteam;
@property (nonatomic, strong) UILabel *labVS;
@property (nonatomic, strong) UILabel *labPeilv;
@end
@implementation RLSBaolengDTTitleView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
        _labLeague.text = @"赛事";
        _labHomteam.text = @"主队";
        _labVS.text = @"比分";
        _labGuestteam.text = @"客队";
        _labPeilv.text = @"赛果";
    }
    return self;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labLeague];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labHomteam];
        [_basicView addSubview:self.labGuestteam];
        [_basicView addSubview:self.labVS];
        [_basicView addSubview:self.labPeilv];
    }
    return _basicView;
}
- (UILabel *)labLeague
{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 45, 30)];
        _labLeague.font = font12;
        _labLeague.textColor = color99;
    }
    return _labLeague;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 50, 15)];
        _labTime.font = font10;
        _labTime.textColor = color99;
    }
    return _labTime;
}
- (UILabel *)labHomteam
{
    if (!_labHomteam) {
        _labHomteam = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, (Width - 60 - 35 - 120)/2, 30)];
        _labHomteam.font = font12;
        _labHomteam.textAlignment = NSTextAlignmentRight;
        _labHomteam.textColor = color99;
    }
    return _labHomteam;
}
- (UILabel *)labGuestteam
{
    if (!_labGuestteam) {
        _labGuestteam = [[UILabel alloc] initWithFrame:CGRectMake(_labHomteam.right + 35, 0, (Width - 60 - 35 - 120)/2, 30)];
        _labGuestteam.font = font12;
        _labGuestteam.textColor = color99;
    }
    return _labGuestteam;
}
- (UILabel *)labVS
{
    if (!_labVS) {
        _labVS = [[UILabel alloc] initWithFrame:CGRectMake(_labHomteam.right, 0, 35, 30)];
        _labVS.font = font12;
        _labVS.textColor = color99;
        _labVS.textAlignment = NSTextAlignmentCenter;
    }
    return _labVS;
}
- (UILabel *)labPeilv
{
    if (!_labPeilv) {
        _labPeilv = [[UILabel alloc] initWithFrame:CGRectMake(_labGuestteam.right, 0, 120, 30)];
        _labPeilv.font = font12;
        _labPeilv.textColor = color99;
        _labPeilv.textAlignment = NSTextAlignmentCenter;
    }
    return _labPeilv;
}
@end

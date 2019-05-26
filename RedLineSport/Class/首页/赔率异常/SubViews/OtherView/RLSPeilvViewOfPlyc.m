#import "RLSPeilvViewOfPlyc.h"
@interface RLSPeilvViewOfPlyc()
@property (nonatomic, assign) BOOL isaddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labcompany;
@property (nonatomic, strong) UILabel *labJPTitle;
@property (nonatomic, strong) UILabel *labJP1;
@property (nonatomic, strong) UILabel *labJP2;
@property (nonatomic, strong) UILabel *labJP3;
@property (nonatomic, strong) UILabel *labCPTitle;
@property (nonatomic, strong) UILabel *labCP1;
@property (nonatomic, strong) UILabel *labCP2;
@property (nonatomic, strong) UILabel *labCP3;
@property (nonatomic, strong) UILabel *labJPTime;
@property (nonatomic, strong) UILabel *labWin;
@property (nonatomic, strong) UILabel *labPing;
@property (nonatomic, strong) UILabel *labLose;
@property (nonatomic, strong) UILabel *labWinTitle;
@property (nonatomic, strong) UILabel *labPingTitle;
@property (nonatomic, strong) UILabel *labLoseTitle;
@property (nonatomic, strong) UIImageView *imageJP1;
@property (nonatomic, strong) UIImageView *imageJP2;
@property (nonatomic, strong) UIImageView *imageJP3;
@property (nonatomic, strong) UIImageView *imageWin;
@property (nonatomic, strong) UIImageView *imagePing;
@property (nonatomic, strong) UIImageView *imageLose;
@property (nonatomic, strong) UIView *viewLine;
@end
@implementation RLSPeilvViewOfPlyc
- (void)setModel:(RLSPlycModel *)model
{
    _model = model;
    [self addSubview:self.basicView];
    if (!_isaddlayout) {
        _isaddlayout = YES;
        [self addlayout];
    }
    _labcompany.text = [NSString stringWithFormat:@"公司: %@",_model.companyName];
    _labJPTitle.text = @"即:";
    _labCPTitle.text = @"初:";
    _labJP1.text = _model.finalWin;
    _labJP2.text = _model.finalDraw;
    _labJP3.text = _model.finalLose;
    _labCP1.text = _model.firstWin;
    _labCP2.text = _model.firstDraw;
    _labCP3.text = _model.firstLose;
    _labJP1.textColor = color33;
    _labJP2.textColor = color33;
    _labJP3.textColor = color33;
    if ([_model.finalWin floatValue] > [_model.firstWin floatValue]) {
        _labJP1.textColor = redcolor;
        _imageJP1.image = [UIImage imageNamed:@"plycRedup"];
    }else if ([_model.finalWin floatValue] < [_model.firstWin floatValue]){
        _labJP1.textColor = greencolor;
        _imageJP1.image = [UIImage imageNamed:@"plycgreenDown"];
    }else{
        _labCP1.textColor = color33;
        _imageJP1.image = [UIImage imageNamed:@""];
    }
    if ([_model.finalDraw floatValue] > [_model.firstDraw floatValue]) {
        _labJP2.textColor = redcolor;
        _imageJP2.image = [UIImage imageNamed:@"plycRedup"];
    }else if ([_model.finalDraw floatValue] < [_model.firstDraw floatValue]){
        _labJP2.textColor = greencolor;
        _imageJP2.image = [UIImage imageNamed:@"plycgreenDown"];
    }else{
        _labJP2.textColor = color33;
        _imageJP2.image = [UIImage imageNamed:@""];
    }
    if ([_model.finalLose floatValue] > [_model.firstLose floatValue]) {
        _labJP3.textColor = redcolor;
        _imageJP3.image = [UIImage imageNamed:@"plycRedup"];
    }else if ([_model.finalLose floatValue] < [_model.firstLose floatValue]){
        _labJP3.textColor = greencolor;
        _imageJP3.image = [UIImage imageNamed:@"plycgreenDown"];
    }else{
        _labJP3.textColor = color33;
        _imageJP3.image = [UIImage imageNamed:@""];
    }
    _labWinTitle.text = @"胜";
    _labPingTitle.text = @"平";
    _labLoseTitle.text = @"负";
    _labWin.text = [NSString stringWithFormat:@"%@%%",_model.winAmp] ;
    _labPing.text = [NSString stringWithFormat:@"%@%%",_model.drawAmp];
    _labLose.text = [NSString stringWithFormat:@"%@%%",_model.loseAmp];
    if ([_model.winAmp floatValue] == 0) {
        _labWin.textColor = color33;
        _imageWin.image = [UIImage imageNamed:@""];
    }
    else if ([_model.winAmp containsString:@"-"]) {
        _labWin.textColor = greencolor;
        _imageWin.image = [UIImage imageNamed:@"plycgreenDown"];
    }else{
        _labWin.textColor = redcolor;
        _imageWin.image = [UIImage imageNamed:@"plycRedup"];
    }
    if ([_model.drawAmp floatValue] == 0) {
        _labPing.textColor = color33;
        _imagePing.image = [UIImage imageNamed:@""];
    }
    else if ([_model.drawAmp containsString:@"-"]) {
        _labPing.textColor = greencolor;
        _imagePing.image = [UIImage imageNamed:@"plycgreenDown"];
    }else{
        _labPing.textColor = redcolor;
        _imagePing.image = [UIImage imageNamed:@"plycRedup"];
    }
    if ([_model.loseAmp floatValue] == 0) {
        _labLose.textColor = color33;
        _imageLose.image = [UIImage imageNamed:@""];
    }
    else if ([_model.loseAmp containsString:@"-"]) {
        _labLose.textColor = greencolor;
        _imageLose.image = [UIImage imageNamed:@"plycgreenDown"];
    }else{
        _labLose.textColor = redcolor;
        _imageLose.image = [UIImage imageNamed:@"plycRedup"];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labcompany];
        [_basicView addSubview:self.labJPTitle];
        [_basicView addSubview:self.labJP1];
        [_basicView addSubview:self.labJP2];
        [_basicView addSubview:self.labJP3];
        [_basicView addSubview:self.labJPTime];
        [_basicView addSubview:self.labCPTitle];
        [_basicView addSubview:self.labCP1];
        [_basicView addSubview:self.labCP2];
        [_basicView addSubview:self.labCP3];
        [_basicView addSubview:self.labWinTitle];
        [_basicView addSubview:self.labWin];
        [_basicView addSubview:self.labPingTitle];
        [_basicView addSubview:self.labPing];
        [_basicView addSubview:self.labLoseTitle];
        [_basicView addSubview:self.labLose];
        [_basicView addSubview:self.imageJP1];
        [_basicView addSubview:self.imageJP2];
        [_basicView addSubview:self.imageJP3];
        [_basicView addSubview:self.imageWin];
        [_basicView addSubview:self.imagePing];
        [_basicView addSubview:self.imageLose];
        [_basicView addSubview:self.viewLine];
    }
    return _basicView;
}
- (UILabel *)labcompany
{
    if (!_labcompany) {
        _labcompany = [[UILabel alloc] init];
        _labcompany.textColor = color99;
        _labcompany.font = font10;
        _labcompany.textAlignment = NSTextAlignmentCenter;
    }
    return _labcompany;
}
- (UILabel *)labJPTitle
{
    if (!_labJPTitle) {
        _labJPTitle = [[UILabel alloc] init];
        _labJPTitle.textColor = color99;
        _labJPTitle.font = font11;
        _labJPTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labJPTitle;
}
- (UILabel *)labJP1
{
    if (!_labJP1) {
        _labJP1 = [[UILabel alloc] init];
        _labJP1.textColor = color33;
        _labJP1.font = font11;
        _labJP1.textAlignment = NSTextAlignmentCenter;
    }
    return _labJP1;
}
- (UILabel *)labJP2
{
    if (!_labJP2) {
        _labJP2 = [[UILabel alloc] init];
        _labJP2.textColor = color33;
        _labJP2.font = font11;
        _labJP2.textAlignment = NSTextAlignmentCenter;
    }
    return _labJP2;
}
- (UILabel *)labJP3
{
    if (!_labJP3) {
        _labJP3 = [[UILabel alloc] init];
        _labJP3.textColor = color33;
        _labJP3.font = font11;
        _labJP3.textAlignment = NSTextAlignmentCenter;
    }
    return _labJP3;
}
- (UILabel *)labJPTime
{
    if (!_labJPTime) {
        _labJPTime = [[UILabel alloc] init];
        _labJPTime.textColor = color33;
        _labJPTime.font = font11;
        _labJPTime.textAlignment = NSTextAlignmentCenter;
    }
    return _labJPTime;
}
- (UILabel *)labCPTitle
{
    if (!_labCPTitle) {
        _labCPTitle = [[UILabel alloc] init];
        _labCPTitle.textColor = color99;
        _labCPTitle.font = font11;
        _labCPTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labCPTitle;
}
- (UILabel *)labCP1
{
    if (!_labCP1) {
        _labCP1 = [[UILabel alloc] init];
        _labCP1.textColor = color33;
        _labCP1.font = font11;
        _labCP1.textAlignment = NSTextAlignmentCenter;
    }
    return _labCP1;
}
- (UILabel *)labCP2
{
    if (!_labCP2) {
        _labCP2 = [[UILabel alloc] init];
        _labCP2.textColor = color33;
        _labCP2.font = font11;
        _labCP2.textAlignment = NSTextAlignmentCenter;
    }
    return _labCP2;
}
- (UILabel *)labCP3
{
    if (!_labCP3) {
        _labCP3 = [[UILabel alloc] init];
        _labCP3.textColor = color33;
        _labCP3.font = font11;
        _labCP3.textAlignment = NSTextAlignmentCenter;
    }
    return _labCP3;
}
- (UILabel *)labWinTitle
{
    if (!_labWinTitle) {
        _labWinTitle = [[UILabel alloc] init];
        _labWinTitle.textColor = color99;
        _labWinTitle.font = font11;
        _labWinTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labWinTitle;
}
- (UILabel *)labWin
{
    if (!_labWin) {
        _labWin = [[UILabel alloc] init];
        _labWin.textColor = color33;
        _labWin.font = font10;
        _labWin.textAlignment = NSTextAlignmentCenter;
    }
    return _labWin;
}
- (UILabel *)labPingTitle
{
    if (!_labPingTitle) {
        _labPingTitle = [[UILabel alloc] init];
        _labPingTitle.textColor = color99;
        _labPingTitle.font = font11;
        _labPingTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labPingTitle;
}
- (UILabel *)labPing
{
    if (!_labPing) {
        _labPing = [[UILabel alloc] init];
        _labPing.textColor = color33;
        _labPing.font = font10;
        _labPing.textAlignment = NSTextAlignmentCenter;
    }
    return _labPing;
}
- (UILabel *)labLoseTitle
{
    if (!_labLoseTitle) {
        _labLoseTitle = [[UILabel alloc] init];
        _labLoseTitle.textColor = color99;
        _labLoseTitle.font = font11;
        _labLoseTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labLoseTitle;
}
- (UILabel *)labLose
{
    if (!_labLose) {
        _labLose = [[UILabel alloc] init];
        _labLose.textColor = color33;
        _labLose.font = font10;
        _labLose.textAlignment = NSTextAlignmentCenter;
    }
    return _labLose;
}
- (UIImageView *)imageJP1
{
    if (!_imageJP1) {
        _imageJP1 = [[UIImageView alloc] init];
    }
    return _imageJP1;
}
- (UIImageView *)imageJP2
{
    if (!_imageJP2) {
        _imageJP2 = [[UIImageView alloc] init];
    }
    return _imageJP2;
}
- (UIImageView *)imageJP3
{
    if (!_imageJP3) {
        _imageJP3 = [[UIImageView alloc] init];
    }
    return _imageJP3;
}
- (UIImageView *)imageWin
{
    if (!_imageWin) {
        _imageWin = [[UIImageView alloc] init];
    }
    return _imageWin;
}
- (UIImageView *)imagePing
{
    if (!_imagePing) {
        _imagePing = [[UIImageView alloc] init];
    }
    return _imagePing;
}
- (UIImageView *)imageLose
{
    if (!_imageLose) {
        _imageLose = [[UIImageView alloc] init];
    }
    return _imageLose;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine= [[UIView alloc] init];
        _viewLine.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewLine;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.labcompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(11);
        make.top.equalTo(self.basicView.mas_top).offset(4);
    }];
    [self.labJPTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labcompany.mas_bottom).offset(4);
        make.left.equalTo(self.basicView.mas_left).offset(11);
    }];
    [self.labJP1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labJPTitle.mas_centerY).offset(0);
        make.left.equalTo(self.labJPTitle.mas_right).offset(6);
        make.width.mas_equalTo(40);
    }];
    [self.imageJP1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labJP1.mas_right);
        make.centerY.equalTo(self.labJPTitle.mas_centerY).offset(0);
    }];
    [self.labJP2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labJPTitle.mas_centerY).offset(0);
        make.left.equalTo(self.imageJP1.mas_right).offset(0);
        make.width.mas_equalTo(40);
    }];
    [self.imageJP2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labJP2.mas_right);
        make.centerY.equalTo(self.labJPTitle.mas_centerY).offset(0);
    }];
    [self.labJP3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labJPTitle.mas_centerY).offset(0);
        make.left.equalTo(self.imageJP2.mas_right).offset(0);
        make.width.mas_equalTo(40);
    }];
    [self.imageJP3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labJP3.mas_right);
        make.centerY.equalTo(self.labJPTitle.mas_centerY).offset(0);
    }];
    [self.labJPTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageJP3.mas_right).offset(5);
        make.centerY.equalTo(self.labJPTitle.mas_centerY).offset(0);
    }];
    [self.labCPTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labJPTitle.mas_bottom).offset(3);
        make.left.equalTo(self.basicView.mas_left).offset(11);
    }];
    [self.labCP1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCPTitle.mas_centerY).offset(0);
        make.centerX.equalTo(self.labJP1.mas_centerX).offset(0);
        make.width.mas_equalTo(40);
    }];
    [self.labCP2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCPTitle.mas_centerY).offset(0);
        make.centerX.equalTo(self.labJP2.mas_centerX).offset(0);
        make.width.mas_equalTo(40);
    }];
    [self.labCP3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCPTitle.mas_centerY).offset(0);
        make.centerX.equalTo(self.labJP3.mas_centerX).offset(0);
        make.width.mas_equalTo(40);
    }];
    [self.imageLose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labJPTitle.mas_centerY);
        make.right.equalTo(self.basicView.mas_right).offset(-12);
    }];
    [self.labLose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageLose.mas_left);
        make.centerY.equalTo(self.labJPTitle.mas_centerY);
        make.width.mas_equalTo(43);
    }];
    [self.imagePing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labJPTitle.mas_centerY);
        make.right.equalTo(self.labLose.mas_left).offset(0);
    }];
    [self.labPing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imagePing.mas_left);
        make.centerY.equalTo(self.labJPTitle.mas_centerY);
        make.width.mas_equalTo(43);
    }];
    [self.imageWin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labJPTitle.mas_centerY);
        make.right.equalTo(self.labPing.mas_left).offset(0);
    }];
    [self.labWin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageWin.mas_left);
        make.centerY.equalTo(self.labJPTitle.mas_centerY);
        make.width.mas_equalTo(43);
    }];
    [self.labWinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCPTitle.mas_centerY);
        make.centerX.equalTo(self.labWin.mas_centerX);
    }];
    [self.labPingTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCPTitle.mas_centerY);
        make.centerX.equalTo(self.labPing.mas_centerX);
    }];
    [self.labLoseTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCPTitle.mas_centerY);
        make.centerX.equalTo(self.labLose.mas_centerX);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 10));
    }];
}
@end

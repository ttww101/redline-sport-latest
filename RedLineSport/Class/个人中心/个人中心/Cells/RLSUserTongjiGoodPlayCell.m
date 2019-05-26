#import "DCImageViewRoundCorner.h"
#import "RLSUserTongjiGoodPlayCell.h"
@interface RLSUserTongjiGoodPlayCell()
@property (nonatomic, assign) BOOL isaddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIView *viewSqureTen;
@property (nonatomic, strong) UILabel *labTen;
@property (nonatomic, strong) UIView *viewTen;
@property (nonatomic, strong) UILabel *labYuan;
@property (nonatomic, strong) UILabel *labJin;
@property (nonatomic, strong) UILabel *labgoodLeague;
@property (nonatomic, strong) UILabel *lableague1;
@property (nonatomic, strong) UILabel *lableague2;
@property (nonatomic, strong) UILabel *lableague3;
@property (nonatomic, strong) UILabel *lableague4;
@property (nonatomic, strong) UILabel *labgoodPlay;
@property (nonatomic, strong) UILabel *labplay1;
@property (nonatomic, strong) UILabel *labplay2;
@property (nonatomic, strong) UILabel *labplay3;
@property (nonatomic, strong) UILabel *labplay4;
@property (nonatomic, strong) UIView *viewLine;
@end
@implementation RLSUserTongjiGoodPlayCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSUserTongjiModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddlayout) {
        _isaddlayout = YES;
        [self addLayout];
    }
    _labgoodLeague.text = @"擅长赛事";
    if (_model.goodSclass.count == 0) {
        _lableague1.text = @"无";
        _lableague1.textColor = color66;
    }else{
        _lableague1.textColor = redcolor;
    }
    for (int i= 0; i<_model.goodSclass.count; i++) {
        switch (i) {
            case 0:
            {
                _lableague1.text = [_model.goodSclass objectAtIndex:i];
            }
                break;
            case 1:
            {
                _lableague2.text = [_model.goodSclass objectAtIndex:i];
            }
                break;
            case 2:
            {
                _lableague3.text = [_model.goodSclass objectAtIndex:i];
            }
                break;
            case 3:
            {
                _lableague4.text = [_model.goodSclass objectAtIndex:i];
            }
                break;
            default:
                break;
        }
    }
    _labgoodPlay.text = @"擅长玩法";
    if (_model.goodPlays.count == 0) {
        _labplay1.text = @"无";
    }
    for (int i= 0; i<_model.goodPlays.count; i++) {
        switch (i) {
            case 0:
            {
                _labplay1.text = [_model.goodPlays objectAtIndex:i];
            }
                break;
            case 1:
            {
                _lableague2.text = [_model.goodPlays objectAtIndex:i];
            }
                break;
            case 2:
            {
                _lableague3.text = [_model.goodPlays objectAtIndex:i];
            }
                break;
            case 3:
            {
                _lableague4.text = [_model.goodPlays objectAtIndex:i];
            }
                break;
            default:
                break;
        }
    }
    _labTen.text = @"输赢走势";
    _labYuan.text = @"近";
    _labJin.text = @"远";
    [_viewTen removeAllSubViews];
    NSArray *arrNearTen = _recent;
    CGFloat labWinSpace = (Width -26*2 - 20*arrNearTen.count)/(arrNearTen.count + 1);
    for (int i = 0; i<arrNearTen.count; i++) {
        UILabel *labWin = [[UILabel alloc] init];
        labWin.frame = CGRectMake(26 + labWinSpace*(i + 1) + 20*i , 0, 20, 20);
        labWin.center = CGPointMake(labWin.center.x, 15);
        if ([[arrNearTen objectAtIndex:i] isEqualToString:@"赢"]) {
            DCImageViewRoundCorner *imageCorner = [[DCImageViewRoundCorner alloc] initWithFrame:labWin.bounds];
            imageCorner.image = [UIImage imageNamed:@"red"];
            [imageCorner addCornerRadius:imageCorner.size.width/2];
            [labWin addSubview:imageCorner];
        }else if ([[arrNearTen objectAtIndex:i] isEqualToString:@"输"]){
            DCImageViewRoundCorner *imageCorner = [[DCImageViewRoundCorner alloc] initWithFrame:labWin.bounds];
            imageCorner.image = [UIImage imageNamed:@"colorGreen"];
            [imageCorner addCornerRadius:imageCorner.size.width/2];
            [labWin addSubview:imageCorner];
        }else if ([[arrNearTen objectAtIndex:i] isEqualToString:@"走"]){
            DCImageViewRoundCorner *imageCorner = [[DCImageViewRoundCorner alloc] initWithFrame:labWin.bounds];
            imageCorner.image = [UIImage imageNamed:@"color99"];
            [imageCorner addCornerRadius:imageCorner.size.width/2];
            [labWin addSubview:imageCorner];
        }else{
            DCImageViewRoundCorner *imageCorner = [[DCImageViewRoundCorner alloc] initWithFrame:labWin.bounds];
            imageCorner.image = [UIImage imageNamed:@"red"];
            [imageCorner addCornerRadius:imageCorner.size.width/2];
            [labWin addSubview:imageCorner];
        }
        labWin.textColor = [UIColor whiteColor];
        labWin.font = font12;
        labWin.text = [arrNearTen objectAtIndex:i];
        labWin.textAlignment = NSTextAlignmentCenter;
        [_viewTen addSubview:labWin];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labgoodLeague];
        [_basicView addSubview:self.lableague1];
        [_basicView addSubview:self.lableague2];
        [_basicView addSubview:self.lableague3];
        [_basicView addSubview:self.lableague4];
        [_basicView addSubview:self.labgoodPlay];
        [_basicView addSubview:self.labplay1];
        [_basicView addSubview:self.labplay2];
        [_basicView addSubview:self.labplay3];
        [_basicView addSubview:self.labplay4];
        [_basicView addSubview:self.viewLine];
        [_basicView addSubview:self.viewSqureTen];
        [_basicView addSubview:self.labTen];
        [_basicView addSubview:self.viewTen];
        [_basicView addSubview:self.labYuan];
        [_basicView addSubview:self.labJin];
    }
    return _basicView;
}
- (UIView *)viewSqureTen
{
    if (!_viewSqureTen) {
        _viewSqureTen = [[UIView alloc] init];
        _viewSqureTen.backgroundColor = yellowcolor;
    }
    return _viewSqureTen;
}
- (UILabel *)labTen
{
    if (!_labTen) {
        _labTen = [[UILabel alloc] init];
        _labTen.textColor = color66;
        _labTen.font = font12;
    }
    return _labTen;
}
- (UIView *)viewTen
{
    if (!_viewTen) {
        _viewTen = [[UIView alloc] init];
    }
    return _viewTen;
}
- (UILabel *)labYuan
{
    if (!_labYuan) {
        _labYuan = [[UILabel alloc] init];
        _labYuan.textColor = color99;
        _labYuan.font = font10;
    }
    return _labYuan;
}
- (UILabel *)labJin
{
    if (!_labJin) {
        _labJin = [[UILabel alloc] init];
        _labJin.textColor = color99;
        _labJin.font = font10;
    }
    return _labJin;
}
- (UILabel *)labgoodLeague
{
    if (!_labgoodLeague) {
        _labgoodLeague = [[UILabel alloc] init];
        _labgoodLeague.font = font12;
        _labgoodLeague.textColor = color33;
    }
    return _labgoodLeague;
}
- (UILabel *)lableague1
{
    if (!_lableague1) {
        _lableague1 = [[UILabel alloc] init];
        _lableague1.font = font12;
        _lableague1.textColor = redcolor;
    }
    return _lableague1;
}
- (UILabel *)lableague2
{
    if (!_lableague2) {
        _lableague2 = [[UILabel alloc] init];
        _lableague2.font = font12;
        _lableague2.textColor = redcolor;
    }
    return _lableague2;
}
- (UILabel *)lableague3
{
    if (!_lableague3) {
        _lableague3 = [[UILabel alloc] init];
        _lableague3.font = font12;
        _lableague3.textColor = redcolor;
    }
    return _lableague3;
}
- (UILabel *)lableague4
{
    if (!_lableague4) {
        _lableague4 = [[UILabel alloc] init];
        _lableague4.font = font12;
        _lableague4.textColor = redcolor;
    }
    return _lableague4;
}
- (UILabel *)labgoodPlay
{
    if (!_labgoodPlay) {
        _labgoodPlay = [[UILabel alloc] init];
        _labgoodPlay.font = font12;
        _labgoodPlay.textColor = color33;
    }
    return _labgoodPlay;
}
- (UILabel *)labplay1
{
    if (!_labplay1) {
        _labplay1 = [[UILabel alloc] init];
        _labplay1.font = font12;
        _labplay1.textColor = color66;
    }
    return _labplay1;
}
- (UILabel *)labplay2
{
    if (!_labplay2) {
        _labplay2 = [[UILabel alloc] init];
        _labplay2.font = font12;
        _labplay2.textColor = color66;
    }
    return _labplay2;
}
- (UILabel *)labplay3
{
    if (!_labplay3) {
        _labplay3 = [[UILabel alloc] init];
        _labplay3.font = font12;
        _labplay3.textColor = color66;
    }
    return _labplay3;
}
- (UILabel *)labplay4
{
    if (!_labplay4) {
        _labplay4 = [[UILabel alloc] init];
        _labplay4.font = font12;
        _labplay4.textColor = color66;
    }
    return _labplay4;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewLine;
}
- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.labTen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.basicView.mas_top).offset(12.5);
    }];
    [self.viewSqureTen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(6);
        make.centerY.equalTo(self.labTen.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    [self.viewTen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(0);
        make.top.equalTo(self.basicView.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(Width, 30));
    }];
    [self.labYuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(17);
        make.centerY.equalTo(self.viewTen.mas_centerY);
    }];
    [self.labJin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-17);
        make.centerY.equalTo(self.viewTen.mas_centerY);
    }];
    [self.labgoodLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.basicView.mas_top).offset(11.5 + 60);
    }];
    [self.lableague1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labgoodLeague.mas_right).offset(12.5);
        make.centerY.equalTo(self.labgoodLeague.mas_centerY).offset(0);
    }];
    [self.lableague2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableague1.mas_right).offset(15);
        make.centerY.equalTo(self.labgoodLeague.mas_centerY).offset(0);
    }];
    [self.lableague3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableague2.mas_right).offset(15);
        make.centerY.equalTo(self.labgoodLeague.mas_centerY).offset(0);
    }];
    [self.lableague4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lableague3.mas_right).offset(15);
        make.centerY.equalTo(self.labgoodLeague.mas_centerY).offset(0);
    }];
    [self.labgoodPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-20);
    }];
    [self.labplay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labgoodPlay.mas_right).offset(12.5);
        make.centerY.equalTo(self.labgoodPlay.mas_centerY).offset(0);
    }];
    [self.labplay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labplay1.mas_right).offset(12.5);
        make.centerY.equalTo(self.labgoodPlay.mas_centerY).offset(0);
    }];
    [self.labplay3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labplay2.mas_right).offset(12.5);
        make.centerY.equalTo(self.labgoodPlay.mas_centerY).offset(0);
    }];
    [self.labplay4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labplay3.mas_right).offset(12.5);
        make.centerY.equalTo(self.labgoodPlay.mas_centerY).offset(0);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 10));
    }];
}
@end

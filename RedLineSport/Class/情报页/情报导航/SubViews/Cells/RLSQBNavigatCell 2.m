#import "RLSQBNavigatCell.h"
@interface RLSQBNavigatCell()
@property (nonatomic, strong)UIView *basView;
@property (nonatomic, strong)UILabel *labHome;
@property (nonatomic, strong)UILabel *labVS;
@property (nonatomic, strong)UILabel *labGues;
@property (nonatomic, strong)UILabel *labLeague;
@property (nonatomic, strong)UILabel *labTime;
@property (nonatomic, strong)UILabel *labNum;
@property (nonatomic, strong)UIView *lineView;
@end
@implementation RLSQBNavigatCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.basView];
        [self.basView addSubview:self.labHome];
        [self.basView addSubview:self.labVS];
        [self.basView addSubview:self.labGues];
        [self.basView addSubview:self.labLeague];
        [self.basView addSubview:self.labTime];
        [self.basView addSubview:self.labNum];
        [self.basView addSubview:self.lineView];
        [self setMas];
    }
    return self;
}
- (UIView *)basView{
    if (!_basView) {
        _basView = [[UIView alloc] init];
        _basView.backgroundColor = [UIColor clearColor];
    }
    return _basView;
}
- (UILabel *)labHome{
    if (!_labHome) {
        _labHome = [[UILabel alloc] init];
        _labHome.font = font16;
        _labHome.textColor = color33;
        _labHome.text = @"塔什干火车";
    }
    return _labHome;
}
- (UILabel *)labVS{
    if (!_labVS) {
        _labVS = [[UILabel alloc] init];
        _labVS.textColor = color66;
        _labVS.font = font16;
        _labVS.text = @"vs";
    }
    return _labVS;
}
- (UILabel *)labGues{
    if (!_labGues) {
        _labGues = [[UILabel alloc] init];
        _labGues.textColor = color33;
        _labGues.font = font16;
        _labGues.text = @"塔亚文";
    }
    return _labGues;
}
- (UILabel *)labLeague{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.font = font12;
        _labLeague.textColor = color66;
        _labLeague.text = @"亚冠军";
    }
    return _labLeague;
}
- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.textColor = color66;
        _labTime.font = font12;
        _labTime.text = @"04-01 23:50";
    }
    return _labTime;
}
- (UILabel *)labNum{
    if (!_labNum) {
        _labNum = [[UILabel alloc] init];
        _labNum.textColor = redcolor;
        _labNum.font = font10;
        _labNum.layer.cornerRadius = 3;
        _labNum.layer.borderWidth = 0.5;
        _labNum.layer.borderColor = redcolor.CGColor;
        _labNum.text = @"情报23";
        _labNum.textAlignment = NSTextAlignmentCenter;
    }
    return _labNum;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorDD;
    }
    return _lineView;
}
- (void)setModel:(RLSNavigationModel *)model{
    _model = model;
    NSString *home = _model.hometeam;
    NSString *guest = _model.guestteam;
    if (isOniPhone4 || isOniPhone5) {
        if (home.length>5) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:5]];
        }
        if (guest.length>5) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:5]];
        }
    }else{
        if (home.length>7) {
            home = [NSString stringWithFormat:@"%@…",[home substringToIndex:7]];
        }
        if (guest.length>7) {
            guest = [NSString stringWithFormat:@"%@…",[guest substringToIndex:7]];
        }
    }
    self.labHome.text = home;
    self.labGues.text = guest;
    self.labLeague.text = model.league;
    self.labLeague.textColor = [RLSMethods getColor:model.leagueColor];
    self.labTime.text = [NSString stringWithFormat:@"%@",[RLSMethods getDateByStyle:dateStyleFormatterMdHm withDate:[NSDate dateWithTimeIntervalSince1970:[model.matchtime doubleValue]/1000]]];
    self.labNum.text = [NSString stringWithFormat:@"情报%ld",model.info_count];
}
- (void)setMas{
    [self.basView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self.labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.basView.mas_left).offset(15);
        make.top.mas_equalTo(self.basView.mas_top).offset(15);
    }];
    [self.labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labHome.mas_right).offset(10);
        make.bottom.mas_equalTo(self.labHome.mas_bottom);
    }];
    [self.labGues mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labVS.mas_right).offset(10);
        make.top.mas_equalTo(self.labHome.mas_top);
    }];
    [self.labLeague  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labHome.mas_left);
        make.top.mas_equalTo(self.labHome.mas_bottom).offset(7.5);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labLeague.mas_right).offset(5);
        make.top.mas_equalTo(self.labLeague.mas_top);
    }];
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.basView.mas_right).offset(-15);
        make.top.mas_equalTo(self.labHome.mas_top);
        make.width.mas_offset(42);
        make.height.mas_offset(19);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.basView.mas_left);
        make.right.mas_equalTo(self.basView.mas_right);
        make.height.mas_offset(0.5);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end

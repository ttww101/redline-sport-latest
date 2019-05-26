#import "RLSNewQingBaoCell.h"
@interface RLSNewQingBaoCell()
@property (nonatomic, strong)UIView *BGView;
@property (nonatomic, strong)UILabel *labTime;
@property (nonatomic, strong)UILabel *labType;
@property (nonatomic, strong)UILabel *labTitle;
@property (nonatomic, strong)UILabel *labContent;
@property (nonatomic, strong)UILabel *labHome;
@property (nonatomic, strong)UILabel *labVs;
@property (nonatomic, strong)UILabel *labGues;
@property (nonatomic, strong)UIImageView *homeImg;
@property (nonatomic, strong)UIImageView *guesImg;
@property (nonatomic, strong)UILabel *labLeg;
@property (nonatomic, strong)UILabel *labFabuTime;
@property (nonatomic, strong)UIImageView *logoImg;
@property (nonatomic, strong)UIImageView *imgType;
@property (nonatomic, assign)BOOL isAddLayout;
@end
@implementation RLSNewQingBaoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.BGView];
        [self.BGView addSubview:self.labTime];
        [self.BGView addSubview:self.labType];
        [self.BGView addSubview:self.labTitle];
        [self.BGView addSubview:self.labContent];
        [self.BGView addSubview:self.logoImg];
        [self.BGView addSubview:self.labHome];
        [self.BGView addSubview:self.labVs];
        [self.BGView addSubview:self.labGues];
        [self.BGView addSubview:self.homeImg];
        [self.BGView addSubview:self.guesImg];
        [self.BGView addSubview:self.labLeg];
        [self.BGView addSubview:self.labFabuTime];
        [self.BGView addSubview:self.imgType];
        _isAddLayout = YES;
        if (_isAddLayout) {
            _isAddLayout = NO;
            [self addlayoutSubviews];
        }
    }
    return self;
}
-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc] init];
        _BGView.backgroundColor = [UIColor clearColor];
    }
    return _BGView;
}
- (UIImageView *)imgType{
    if (!_imgType) {
        _imgType = [[UIImageView alloc] init];
        _imgType.image = [UIImage imageNamed:@"clear"];
    }
    return _imgType;
}
- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font12;
        _labTime.text = @"4月23日 09:13";
        _labTime.textColor = color99;
    }
    return _labTime;
}
- (UILabel *)labType{
    if (!_labType) {
        _labType = [[UILabel alloc] init];
        _labType.font = font12;
        _labType.textColor = [UIColor whiteColor];
        _labType.text = @"状态";
        _labType.textAlignment = NSTextAlignmentCenter;
        _labType.layer.cornerRadius = 2;
        _labType.layer.masksToBounds = YES;
    }
    return  _labType;
}
- (UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"YHLogo"];
    }
    return _logoImg;
}
-(UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.text = @"川琪主力了门将站救助";
        _labTitle.font = font20;
        _labTitle.textColor = color33;
    }
    return _labTitle;
}
- (UILabel *)labContent{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.font = font14;
        _labContent.textColor = color66;
        _labContent.text = @"啊哈放假后房价还会激发回家啊等你放假啊不能说的肌肤搬家啊大部分将阿塞拜疆分阿萨德年发布山东济南啊傻逼你的肌肤吧回家";
        _labContent.numberOfLines = 4;
        _labContent.attributedText = [RLSMethods setTextStyleWithString:_labContent.text WithLineSpace:5.5 WithHeaderIndent:Width - 30];
    }
    return _labContent;
}
- (UILabel *)labHome{
    if (!_labHome) {
        _labHome = [[UILabel alloc] init];
        _labHome.font = font12;
        _labHome.textColor = color33;
        _labHome.text = @"沙佩科恩斯";
    }
    return _labHome;
}
- (UILabel *)labVs{
    if (!_labVs) {
        _labVs = [[UILabel alloc] init];
        _labVs.text = @"vs";
        _labVs.textColor = color99;
        _labVs.font = font12;
    }
    return _labVs;
}
- (UILabel *)labGues{
    if (!_labGues) {
        _labGues = [[UILabel alloc] init];
        _labGues.font = font12;
        _labGues.textColor = color33;
        _labGues.text = @"沙佩科恩斯";
    }
    return _labGues;
}
- (UIImageView *)homeImg{
    if (!_homeImg) {
        _homeImg = [[UIImageView alloc] init];
    }
    return _homeImg;
}
- (UIImageView *)guesImg{
    if (!_guesImg) {
        _guesImg = [[UIImageView alloc] init];
    }
    return _guesImg;
}
- (UILabel *)labLeg{
    if (!_labLeg) {
        _labLeg = [[UILabel alloc] init];
        _labLeg.text = @"巴西甲";
        _labLeg.font = font12;
        _labLeg.textColor = color66;
    }
    return _labLeg;
}
- (UILabel *)labFabuTime{
    if (!_labFabuTime) {
        _labFabuTime = [[UILabel alloc] init];
        _labFabuTime.text = @"04-01 23:50";
        _labFabuTime.textColor = color66;
        _labFabuTime.font = font12;
    }
    return _labFabuTime;
}
- (void)setModel:(RLSQingBaoFPTwoModel *)model{
    _model = model;
    self.labTime.text = [NSString stringWithFormat:@"发布于 %@",[RLSMethods getDateByStyle:@"MM月dd日 HH:mm" withDate:[NSDate dateWithTimeIntervalSince1970:[model.createtime doubleValue]/1000]]];
    self.labTitle.numberOfLines = 2;
    self.labTitle.text = [NSString stringWithFormat:@"%@",model.title];
    self.labTitle.attributedText = [RLSMethods setTextStyleWithString:self.labTitle.text WithLineSpace:5 WithHeaderIndent:Width - 30];
    self.labContent.text = [NSString stringWithFormat:@"       %@",model.content];
    self.labHome.text = model.hometeam;
    self.labGues.text = model.guestteam;
    if (isOniPhone4 || isOniPhone5) {
        if (self.labHome.text.length > 3) {
            self.labHome.text = [NSString stringWithFormat:@"%@...",[self.labHome.text substringToIndex:3]];
        }
        if (self.labGues.text.length > 3) {
            self.labGues.text = [NSString stringWithFormat:@"%@...",[self.labGues.text substringToIndex:3]];
        }
    }else if(isOniphone6 || isOniphone7){
        if (self.labHome.text.length > 5) {
            self.labHome.text = [NSString stringWithFormat:@"%@...",[self.labHome.text substringToIndex:6]];
        }
        if (self.labGues.text.length > 5) {
            self.labGues.text = [NSString stringWithFormat:@"%@...",[self.labGues.text substringToIndex:6]];
        }
    }
    [self.homeImg sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(model.hometeamid)]];
    [self.guesImg sd_setImageWithURL:[NSURL URLWithString:url_imageTeam(model.guestteamid)]];
    self.labFabuTime.text = [NSString stringWithFormat:@"%@",[RLSMethods getDateByStyle:dateStyleFormatterMdHm withDate:[NSDate dateWithTimeIntervalSince1970:[model.mtime doubleValue]/1000]]];
    self.labLeg.text = model.league;
    self.labLeg.textColor = [RLSMethods getColor:model.leagueColor];
    self.labContent.attributedText = [RLSMethods setTextStyleWithString:self.labContent.text WithLineSpace:5.5 WithHeaderIndent:Width - 30];
    switch (model.mark) {
        case 1:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeDuJia"];
        }
            break;
        case 2:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeHaiWai"];
        }
            break;
        case 3:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeTuFa"];
        }
            break;
        case 4:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeLiC"];
        }
            break;
        case 5:{
            self.imgType.image = [UIImage imageNamed:@"QBTypeNeiMu"];
        }
            break;
        default:
        {
            self.imgType.image = [UIImage imageNamed:@"clear"];
        }
            break;
    }
}
- (void)addlayoutSubviews{
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top).priorityHigh();
        make.bottom.equalTo(self.contentView.mas_bottom).priorityHigh();
    }];
    [self.labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.homeImg.mas_left).offset(-5);
        make.centerY.equalTo(self.labGues.mas_centerY);
    }];
    [self.homeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labVs.mas_left).offset(-5);
        make.centerY.equalTo(self.labGues.mas_centerY);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    [self.labVs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.guesImg.mas_left).offset(-5);
        make.centerY.equalTo(self.labGues.mas_centerY);
    }];
    [self.guesImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labGues.mas_left).offset(-5);
        make.centerY.equalTo(self.labGues.mas_centerY);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    [self.labGues mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView.mas_top).offset(17.5);
        make.right.equalTo(self.BGView.mas_right).offset(-15);
    }];
    [self.labFabuTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BGView.mas_bottom).offset(-17.5);
        make.right.equalTo(self.BGView.mas_right).offset(-15);
    }];
    [self.labLeg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labFabuTime.mas_left).offset(-5);
        make.centerY.equalTo(self.labFabuTime.mas_centerY);
    }];
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView.mas_left).offset(15);
        make.top.equalTo(self.labHome.mas_bottom).offset(12.5).priorityHigh();
        make.right.equalTo(self.BGView.mas_right).offset(-15);
    }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGView.mas_left).offset(15);
        make.right.equalTo(self.BGView.mas_right).offset(-15);
        make.top.equalTo(self.labTitle.mas_bottom).offset(8.5).priorityHigh();
    }];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labContent.mas_left);
        make.top.equalTo(self.labContent.mas_top).offset(-2);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    [self.imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTitle.mas_top).offset(5);
        make.right.equalTo(self.BGView.mas_right);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end

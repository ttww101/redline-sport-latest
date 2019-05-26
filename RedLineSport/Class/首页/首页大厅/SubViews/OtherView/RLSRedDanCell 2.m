#import "RLSRedDanCell.h"
#import "DCImageViewRoundCorner.h"
#import "RLSTuijianDetailVC.h"
@interface RLSRedDanCell()
@property (nonatomic, strong)UIView *basicView;
@property (nonatomic, strong)UIImageView *basImgView;
@property (nonatomic, strong)DCImageViewRoundCorner *imgPhone;
@property (nonatomic, strong)UIImageView *img;
@property (nonatomic, strong)UILabel *labName;
@property (nonatomic, strong)UILabel *labRedNum;
@property (nonatomic, strong)UILabel *labSL;
@property (nonatomic, strong)UILabel *labSLStr;
@property (nonatomic, strong)UIView *BkView;
@property (nonatomic, strong)UILabel *labSPF;
@property (nonatomic, strong)UILabel *labType;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *labHome;
@property (nonatomic, strong)UILabel *labScroe;
@property (nonatomic, strong)UILabel *labGues;
@property (nonatomic, strong)UILabel *labTime;
@property (nonatomic, assign) BOOL isaddlayout;
@end
@implementation RLSRedDanCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
    }
    return self;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [self.basicView addSubview:self.basImgView];
        [self.basicView addSubview:self.imgPhone];
        [self.basicView addSubview:self.labName];
        [self.basicView addSubview:self.labRedNum];
        [self.basicView addSubview:self.labSL];
        [self.basicView addSubview:self.labSLStr];
        [self.basicView addSubview:self.BkView];
        [self.BkView addSubview:self.labSPF];
        [self.BkView addSubview:self.labTime];
        [self.BkView addSubview:self.labScroe];
        [self.BkView addSubview:self.labHome];
        [self.BkView addSubview:self.labGues];
        [self.BkView addSubview:self.img];
        UITapGestureRecognizer *tap  =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFPinfo)];
        [self.basicView addGestureRecognizer:tap];
    }
    return _basicView;
}
- (void)tapFPinfo{
    RLSTuijianDetailVC *infoVC = [[RLSTuijianDetailVC alloc] init];
    infoVC.hidesBottomBarWhenPushed = YES;
    infoVC.modelId = _model.newsId;
    [APPDELEGATE.customTabbar pushToViewController:infoVC animated:YES];
}
- (UIImageView *)basImgView{
    if (!_basImgView ) {
        _basImgView = [[UIImageView alloc] init];
        _basImgView.image = [UIImage imageNamed:@"redDanBG"];
    }
    return _basImgView;
}
- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = [UIImage imageNamed:@"win"];
    }
    return _img;
}
- (DCImageViewRoundCorner *)imgPhone{
    if (!_imgPhone) {
        _imgPhone = [[DCImageViewRoundCorner alloc] init];
        _imgPhone.image = [UIImage imageNamed:@"defaultPic"];
        _imgPhone.layer.cornerRadius = 23;
        _imgPhone.layer.masksToBounds = YES;
    }
    return _imgPhone;
}
- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] init];
        _labName.font = font14;
        _labName.textColor = color33;
        _labName.text = @"分析师李人杰";
    }
    return _labName;
}
- (UILabel *)labRedNum{
    if (!_labRedNum) {
        _labRedNum = [[UILabel alloc] init];
        _labRedNum.textColor = [UIColor whiteColor];
        _labRedNum.font = font10;
        _labRedNum.backgroundColor = redcolor;
        _labRedNum.layer.cornerRadius = 14/2;
        _labRedNum.layer.masksToBounds = YES;
        _labRedNum.text = @"  7连红  ";
    }
    return _labRedNum;
}
- (UILabel *)labSL{
    if (!_labSL) {
        _labSL = [[UILabel alloc] init];
        _labSL.font = font24;
        _labSL.textColor = redcolor;
        _labSL.text = @"86%";
    }
    return _labSL;
}
- (UILabel *)labSLStr{
    if (!_labSLStr) {
        _labSLStr = [[UILabel alloc] init];
        _labSLStr.font = font11;
        _labSLStr.textColor = color66;
        _labSLStr.text = @" 近7天胜率";
    }
    return _labSLStr;
}
- (UIView *)BkView{
    if (!_BkView) {
        _BkView = [[UIView alloc] init];
        _BkView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    }
    return _BkView;
}
- (UILabel *)labSPF{
    if (!_labSPF) {
        _labSPF = [[UILabel alloc] init];
        _labSPF.textColor = color66;
        _labSPF.font = font12;
        _labSPF.text = @"胜平负";
    }
    return _labSPF;
}
- (UILabel *)labType{
    if (!_labType) {
        _labType = [[UILabel alloc] init];
        _labType.font = font12;
        _labType.textColor = bluecolor;
        _labType.text = @"胜";
    }
    return _labType;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorDD;
    }
    return _lineView;
}
- (UILabel *)labHome{
    if (!_labHome) {
        _labHome = [[UILabel alloc] init];
        _labHome.textColor = color33;
        _labHome.font = font12;
        _labHome.text = @"曼切斯特斯特";
    }
    return _labHome;
}
- (UILabel *)labScroe{
    if (!_labScroe) {
        _labScroe = [[UILabel alloc] init];
        _labScroe.textColor = redcolor;
        _labScroe.font = font12;
        _labScroe.text = @"5:0";
    }
    return _labScroe;
}
- (UILabel *)labGues{
    if (!_labGues) {
        _labGues = [[UILabel alloc] init];
        _labGues.font = font12;
        _labGues.textColor = color33;
        _labGues.text = @"罗斯托夫水电";
    }
    return _labGues;
}
- (UILabel *)labTime{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font12;
        _labTime.textColor = color99;
        _labTime.text = @"04-01";
    }
    return _labTime;
}
- (void)setModel:(RLSRedDanModel *)model{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddlayout == YES) {
        _isaddlayout = YES;
        [self setMas];
    }
    self.labName.text = model.nickName;
    self.labRedNum.text = [NSString stringWithFormat:@"  %@  ",model.usermark[0][@"remark"]];
    self.labSL.text = model.winRate;
    self.labSL.attributedText = [RLSMethods withContent:self.labSL.text WithColorText:@"%" textColor:redcolor strFont:font17];
    self.labSPF.text = model.play;
    self.labType.text = model.choice;
    self.labHome.text = model.homeTeam;
    self.labGues.text = model.guestTeam;
    self.labScroe.text = [NSString stringWithFormat:@"%ld:%ld",model.homescore,model.guestscore];
    self.labTime.text = [NSString stringWithFormat:@"%@",[RLSMethods getDateByStyle:@"MM-dd" withDate:[NSDate dateWithTimeIntervalSince1970:[model.matchTime doubleValue]/1000]]];
    [self.imgPhone sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"defaultPic"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
    if (model.result == 1) {
        self.img.image = [UIImage imageNamed:@"winhalf"];
    }else{
        self.img.image = [UIImage imageNamed:@"win"];
    }
}
- (void)setMas{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
    [self.basImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.basicView.mas_left).offset(15);
        make.right.mas_equalTo(self.basicView.mas_right).offset(-15);
        make.top.mas_equalTo(self.basicView.mas_top);
        make.bottom.mas_equalTo(self.basicView.mas_bottom);
    }];
    [self.imgPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.basImgView.mas_left).offset(10);
        make.top.mas_equalTo(self.basImgView.mas_top).offset(15);
        make.width.mas_offset(46);
        make.height.mas_offset(46);
    }];
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imgPhone.mas_right).offset(10);
        make.bottom.mas_equalTo(self.imgPhone.mas_centerY).offset(-3.5);
    }];
    [self.labRedNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_left);
        make.top.mas_equalTo(self.imgPhone.mas_centerY).offset(3.5);
        make.height.mas_offset(14);
    }];
    [self.labSL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.basImgView.mas_right).offset(-10);
        make.top.mas_equalTo(self.labName.mas_top);
    }];
    [self.labSLStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labSL.mas_right);
        make.top.mas_equalTo(self.labSL.mas_bottom).offset(5);
    }];
    [self.BkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.basImgView.mas_left).offset(10);
        make.top.mas_equalTo(self.imgPhone.mas_bottom).offset(10);
        make.right.mas_equalTo(self.basImgView.mas_right).offset(-10);
        make.height.mas_offset(20);
    }];
    [self.labSPF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.BkView.mas_left).offset(10);
        make.centerY.mas_equalTo(self.BkView.mas_centerY);
    }];
    [self.labScroe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.BkView.mas_centerY);
        make.centerX.mas_equalTo(self.BkView.mas_centerX);
    }];
    [self.labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labScroe.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.labScroe.mas_centerY);
    }];
    [self.labGues mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labScroe.mas_right).offset(5);
        make.centerY.mas_equalTo(self.labScroe.mas_centerY);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.BkView.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.BkView.mas_centerY);
    }];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.basImgView.mas_top).offset(20);
        make.right.mas_equalTo(self.basImgView.mas_right).offset(-80);
    }];
}
@end

#import "RLSUsermarkModel.h"
#import "RLSMedalsModel.h"
#import "RLSUserViewOfTuijianCell.h"
@interface RLSUserViewOfTuijianCell()
@property (nonatomic, assign) BOOL addedAutoLayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIButton *btnAuthorPic;
@property (nonatomic, strong) UILabel *btnAuthor;
@property (nonatomic, strong) UIImageView *imageSpace;
@property (nonatomic, strong) UIImageView *imageAuthorTitle;
@property (nonatomic, strong) UIImageView *imageAuthorTitle1;
@property (nonatomic, strong) UIImageView *imageAuthorTitle2;
@property (nonatomic, strong) UIButton *imageFanTitle;
@property (nonatomic, strong) UILabel *labFanNum;
@property (nonatomic, strong) UIButton *imageWinTitle;
@property (nonatomic, strong) UILabel *labWinNum;
@property (nonatomic, strong) UIButton *imageProfitTitle;
@property (nonatomic, strong) UILabel *labProfitNum;
@property (nonatomic, strong) UIButton *imageRecommendTitle;
@property (nonatomic, strong) UILabel *labRecommendNum;
@property (nonatomic, strong) UILabel *labNewWinNum;
@property (nonatomic, strong) UILabel *labNewWinTitle;
@property (nonatomic, strong) UILabel *labRemark1;
@property (nonatomic, strong) UILabel *labRemark2;
@property (nonatomic, strong) UILabel *labUserinfo;
@property (nonatomic, assign) NSInteger Idid;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, strong) UIView *viewLine;
@end
@implementation RLSUserViewOfTuijianCell
- (id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (void)setValueWithUserTitle:(NSString *)title
                          Pic:(NSString *)pic
                    ArrTitles:(NSArray *)titls
                      Remark:(NSArray *)remark
                          Win:(NSString *)win
                      Profite:(NSString *)profite
                        Round:(NSString *)round
                         Fans:(NSString *)fans
                       Userid:(NSInteger)Idid
                    colorType:(NSInteger)type
                     cellType:(typeTuijianCell)celltype
                    readCount:(NSString *)readCount
                     dayRange:(NSString *)dayRange
                    WithModel:(RLSTuijiandatingModel *)model
{
    if (!_addedAutoLayout) {
        _addedAutoLayout = YES;
        [self addAutoLayout];
    }
    _Idid = Idid;
    _nickName = title;
    _pic = pic;
    [_btnAuthor setText:title];
    _btnAuthor.tag = Idid;
    _btnAuthorPic.tag = Idid;
    [_btnAuthorPic sd_setBackgroundImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    [_btnAuthorPic sd_setBackgroundImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    if ( type== 2) {
        _labUserinfo.text = model.userinfo;
    }else{
        _labUserinfo.text = @"";
    }
    _labFanNum.text = fans;
    _labWinNum.text = win;
    _labProfitNum.text = profite;
    _labRecommendNum.text = round;
    [_imageRecommendTitle setBackgroundImage:[UIImage imageNamed:@"tuijianCount"] forState:UIControlStateNormal];
    [_imageWinTitle setBackgroundImage:[UIImage imageNamed:@"tuijianWin"] forState:UIControlStateNormal];
    [_imageProfitTitle setBackgroundImage:[UIImage imageNamed:@"tuijianProfit"] forState:UIControlStateNormal];
    [_imageFanTitle setBackgroundImage:[UIImage imageNamed:@"tuijianFans"] forState:UIControlStateNormal];
    [_imageAuthorTitle setImage:[UIImage imageNamed:@"clear"]];
    [_imageAuthorTitle1 setImage:[UIImage imageNamed:@"clear"]];
    [_imageAuthorTitle2 setImage:[UIImage imageNamed:@"clear"]];
    if (titls.count == 0) {
        [_imageSpace setBackgroundColor:[UIColor clearColor]];
    }else{
        [_imageSpace setBackgroundColor:[UIColor clearColor]];
    }
    [titls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RLSMedalsModel *medals = (RLSMedalsModel*)obj;
        switch (idx) {
            case 0:
            {
                [_imageAuthorTitle sd_setImageWithURL:[NSURL URLWithString:medals.url]];
            }
                break;
            case 1:
            {
                [_imageAuthorTitle1 sd_setImageWithURL:[NSURL URLWithString:medals.url]];
            }
                break;
            case 2:
            {
                [_imageAuthorTitle2 sd_setImageWithURL:[NSURL URLWithString:medals.url]];
            }
                break;
            default:
                break;
        }
    }];
    _labRemark1.text = @"";
    _labRemark2.text = @"";
    if (remark.count == 0) {
        _labRemark1.text = @"";
        _labRemark2.text = @"";
    }else if (remark.count == 1){
        RLSUsermarkModel *usermark = [remark firstObject];
        if (usermark.type == 1) {
            _labRemark1.text =[NSString stringWithFormat:@"  %@  ",usermark.remark];
            self.labRemark1.backgroundColor = redcolor;
            self.labRemark1.textColor = [UIColor whiteColor];
            self.labRemark1.font = BoldFont4(fontSize11);
        }else if (usermark.type == 2){
            _labRemark1.text =[NSString stringWithFormat:@"  %@  ",usermark.remark];
            self.labRemark1.backgroundColor = colorFEE3E1;
            self.labRemark1.textColor = redcolor;
            self.labRemark1.font = font11;
        }
    }else{
        for (int i = 0; i<remark.count; i++) {
            RLSUsermarkModel *usermark = [remark objectAtIndex:i];
            if (usermark.type == 1) {
                _labRemark2.text =[NSString stringWithFormat:@"  %@  ",usermark.remark];
                self.labRemark2.backgroundColor = redcolor;
                self.labRemark2.textColor = [UIColor whiteColor];
                self.labRemark2.font = BoldFont4(fontSize11);
            }else if (usermark.type == 2){
                _labRemark1.text  = [NSString stringWithFormat:@"  %@  ",usermark.remark];
                self.labRemark1.backgroundColor = colorFEE3E1;
                self.labRemark1.textColor = redcolor;
            }
        }
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAuther)];
        [_basicView addGestureRecognizer:tap];
        [_basicView addSubview:self.btnAuthorPic];
        [_basicView addSubview:self.btnAuthor];
        [_basicView addSubview:self.imageSpace];
        [_basicView addSubview:self.imageAuthorTitle];
        [_basicView addSubview:self.imageAuthorTitle1];
        [_basicView addSubview:self.imageAuthorTitle2];
        [_basicView addSubview:self.labRemark1];
        [_basicView addSubview:self.labRemark2];
        [_basicView addSubview:self.imageWinTitle];
        [_basicView addSubview:self.labWinNum];
        [_basicView addSubview:self.imageProfitTitle];
        [_basicView addSubview:self.labProfitNum];
        [_basicView addSubview:self.imageFanTitle];
        [_basicView addSubview:self.labFanNum];
        [_basicView addSubview:self.labRecommendNum];
        [_basicView addSubview:self.imageRecommendTitle];
        [_basicView addSubview:self.labUserinfo];
        [_basicView addSubview:self.labNewWinTitle];
        [_basicView addSubview:self.labNewWinNum];
        [_basicView addSubview:self.viewLine];
    }
    return _basicView;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorCellLine;
    }
    return _viewLine;
}
- (UIButton *)btnAuthorPic
{
    if (!_btnAuthorPic) {
        _btnAuthorPic = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnAuthorPic.layer.cornerRadius = 40/2;
        _btnAuthorPic.layer.masksToBounds = YES;
        _btnAuthorPic.clipsToBounds = YES;
        _btnAuthorPic.userInteractionEnabled = NO;
    }
    return _btnAuthorPic;
}
- (UILabel *)btnAuthor
{
    if (!_btnAuthor) {
        _btnAuthor = [[UILabel alloc] init];
        _btnAuthor.font = BoldFont4(fontSize15);
        [_btnAuthor setTextColor:color33];
    }
    return _btnAuthor;
}
- (UILabel *)labUserinfo
{
    if (!_labUserinfo) {
        _labUserinfo = [[UILabel alloc] init];
        _labUserinfo.textColor = color33;
        _labUserinfo.font = font12;
        _labUserinfo.numberOfLines = 1;
    }
    return _labUserinfo;
}
- (UIImageView *)imageSpace
{
    if (!_imageSpace) {
        _imageSpace = [[UIImageView alloc] init];
        _imageSpace.backgroundColor = grayColor2;
    }
    return _imageSpace;
}
- (UIImageView *)imageAuthorTitle
{
    if (!_imageAuthorTitle) {
        _imageAuthorTitle = [[UIImageView alloc] init];
    }
    return _imageAuthorTitle;
}
- (UIImageView *)imageAuthorTitle1
{
    if (!_imageAuthorTitle1) {
        _imageAuthorTitle1 = [[UIImageView alloc] init];
    }
    return _imageAuthorTitle1;
}
- (UIImageView *)imageAuthorTitle2
{
    if (!_imageAuthorTitle2) {
        _imageAuthorTitle2 = [[UIImageView alloc] init];
    }
    return _imageAuthorTitle2;
}
- (UIButton *)imageFanTitle
{
    if (!_imageFanTitle) {
        _imageFanTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageFanTitle.userInteractionEnabled = NO;
    }
    return _imageFanTitle;
}
- (UIButton *)imageWinTitle
{
    if (!_imageWinTitle) {
        _imageWinTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageWinTitle.userInteractionEnabled = NO;
    }
    return _imageWinTitle;
}
- (UIButton *)imageProfitTitle
{
    if (!_imageProfitTitle) {
        _imageProfitTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageProfitTitle.userInteractionEnabled = NO;
    }
    return _imageProfitTitle;
}
- (UIButton *)imageRecommendTitle
{
    if (!_imageRecommendTitle) {
        _imageRecommendTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageRecommendTitle.userInteractionEnabled = NO;
    }
    return _imageRecommendTitle;
}
- (UILabel *)labFanNum
{
    if (!_labFanNum) {
        _labFanNum = [[UILabel alloc] init];
        _labFanNum.font = font11;
        _labFanNum.textColor = color66;
    }
    return _labFanNum;
}
- (UILabel *)labProfitNum
{
    if (!_labProfitNum) {
        _labProfitNum = [[UILabel alloc] init];
        _labProfitNum.font = font11;
        _labProfitNum.textColor = color66;
    }
    return _labProfitNum;
}
- (UILabel *)labWinNum
{
    if (!_labWinNum) {
        _labWinNum = [[UILabel alloc] init];
        _labWinNum.font = font11;
        _labWinNum.textColor = color66;
    }
    return _labWinNum;
}
- (UILabel *)labRecommendNum
{
    if (!_labRecommendNum) {
        _labRecommendNum = [[UILabel alloc] init];
        _labRecommendNum.font = font11;
        _labRecommendNum.textColor = color66;
    }
    return _labRecommendNum;
}
- (UILabel *)labRemark1
{
    if (!_labRemark1) {
        _labRemark1 = [[UILabel alloc] init];
        _labRemark1.font = font11;
        _labRemark1.textColor = color52;
        _labRemark1.layer.cornerRadius =3;
        _labRemark1.layer.masksToBounds = YES;
    }
    return _labRemark1;
}
- (UILabel *)labRemark2
{
    if (!_labRemark2) {
        _labRemark2 = [[UILabel alloc] init];
        _labRemark2.font = font11;
        _labRemark2.textColor = [UIColor whiteColor];
        _labRemark2.backgroundColor= redcolor;
        _labRemark2.layer.cornerRadius =3;
        _labRemark2.layer.masksToBounds = YES;
    }
    return _labRemark2;
}
- (UILabel *)labNewWinNum
{
    if (!_labNewWinNum) {
        _labNewWinNum = [[UILabel alloc] init];
        _labNewWinNum.font = font24;
    }
    return _labNewWinNum;
}
- (UILabel *)labNewWinTitle
{
    if (!_labNewWinTitle) {
        _labNewWinTitle = [[UILabel alloc] init];
        _labNewWinTitle.font = font10;
    }
    return _labNewWinTitle;
}
- (void)addAutoLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.btnAuthorPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(9);
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    [self.btnAuthor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthorPic.mas_right).offset(9);
        make.top.equalTo(self.basicView.mas_top).offset(9);
    }];
    [self.imageSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthor.mas_right).offset(12);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(1);
    }];
    [self.imageAuthorTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageSpace.mas_right).offset(12);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
    [self.imageAuthorTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageAuthorTitle.mas_right).offset(10);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
    [self.imageAuthorTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageAuthorTitle1.mas_right).offset(10);
        make.centerY.equalTo(_btnAuthor.mas_centerY);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(0);
    }];
    [self.labRemark1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-26);
        make.top.equalTo(self.basicView.mas_top).offset(10);
        make.height.mas_equalTo(14);
    }];
    [self.labRemark2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labRemark1.mas_left).offset(-8);
        make.top.equalTo(self.labRemark1.mas_top).offset(0);
        make.height.mas_equalTo(14);
    }];
    [self.imageRecommendTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthorPic.mas_right).offset(9);
        make.top.equalTo(self.btnAuthor.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [self.labRecommendNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageRecommendTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    [self.imageWinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labRecommendNum.mas_right).offset(11);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [self.labWinNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageWinTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    [self.imageProfitTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labWinNum.mas_right).offset(11);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [self.labProfitNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageProfitTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    [self.imageFanTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labProfitNum.mas_right).offset(11);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    [self.labFanNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageFanTitle.mas_right).offset(4);
        make.centerY.equalTo(self.imageRecommendTitle.mas_centerY);
    }];
    [self.labNewWinTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-5.5);
        make.centerX.equalTo(self.labNewWinNum.mas_centerX).offset(0);
    }];
    [self.labNewWinNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.labNewWinTitle.mas_top).offset(-2.5);
        make.right.equalTo(self.basicView.mas_right).offset(-31);
    }];
    [self.labUserinfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-10);
        make.width.mas_equalTo(Width - 30);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.left.equalTo(self.basicView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];
}
- (void)toAuther
{
    if (_Idid == 1) {
        return;
    }
     RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
    userVC.userId = _Idid;
    userVC.userName = _nickName;
    userVC.userPic = _pic;
    userVC.Number=1;
    userVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
}
@end

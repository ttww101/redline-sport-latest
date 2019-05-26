#import "RLSTuijianDatingCell.h"
#import "RLSTuijianDetailVC.h"
#import "RLSTeamViewofTuijianCell.h"
#import "RLSBuyViewofTuijianView.h"
#import "RLSPeilvViewOfTuijianCell.h"
#import "RLSUserViewofMyBuyTuijian.h"
@interface RLSTuijianDatingCell()
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) RLSUserViewOfTuijianCellCopy *headerUser;
@property (nonatomic, strong) RLSUserViewofMyBuyTuijian *UserofMyBuy;
@property (nonatomic, strong) RLSTeamViewofTuijianCell *teamView;
@property (nonatomic, strong) RLSBuyViewofTuijianView *buymView;
@property (nonatomic, strong) RLSPeilvViewOfTuijianCell *peilvView;
@property (nonatomic, strong) UILabel *labContent;
@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UILabel *labCreatTime;
@property (nonatomic, strong) UIButton *btnZan;
@property (nonatomic, strong) UILabel *labZanNum;
@property (nonatomic, strong) UIImageView *btnNoZan;
@property (nonatomic, strong) UILabel *labNoZanNum;
@property (nonatomic, strong) UIButton *btnComment;
@property (nonatomic, strong) UILabel *labConmmentNum;
@property (nonatomic, strong) UIImageView *imageViewWin;
@property (nonatomic, strong) UILabel *labStatus;
@property (nonatomic, strong) UILabel *labMoney;
@property (nonatomic , strong) UILabel *goldLabel;
@property (nonatomic , strong) UILabel *buyNumLabel;
@property (nonatomic , strong) UIImageView *buyImageView;
@property (nonatomic, strong) BaseImageView *lockIV;

@property (nonatomic, strong) UIView *lockView;


@end
@implementation RLSTuijianDatingCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
- (void)setModel:(RLSTuijiandatingModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_didSetupConstraints) {
        _didSetupConstraints = YES;
        [self addAutoLayoutToCell];
    }
    [_headerUser setValueWithUserTitle:_model.nickname Pic:_model.pic ArrTitles:_model.medals Remark:_model.arrUsermark  Win:_model.win_rate Profite:_model.profit_rate Round:[NSString stringWithFormat:@"%ld",_model.recommend_count] Fans:[NSString stringWithFormat:@"%ld",_model.follower_count] Userid:_model.user_id colorType:1 cellType:_type readCount:[NSString stringWithFormat:@"%ld",_model.readCount] dayRange:_model.dayRange WithModel:_model];
    _teamView.model = _model;
    _buymView.model = _model;
    _peilvView.model = _model;
    _UserofMyBuy.model = _model;
    if (_type == typeTuijianCellMybuy) {
        _labContent.text = @"";
        _labCreatTime.text = @"";
        [_btnComment setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _labConmmentNum.text = @"";
        _labNoZanNum.text = @"";
        [_btnZan setBackgroundImage:[UIImage imageNamed:@""]forState:UIControlStateNormal];
        _labZanNum.text = @"";
        if (!_model.see) {
            NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"currency"];
            if (!(str.length > 0)) {
                str = @"钻石";
            }
            _labMoney.text = [NSString stringWithFormat:@" ¥ %ld ",_model.amount==3800?30:_model.amount/100];
              self.lockView.hidden = false;
            if (_model.amount == 12800) {
                self.lockView.hidden = true;
            }
        } else {
            _labMoney.text = nil;
             self.lockView.hidden = true;
        }
    }else{
        [_btnComment setBackgroundImage:[UIImage imageNamed:@"date"] forState:UIControlStateNormal];
        _labConmmentNum.text = [RLSMethods compareCurrentTime:_model.recommendTime];
        _labNoZanNum.text = [NSString stringWithFormat:@"%ld",(long)_model.readCount];
        [_btnZan setBackgroundImage:[UIImage imageNamed:@"clear"]forState:UIControlStateNormal];
        _labZanNum.text = @"";
        if (!_model.see) {
            NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"currency"];
            if (!(str.length > 0)) {
                str = @"钻石";
            }
            _goldLabel.text = [NSString stringWithFormat:@"¥ %ld ", _model.amount==3800?30:_model.amount/100];
            _goldLabel.hidden = false;
            self.lockView.hidden = false;
        } else{
            _goldLabel.hidden = YES;
            self.lockView.hidden = true;
        }
    }
    _labStatus.text = @"";
    if (_type == typeTuijianCellUser || _type == typeTuijianCellDating) {
        if (_model.amount > 0) {
            _buyNumLabel.text = [NSString stringWithFormat:@"%@人购买",_model.buyCount];
            _buyNumLabel.hidden = false;
            _buyImageView.hidden = false;
        } else {
            _buyNumLabel.hidden = YES;
            _buyImageView.hidden = YES;
        }
    }else{
        _labStatus.text = @"";
        _labStatus.textColor = [UIColor whiteColor];
    }
    if (_model.result.length > 0) {
        switch ([_model.result integerValue]) {
            case 0:
            {
                _imageViewWin.image = [UIImage imageNamed:@"re_go"];
            }
                break;
            case 1:
            {
                _imageViewWin.image = [UIImage imageNamed:@"re_win_half"];
            }
                break;
            case 2:
            {
                _imageViewWin.image = [UIImage imageNamed:@"re_win"];
            }
                break;
            case -1:
            {
                _imageViewWin.image = [UIImage imageNamed:@"re_lose_half"];
            }
                break;
            case -2:
            {
                _imageViewWin.image = [UIImage imageNamed:@"re_lose"];
            }
                break;
            case -3:
            {
                _imageViewWin.image = [UIImage imageNamed:@"re_Invalid"];
            }
                break;
            case 10:
            {
                _imageViewWin.image = [UIImage imageNamed:@"re_Invalid"];
            }
                break;
            case -10:
            {
                _imageViewWin.image = [UIImage imageNamed:@""];
            }
                break;
            default:
                break;
        }
    }else{
        _imageViewWin.image = [UIImage imageNamed:@"clear"];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toTuijianDetail)];
        _basicView.opaque = YES;
        [_basicView addGestureRecognizer:tap];
        switch (_type) {
            case typeTuijianCellDating:
            {
                [_basicView addSubview:self.headerUser];
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.peilvView];
                [_basicView addSubview:self.buyNumLabel];
                [_basicView addSubview:self.buyImageView];
                
                [_basicView addSubview:self.lockView];
                [self.lockView addSubview:self.goldLabel];
                [self.lockView addSubview:self.lockIV];
            }
                break;
            case typeTuijianCellFenxi:
            {
                [_basicView addSubview:self.headerUser];
                [_basicView addSubview:self.peilvView];
            }
                break;
            case typeTuijianCellUser:
            {
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.peilvView];
                [_basicView addSubview:self.buyNumLabel];
                [_basicView addSubview:self.buyImageView];
                
                [_basicView addSubview:self.lockView];
                [self.lockView addSubview:self.goldLabel];
                [self.lockView addSubview:self.lockIV];
                
            }
                break;
            case typeTuijianCellFirstPage:
            {
                [_basicView addSubview:self.headerUser];
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.peilvView];
            }
                break;
            case typeTuijianCellMybuy:
            {
                [_basicView addSubview:self.UserofMyBuy];
                [_basicView addSubview:self.teamView];
                [_basicView addSubview:self.buymView];
                [_basicView addSubview:self.peilvView];
                [_basicView addSubview:self.labMoney];
            }
                break;
            default:
                break;
        }
        [_basicView addSubview:self.labStatus];
        [_basicView addSubview:self.imageViewWin];
        [_basicView addSubview:self.viewContent];
        [_basicView addSubview:self.labContent];
        [_basicView addSubview:self.labCreatTime];
        [_basicView addSubview:self.labConmmentNum];
        [_basicView addSubview:self.btnComment];
        [_basicView addSubview:self.labNoZanNum];
        [_basicView addSubview:self.btnNoZan];
        [_basicView addSubview:self.labZanNum];
        [_basicView addSubview:self.btnZan];
    }
    return _basicView;
}
- (RLSUserViewOfTuijianCellCopy *)headerUser
{
    if (!_headerUser) {
        _headerUser = [[RLSUserViewOfTuijianCellCopy alloc] init];
    }
    return _headerUser;
}
- (RLSUserViewofMyBuyTuijian *)UserofMyBuy
{
    if (!_UserofMyBuy) {
        _UserofMyBuy = [[RLSUserViewofMyBuyTuijian alloc] init];
    }
    return _UserofMyBuy;
}
- (RLSTeamViewofTuijianCell *)teamView
{
    if (!_teamView) {
        _teamView = [[RLSTeamViewofTuijianCell alloc] init];
    }
    return _teamView;
}
- (RLSBuyViewofTuijianView *)buymView
{
    if (!_buymView) {
        _buymView = [[RLSBuyViewofTuijianView alloc] init];
    }
    return _buymView;
}
- (RLSPeilvViewOfTuijianCell *)peilvView
{
    if (!_peilvView) {
        _peilvView = [[RLSPeilvViewOfTuijianCell alloc] init];
    }
    return _peilvView;
}
- (UILabel *)labMoney
{
    if (!_labMoney) {
        _labMoney = [[UILabel alloc] init];
        _labMoney.font = font14;
        _labMoney.textColor = yellowcolor;
        _labMoney.layer.borderColor = yellowcolor.CGColor;
        _labMoney.layer.borderWidth = 0.6;
        _labMoney.layer.cornerRadius = 3;
        _labMoney.layer.masksToBounds = YES;
    }
    return _labMoney;
}
- (UILabel *)labStatus
{
    if (!_labStatus) {
        _labStatus = [[UILabel alloc] init];
        _labStatus.font = font9;
    }
    return _labStatus;
}
- (UILabel *)labCreatTime
{
    if (!_labCreatTime) {
        _labCreatTime = [[UILabel alloc] init];
        _labCreatTime.font = font10;
        _labCreatTime.textColor = color99;
    }
    return _labCreatTime;
}
- (UILabel *)labConmmentNum
{
    if (!_labConmmentNum) {
        _labConmmentNum = [[UILabel alloc] init];
        _labConmmentNum.font = font10;
        _labConmmentNum.textColor = color99;
    }
    return _labConmmentNum;
}
- (UIButton *)btnComment
{
    if (!_btnComment) {
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.titleLabel.font = font11;
        [_btnComment setTitleColor:color99 forState:UIControlStateNormal];
        _btnComment.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _btnComment;
}
- (UILabel *)labNoZanNum
{
    if (!_labNoZanNum) {
        _labNoZanNum = [[UILabel alloc] init];
        _labNoZanNum.font = font10;
        _labNoZanNum.textColor = color99;
    }
    return _labNoZanNum;
}
- (UIImageView *)btnNoZan
{
    if (!_btnNoZan) {
        _btnNoZan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"re_eye"]];
        _btnNoZan.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _btnNoZan;
}
- (UILabel *)labZanNum
{
    if (!_labZanNum) {
        _labZanNum = [[UILabel alloc] init];
        _labZanNum.font = font10;
        _labZanNum.textColor = color99;
    }
    return _labZanNum;
}
- (UIButton *)btnZan
{
    if (!_btnZan) {
        _btnZan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnZan.titleLabel.font = font11;
        [_btnZan setTitleColor:color99 forState:UIControlStateNormal];
        _btnZan.tag = 1;
    }
    return _btnZan;
}
- (UIImageView *)imageViewWin
{
    if (!_imageViewWin) {
        _imageViewWin = [[UIImageView alloc] init];
        _imageViewWin.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageViewWin;
}
- (UILabel *)goldLabel {
    if (_goldLabel == nil) {
        _goldLabel = [UILabel new];
        _goldLabel.text = @"50金币";
        _goldLabel.textColor = [UIColor whiteColor];
        _goldLabel.font = font12;
        _goldLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _goldLabel;
}

- (BaseImageView *)lockIV {
    if (_lockIV == nil) {
        _lockIV = [[BaseImageView alloc]init];
        _lockIV.image = [UIImage imageNamed:@"lock"];
    }
    return _lockIV;
}

- (UIView *)lockView {
    if (_lockView == nil) {
        _lockView = [[UIView alloc]init];
        _lockView.backgroundColor = UIColorFromRGBWithOX(0xFF8E00);
        _lockView.layer.cornerRadius = 12;
        _lockView.layer.masksToBounds = true;
    }
    return _lockView;
}


- (UILabel *)labContent
{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.font = font14;
        _labContent.textColor = color33;
        _labContent.numberOfLines = 1;
    }
    return _labContent;
}
- (UIView *)viewContent
{
    if (!_viewContent) {
        _viewContent = [[UIView alloc] init];
        _viewContent.backgroundColor = colorF5;
    }
    return _viewContent;
}
- (UILabel *)buyNumLabel
{
    if (!_buyNumLabel) {
        _buyNumLabel = [[UILabel alloc] init];
        _buyNumLabel.font = font12;
        _buyNumLabel.textColor = color99;
        _buyNumLabel.numberOfLines = 1;
    }
    return _buyNumLabel;
}
- (UIImageView *)buyImageView {
    if (_buyImageView == nil) {
        _buyImageView = [UIImageView new];
        _buyImageView.image = [UIImage imageNamed:@"buyshop"];
    }
    return _buyImageView;
}
- (void)addAutoLayoutToCell
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0);
    } ];
    switch (_type) {
        case typeTuijianCellDating:
        {
            [self.headerUser mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(58);
            }];
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-20);
                make.top.equalTo(self.headerUser.mas_bottom).offset(20);
                make.size.mas_equalTo(CGSizeMake(70, 30));
            }];
            
            [self.lockView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-20);
                make.top.equalTo(self.headerUser.mas_bottom).offset(20);
                make.size.mas_equalTo(CGSizeMake(54, 25));
            }];
            
            [self.goldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.lockView.mas_right).offset(-3);
                make.centerY.equalTo(self.lockView.mas_centerY);
            }];
            
            [self.lockIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lockView.mas_left).offset(5);
                make.centerY.equalTo(self.lockView.mas_centerY);
            }];
            
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.headerUser.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.contentView.mas_right).offset(200);
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];
            [self.buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_basicView.mas_right).offset(-15);
                make.bottom.equalTo(_basicView.mas_bottom).offset(-15);
            }];
            [self.buyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.buyNumLabel.mas_left).offset(-5);
                make.centerY.equalTo(self.buyNumLabel.mas_centerY);
            }];
        }
            break;
        case typeTuijianCellFirstPage:
        {
            [self.headerUser mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(58);
            }];
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-40);
                make.top.equalTo(self.headerUser.mas_bottom).offset(8);
            }];
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.headerUser.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];
        }
            break;
        case typeTuijianCellFenxi:
        {
            [self.headerUser mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(58);
            }];
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-40);
                make.top.equalTo(self.headerUser.mas_bottom).offset(-26);
            }];
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.headerUser.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];
        }
            break;
        case typeTuijianCellUser:
        {
            [self.lockView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-20);
                make.top.equalTo(self.basicView.mas_top).offset(20);
                make.size.mas_equalTo(CGSizeMake(70, 25));
            }];
            
            [self.goldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.lockView.mas_right).offset(-3);
                make.centerY.equalTo(self.lockView.mas_centerY);
            }];
            
            [self.lockIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lockView.mas_left).offset(5);
                make.centerY.equalTo(self.lockView.mas_centerY);
            }];
            
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-20);
                make.centerY.equalTo(self.basicView.mas_centerY);
            }];
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.basicView.mas_top).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(10);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(7.5);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-21.5);
                make.top.equalTo(self.labContent.mas_bottom).offset(8.5);
            }];
            [self.buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(_basicView.mas_right).offset(-15);
                make.bottom.equalTo(_basicView.mas_bottom).offset(-15);
            }];
            [self.buyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.buyNumLabel.mas_left).offset(-5);
                make.centerY.equalTo(self.buyNumLabel.mas_centerY);
            }];
        }
            break;
        case typeTuijianCellMybuy:
        {
            [self.UserofMyBuy mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.basicView.mas_top);
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.height.mas_equalTo(30);
            }];
            [self.imageViewWin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.labMoney.mas_left).offset(-5);
                make.top.equalTo(self.UserofMyBuy.mas_bottom).offset(8);
            }];
            [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.UserofMyBuy.mas_bottom).offset(5);
                make.size.mas_equalTo(CGSizeMake(Width, 45));
            }];
            [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.right.equalTo(self.basicView.mas_right);
                make.top.equalTo(self.teamView.mas_bottom).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 18));
            }];
            [self.labMoney mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.basicView.mas_right).offset(-35);
                make.bottom.equalTo(self.peilvView.mas_top);
                make.height.mas_equalTo(18);
            }];
            [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.top.equalTo(self.peilvView.mas_bottom).offset(0);
                make.right.equalTo(self.basicView.mas_right).offset(-15);
            }];
            [self.viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left);
                make.bottom.equalTo(self.basicView.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(Width, 10));
            }];
            [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.basicView.mas_left).offset(15);
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-20 - 25);
                make.top.equalTo(self.labContent.mas_bottom).offset(0);
            }];
            [self.buymView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.basicView.mas_bottom).offset(-10);
                make.left.equalTo(self.basicView.mas_left).offset(0);
                make.size.mas_equalTo(CGSizeMake(Width, 30));
            }];
        }
            break;
        default:
            break;
    }
    [self.labStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-11);
        make.top.equalTo(self.imageViewWin.mas_top).offset(10);
    }];
    [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.labConmmentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnComment.mas_right).offset(5);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    [self.btnNoZan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labConmmentNum.mas_right).offset(5);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    [self.labNoZanNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnNoZan.mas_right).offset(5);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    [self.labZanNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btnNoZan.mas_left).offset(-9.5);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
    [self.btnZan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labZanNum.mas_left).offset(-4);
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
    }];
}
- (void)toTuijianDetail
{
    if (_type == typeTuijianCellMybuy) {
        if (_model.otype == 1) {
            RLSTuijianDetailVC *infoVC = [[RLSTuijianDetailVC alloc] init];
            infoVC.hidesBottomBarWhenPushed = YES;
            infoVC.status = _model.status;
            infoVC.modelId = _model.idId;
            [[RLSMethods help_getCurrentVC].navigationController pushViewController:infoVC animated:true];
        }
    }else{
        
        RLSTuijianDetailVC *infoVC = [[RLSTuijianDetailVC alloc] init];
        infoVC.hidesBottomBarWhenPushed = YES;
        infoVC.status = 2;
        infoVC.modelId = _model.idId;
         [[RLSMethods help_getCurrentVC].navigationController pushViewController:infoVC animated:true];
        
    }
}
- (void)addLikedHated:(UIButton *)btn
{
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    if (btn.tag == 1) {
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }else if (btn.tag == 2){
        if (_model.liked == YES) {
            return;
        }
        if (_model.hated == YES) {
            return;
        }
    }
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [paremeter setObject:@"1" forKey:@"type"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_model.idId] forKey:@"targetId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)btn.tag] forKey:@"lclass"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_likeAdd] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                if (btn.tag == 1) {
                    _btnZan.selected = YES;
                    _model.like_count = _model.like_count + 1;
                    _model.liked = YES;
                    _labZanNum.text = [NSString stringWithFormat:@"%ld",(long)_model.like_count];
                }else{
                    _model.hate_count = _model.hate_count+1;
                    _model.hated = YES;
                    _labNoZanNum.text = [NSString stringWithFormat:@"%ld",(long)_model.hate_count];
                }
            }else{
            }
        }else
        {
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end

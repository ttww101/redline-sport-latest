#import "RLSHeaderAmountView.h"
#import "RLSToolWebViewController.h"
#import "RLSItemControl.h"
@interface RLSHeaderAmountView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UILabel *amauntLabel;
@property (nonatomic , strong) UIButton *buyBtn;
@property (nonatomic, strong) UIButton *myIncomeBtn;
@property (nonatomic, strong) UIImageView *rightArrorImageView;
@property (nonatomic, strong) UIControl *control;
@property (nonatomic , strong) UIButton *rechargeBtn;
@property (nonatomic , strong) UIButton *goldRechargeBtn;


@end
@implementation RLSHeaderAmountView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
- (void)setModel:(RLSUserModel *)model {
    _model = model;
    NSArray *itemArray = @[
                           @{
                               @"icon":@"goldblue",
                               @"title":@"钻石余额"
                               },
                           @{
                               @"icon":@"gold",
                               @"title":@"滚球币金额"
                               }
                           ];
    [self removeAllSubViews];

    NSString *str = @"";
    CGFloat itemWidth = self.width / itemArray.count;
    for (NSInteger i = 0; i < itemArray.count; i ++) {
        NSDictionary *dic = itemArray[i];
        if (i == 0) {
            if (_model.diamondDesc) {
                str = _model.diamondDesc;
            } else {
                str = @"0";
            }
            
        } else if (i == 1) {
            NSString *amount = [_model.coin stringValue];
            if (!amount) {
                amount = @"0";
            }
            str = amount;
        }
        RLSItemControl *control  = [[RLSItemControl alloc]initWithFrame:CGRectMake(i * itemWidth, 0, itemWidth, self.height) imageName:dic[@"icon"] title:dic[@"title"] amount:str hidenLine:i];
        control.tag = i;
        [control addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
    }
    [self addSubview:self.rechargeBtn];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(itemWidth  - 55);
        make.size.mas_equalTo(CGSizeMake(42, 21));
    }];
    
    [self addSubview:self.goldRechargeBtn];
    [self.goldRechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(42, 21));
    }];
    
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.shadowColor = UIColorHex(CDCDCD).CGColor;
    self.layer.shadowOpacity = 1;
    self.layer.shadowOffset = CGSizeMake(1, 1);
}
#pragma mark - Events
- (void)controlAction:(RLSItemControl *)senter {
    switch (senter.tag) {
        case 0: {
            [self myDiamond];
        }
            break;
        case 1:{
             [self myGold];
        }
            break;
        case 2: {
        }
            break;
        case 3: {
            [self myCoupon];
        }
            break;
        default:
            break;
    }
}
- (void)myIncomeAction {
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"我的收入";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-earnings.html", APPDELEGATE.url_ip,H5_Host];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)myGift {
    [MobClick event:@"hongbao" label:@""];
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"我的红包";
    model.hideNavigationBar = YES;
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-redbag.html", APPDELEGATE.url_ip,H5_Host];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)myGold {
    [MobClick event:@"gqb" label:@""];
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"我的滚球币";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-gold.html", APPDELEGATE.url_ip,H5_Host];
    model.hideNavigationBar = YES;
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}
- (void)myCoupon {
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"我的优惠券";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/pay-card.html", APPDELEGATE.url_ip,H5_Host];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)myDiamond {
    [MobClick event:@"gqb" label:@""];
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"我的钻石";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/my-diamond.html", APPDELEGATE.url_ip,H5_Host];
    model.hideNavigationBar = YES;
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)rechargeAction {
    [MobClick event:@"zuanshichonghzhi" label:@""];
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"充值";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/buy-diamond.html", APPDELEGATE.url_ip,H5_Host];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)goldRechargeAction {
    [MobClick event:@"chongzhi" label:@""];
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"充值";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/buy-gold.html", APPDELEGATE.url_ip,H5_Host];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

#pragma mark - Lazy Load
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _lineView;
}
- (UIView *)verticalView {
    if (_verticalView == nil) {
        _verticalView = [UIView new];
        _verticalView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _verticalView;
}
- (UILabel *)amauntLabel {
    if (_amauntLabel == nil) {
        _amauntLabel = [UILabel new];
    }
    return _amauntLabel;
}
- (UIControl *)control {
    if (_control == nil) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(myGold) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}
- (UIButton *)buyBtn {
    if (_buyBtn == nil) {
        _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyBtn setBackgroundImage:[UIImage imageNamed:@"buybtn"] forState:UIControlStateNormal];
    }
    return _buyBtn;
}
- (UIButton *)myIncomeBtn {
    if (_myIncomeBtn == nil) {
        _myIncomeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_myIncomeBtn setTitle:@"我的收入" forState:UIControlStateNormal];
        [_myIncomeBtn setTitleColor:UIColorFromRGBWithOX(0x333333) forState:UIControlStateNormal];
        _myIncomeBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        _myIncomeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_myIncomeBtn addTarget:self action:@selector(myIncomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myIncomeBtn;
}

- (UIButton *)rechargeBtn {
    if (_rechargeBtn == nil) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeBtn setBackgroundImage:[UIImage imageNamed:@"goldrecharge"] forState:UIControlStateNormal];
        [_rechargeBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
        _rechargeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rechargeBtn;
}

- (UIButton *)goldRechargeBtn {
    if (_goldRechargeBtn == nil) {
        _goldRechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goldRechargeBtn setBackgroundImage:[UIImage imageNamed:@"recharge"] forState:UIControlStateNormal];
        [_goldRechargeBtn addTarget:self action:@selector(goldRechargeAction) forControlEvents:UIControlEventTouchUpInside];
        _goldRechargeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _goldRechargeBtn;
}

- (UIImageView *)rightArrorImageView {
    if (_rightArrorImageView == nil) {
        _rightArrorImageView = [UIImageView new];
        _rightArrorImageView.contentMode = UIViewContentModeScaleAspectFill;
        _rightArrorImageView.image = [UIImage imageNamed:@"meRight"];
    }
    return _rightArrorImageView;
}


@end

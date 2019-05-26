#import "RLSWithdrawalView.h"
#import "RLSWebModel.h"
#import "RLSToolWebViewController.h"
@interface RLSWithdrawalView ()
@property (nonatomic , strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic , strong) UIButton *withdrawalBtn;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *ruleLabel;
@end
@implementation RLSWithdrawalView
- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, Width, 190)];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
- (void)setcontentWithData:(WithdrawaListModel *)model {
    NSString *text = [NSString stringWithFormat:@"%@元",PARAM_IS_NIL_ERROR([RLSMethods amountFormater:model.total_reward_amount])];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:text];
    [att addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBWithOX(0xDB2D21) range:NSMakeRange(0, text.length)];
    [att addAttribute:NSFontAttributeName value:FONT_DIN_Bold_SIZE(60.f) range:[text rangeOfString:PARAM_IS_NIL_ERROR([RLSMethods amountFormater:model.total_reward_amount])]];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.f] range:[text rangeOfString:@"元"]];
    _amountLabel.attributedText = att;
    if (model.is_allow) {
        self.withdrawalBtn.hidden = false;
        self.ruleLabel.hidden = YES;
        self.desLabel.hidden = YES;
    } else {
        self.withdrawalBtn.hidden = YES;
        self.ruleLabel.hidden = false;
        self.desLabel.hidden = false;
        self.ruleLabel.text = model.note;
        self.desLabel.text = [NSString stringWithFormat:@"共通关%@场，获得%@元",model.total_winner_count, model.total_reward_amount];
    }
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    [self.bgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.top.equalTo(self.bgView.mas_top).offset(15);
    }];
    [self.bgView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.bgView.mas_centerX);
    }];
    [self.bgView addSubview:self.withdrawalBtn];
    [self.withdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bgView.mas_centerX);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(112, 54));
    }];
    [self.bgView addSubview:self.ruleLabel];
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-40);
        make.centerX.equalTo(self.bgView.mas_centerX);
    }];
    [self.bgView addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.bgView.mas_centerX);
        make.top.equalTo(self.ruleLabel.mas_bottom).offset(5);
    }];
}
#pragma mark - Events
- (void)withdrawalAction:(UIButton *)sender {
    RLSWebModel *webModel = [[RLSWebModel alloc]init];
    webModel.title = @"提现";
    webModel.webUrl =  @"http://www.gunqiu.com/help/tikuan.html";
    webModel.hideNavigationBar = false;
    RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
    control.model = webModel;
    [APPDELEGATE.customTabbar pushToViewController:control animated:YES];
}
#pragma mark - Lazy Load
- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"当前金额";
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = UIColorFromRGBWithOX(0x333333);
    }
    return _titleLabel;
}
- (UILabel *)amountLabel {
    if (_amountLabel == nil) {
        _amountLabel = [UILabel new];
    }
    return _amountLabel;
}
- (UILabel *)desLabel {
    if (_desLabel == nil) {
        _desLabel = [UILabel new];
        _desLabel.text = @"";
        _desLabel.font = [UIFont systemFontOfSize:16.f];
        _desLabel.textColor = UIColorFromRGBWithOX(0x666666);
        _desLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _desLabel;
}
- (UILabel *)ruleLabel {
    if (_ruleLabel == nil) {
        _ruleLabel = [UILabel new];
        _ruleLabel.text = @"";
        _ruleLabel.font = [UIFont systemFontOfSize:14.f];
        _ruleLabel.textColor = UIColorFromRGBWithOX(0x666666);
        _ruleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _ruleLabel;
}
- (UIButton *)withdrawalBtn {
    if (_withdrawalBtn == nil) {
        _withdrawalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_withdrawalBtn setImage:[UIImage imageNamed:@"withdrawal"] forState:UIControlStateNormal];
        [_withdrawalBtn addTarget:self action:@selector(withdrawalAction:) forControlEvents:UIControlEventTouchUpInside];
        _withdrawalBtn.hidden = YES;
    }
    return _withdrawalBtn;
}
@end

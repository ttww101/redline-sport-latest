#import "RLSPeilvViewOfTuijianCell.h"
@interface RLSPeilvViewOfTuijianCell()
@property (nonatomic, assign) BOOL isAddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labPankou;
@property (nonatomic, strong) UILabel *labchoice;
@property (nonatomic, strong) UILabel *labPeilv;
@property (nonatomic, strong) UILabel *labZhuma;
@property (nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic, strong) UILabel *palyType;;


@end
@implementation RLSPeilvViewOfTuijianCell

#pragma mark - Lazy Load

- (UILabel *)palyType {
    if (!_palyType) {
        _palyType = [[UILabel alloc] init];
        _palyType.textColor = UIColorHex(#787878);
        _palyType.font = font12;
    }
    return _palyType;
}

#pragma mark - ************  以下高人所写  ************

- (id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (void)setModel:(RLSTuijiandatingModel *)model
{
    _model = model;
    if (!_isAddlayout) {
        _isAddlayout = YES;
        [self addLayout];
    }
    _labPankou.text = @"";
    _labchoice.text = @"";
    _labPeilv.text = @"";
    _labZhuma.text = @"";
    _labPankou.text = @"推荐玩法:";
    if (model.playtype == 1) {
        _stateImageView.image = [UIImage imageNamed:@"ic_type_spf"];
        self.palyType.text = @"胜平负";
    } else if (model.playType == 2) {
        _stateImageView.image = [UIImage imageNamed:@"ic_type_rq"];
         self.palyType.text = @"让球";
    } else if (model.playType == 3) {
        _stateImageView.image = [UIImage imageNamed:@"ic_type_dxq"];
        self.palyType.text = @"进球数";
    }
    
    return;
    if (_model.see) {
        if (_model.spf.count>0) {
            _labPankou.text = @"胜平负:";
            NSArray* arr = _model.spf;
            switch (_model.choice) {
                case 3:
                {
                    [_labchoice setText:@"胜" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                }
                    break;
                case 1:
                {
                    [_labchoice setText:@"平局" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                }
                    break;
                case 0:
                {
                    [_labchoice setText:@"负" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                }
                    break;
                default:
                    break;
            }
            _labPeilv.attributedText = [RLSMethods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
        }else if (_model.ya.count>0){
            _labPankou.text = @"让球:";
            NSArray* arr = _model.ya;
            [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
            [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
            switch (_model.choice) {
                case 3:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"主%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                }
                    break;
                case 1:
                {
                    [_labchoice setText:@"主队" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                }
                    break;
                case 0:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"客%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                }
                    break;
                default:
                    break;
            }
            _labPeilv.attributedText = [RLSMethods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
        }else if (_model.dx.count>0){
            _labPankou.text = @"进球数:";
            NSArray* arr = _model.dx;
            switch (_model.choice) {
                case 3:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"大%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:0]] ];
                }
                    break;
                case 1:
                {
                    [_labchoice setText:@"进球数" ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:1]] ];
                }
                    break;
                case 0:
                {
                    [_labchoice setText:[NSString stringWithFormat:@"小%@",[arr objectAtIndex:1]] ];
                    [_labPeilv setText:[NSString stringWithFormat:@"@%@",[arr objectAtIndex:2]] ];
                }
                    break;
                default:
                    break;
            }
            _labPeilv.attributedText = [RLSMethods withContent:_labPeilv.text WithColorText:@"@" textColor:color33 strFont:font14];
        }
        if (_model.multiple == 0 || _model.multiple == 1) {
            _labZhuma.text = @"均注";
        }else{
            _labZhuma.text = [NSString stringWithFormat:@"%ld倍",(long)_model.multiple];
        }
    }else{
        _labPankou.text = @"付费查看";
        NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"currency"];
        if (!(str.length > 0)) {
            str = @"钻石";
        }
        _labchoice.text = [NSString stringWithFormat:@" ¥ %ld",_model.amount==3800?30:_model.amount/100];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labPankou];
        [_basicView addSubview:self.labchoice];
        [_basicView addSubview:self.labPeilv];
        [_basicView addSubview:self.labZhuma];
        [_basicView addSubview:self.stateImageView];
        [_basicView addSubview:self.palyType];
    }
    return _basicView;
}
- (UILabel *)labPankou
{
    if (!_labPankou) {
        _labPankou = [[UILabel alloc] init];
        _labPankou.textColor = UIColorHex(#666666);
        _labPankou.font = font12;
    }
    return _labPankou;
}
- (UILabel *)labchoice
{
    if (!_labchoice) {
        _labchoice = [[UILabel alloc] init];
        _labchoice.textColor = redcolor;
        _labchoice.font = font14;
    }
    return _labchoice;
}
- (UILabel *)labPeilv
{
    if (!_labPeilv) {
        _labPeilv = [[UILabel alloc] init];
        _labPeilv.textColor = redcolor;
        _labPeilv.font = font14;
    }
    return _labPeilv;
}
- (UILabel *)labZhuma
{
    if (!_labZhuma) {
        _labZhuma = [[UILabel alloc] init];
        _labZhuma.textColor = redcolor;
        _labZhuma.font = font14;
    }
    return _labZhuma;
}
- (UIImageView *)stateImageView {
    if (_stateImageView == nil) {
        _stateImageView = [UIImageView new];
        _stateImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _stateImageView;
}
- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.labPankou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    
    [self.palyType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labPankou.mas_right).offset(3);
        make.centerY.equalTo(self.labPankou.mas_centerY);
    }];
    
//    [self.stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.labPankou.mas_right).offset(5);
//        make.centerY.equalTo(self.labPankou.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(50, 20));
//    }];
    [self.labchoice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labPankou.mas_right).offset(10);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labPeilv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labchoice.mas_right).offset(0);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labZhuma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labPeilv.mas_right).offset(12);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
}
@end

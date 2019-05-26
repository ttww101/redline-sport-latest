#import "RLSDoubleBattlecell.h"
@interface RLSDoubleBattlecell()
@property (nonatomic, strong) UIView            *basicView;
@property (nonatomic, strong) UILabel           *btnRed;
@property (nonatomic, strong) UILabel           *labRed;
@property (nonatomic, strong) UILabel           *labBlue;
@property (nonatomic, strong) UILabel           *btnBlue;
@property (nonatomic, strong) UILabel           *lableRed;
@property (nonatomic, strong) UILabel           *lableBlue;
@end
@implementation RLSDoubleBattlecell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setBattlModel:(RLSBattleModel *)battlModel {
    _battlModel = battlModel;
    [self.contentView addSubview:self.basicView];
    _btnRed.text = _battlModel.homenumber;
    _labRed.text = _battlModel.homename;
    if ([_battlModel.homeplace isEqualToString:@""]) {
    }else{
        _lableRed.text=[NSString stringWithFormat:@"[%@]",_battlModel.homeplace];
        _lableBlue.text=[NSString stringWithFormat:@"[%@]",_battlModel.homeplace];
    }
    _labBlue.text = _battlModel.guestname;
    _btnBlue.text = _battlModel.guestnumber;
    if (_battlModel.homeplayerid==111111111) {
        _labRed.textColor=[UIColor redColor];
        _labBlue.textColor=color45c4ee;
    }
    if (isNUll(_battlModel.homenumber)) {
        _btnRed.hidden = YES;
    }else{
        _btnRed.hidden = NO;
    }
    if (isNUll(_battlModel.guestnumber)) {
        _btnBlue.hidden = YES;
    }else{
        _btnBlue.hidden = NO;
    }
    [self addCellAutoLayout];
}
#pragma mark - initialize -
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.btnRed];
        [_basicView addSubview:self.labRed];
        [_basicView addSubview:self.btnBlue];
        [_basicView addSubview:self.labBlue];
        [_basicView addSubview:self.lableRed];
        [_basicView addSubview:self.lableBlue];
    }
    return _basicView;
}
- (UILabel *)btnRed {
    if (!_btnRed) {
        _btnRed = [UILabel new];
        _btnRed.font = font14;
        _btnRed.textColor = [UIColor whiteColor];
        _btnRed.backgroundColor = redcolor;
        _btnRed.layer.cornerRadius = 12;
        _btnRed.layer.masksToBounds = YES;
        _btnRed.textAlignment = NSTextAlignmentCenter;
    }
    return _btnRed;
}
- (UILabel *)labRed {
    if (!_labRed) {
        _labRed = [UILabel new];
        _labRed.font = font14;
        _labRed.textAlignment = NSTextAlignmentLeft;
    }
    return _labRed;
}
- (UILabel *)lableRed {
    if (!_lableRed) {
        _lableRed = [UILabel new];
        _lableRed.font = font14;
                _lableRed.textColor = [UIColor lightGrayColor];
        _lableRed.textAlignment = NSTextAlignmentLeft;
    }
    return _lableRed;
}
- (UILabel *)labBlue {
    if (!_labBlue) {
        _labBlue = [UILabel new];
        _labBlue.font = font14;
        _labBlue.textAlignment = NSTextAlignmentRight;
    }
    return _labBlue;
}
- (UILabel *)lableBlue {
    if (!_lableBlue) {
        _lableBlue = [UILabel new];
        _lableBlue.font = font14;
        _lableBlue.textColor = [UIColor lightGrayColor];
        _lableBlue.textAlignment = NSTextAlignmentRight;
    }
    return _lableBlue;
}
- (UILabel *)btnBlue {
    if (!_btnBlue) {
        _btnBlue = [UILabel new];
        _btnBlue.font = font14;
        _btnBlue.textColor = [UIColor whiteColor];
        _btnBlue.layer.cornerRadius = 12;
        _btnBlue.layer.masksToBounds = YES;
        _btnBlue.backgroundColor =color45c4ee;
        _btnBlue.textAlignment = NSTextAlignmentCenter;
    }
    return _btnBlue;
}
#pragma mark - addCellAutoLayout -
- (void)addCellAutoLayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.btnRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.basicView);
        make.leading.equalTo(self.basicView).offset(5);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.labRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btnRed);
        make.leading.mas_equalTo(self.btnRed.mas_trailing).offset(5);
    }];
    [self.lableRed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btnRed);
        make.leading.mas_equalTo(self.labRed.mas_trailing).offset(1);
    }];
    [self.btnBlue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labRed);
        make.trailing.mas_equalTo(self.basicView.mas_trailing).offset(-5);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    [self.labBlue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btnBlue);
        make.trailing.mas_equalTo(self.btnBlue.mas_leading).offset(-5);
    }];
    [self.lableBlue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.btnBlue);
        make.trailing.mas_equalTo(self.labBlue.mas_leading).offset(1);
    }];
}
@end

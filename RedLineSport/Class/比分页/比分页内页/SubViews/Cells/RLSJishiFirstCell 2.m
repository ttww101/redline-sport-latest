#import "RLSJishiFirstCell.h"
@interface RLSJishiFirstCell()
@property (nonatomic, strong) UIView            *basicView;
@property (nonatomic, strong) UILabel           *labTime;
@property (nonatomic, strong) UILabel           *labScore;
@property (nonatomic, strong) UILabel           *labKaiPan;
@property (nonatomic, strong) UILabel           *labJiShi;
@property (nonatomic, strong) UIView            *lineView;
@end
@implementation RLSJishiFirstCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setJiShiPLFirstModel:(RLSJiShiPLFirstModel *)jiShiPLFirstModel {
    _jiShiPLFirstModel = jiShiPLFirstModel;
    [self.contentView addSubview:self.basicView];
    [self addCellAutoLayout];
    self.labTime.text = @"时间";
    self.labScore.text = @"比分";
    self.labKaiPan.text = @"开盘";
    self.labJiShi.text = @"即时";
}
#pragma mark - initialize -
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.lineView];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labScore];
        [_basicView addSubview:self.labKaiPan];
        [_basicView addSubview:self.labJiShi];
    }
    return _basicView;
}
- (UILabel *)labTime {
    if (!_labTime) {
        _labTime = [UILabel new];
        _labTime.text = @"时间";
        _labTime.font = font12;
        _labTime.textColor = [UIColor darkGrayColor];
        _labTime.textAlignment = NSTextAlignmentCenter;
    }
    return _labTime;
}
- (UILabel *)labScore {
    if (!_labScore) {
        _labScore = [UILabel new];
        _labScore.text = @"比分";
        _labScore.font = font12;
        _labScore.textColor = [UIColor darkGrayColor];
        _labScore.textAlignment = NSTextAlignmentCenter;
    }
    return _labScore;
}
- (UILabel *)labKaiPan {
    if (!_labKaiPan) {
        _labKaiPan = [UILabel new];
        _labKaiPan.text = @"开盘";
        _labKaiPan.font = font12;
        _labKaiPan.textColor = [UIColor darkGrayColor];
        _labKaiPan.textAlignment = NSTextAlignmentCenter;
    }
    return _labKaiPan;
}
- (UILabel *)labJiShi {
    if (!_labJiShi) {
        _labJiShi = [UILabel new];
        _labJiShi.text = @"即时";
        _labJiShi.font = font12;
        _labJiShi.textColor = [UIColor darkGrayColor];
        _labJiShi.textAlignment = NSTextAlignmentCenter;
    }
    return _labJiShi;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = colorEEEEEE;
    }
    return _lineView;
}
#pragma mark - addCellAutoLayout -
- (void)addCellAutoLayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.basicView);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(37.5);
    }];
    [self.labScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labTime);
        make.leading.mas_equalTo(self.labTime.mas_trailing);
        make.width.mas_equalTo(47.5);
    }];
    [self.labKaiPan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labScore);
        make.leading.mas_equalTo(self.labScore.mas_trailing);
        make.width.mas_equalTo(137.5);
    }];
    [self.labJiShi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labKaiPan);
        make.trailing.mas_equalTo(self);
        make.width.mas_equalTo(137.5);
    }];
}
@end

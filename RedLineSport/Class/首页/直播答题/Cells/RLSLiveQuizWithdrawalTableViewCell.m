#import "RLSLiveQuizWithdrawalTableViewCell.h"
@interface RLSLiveQuizWithdrawalTableViewCell ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *vsLabel;
@property (nonatomic, strong) UILabel *addMoneyLabel;
@end
@implementation RLSLiveQuizWithdrawalTableViewCell
static CGFloat cell_Height = 70.f;
static NSString *identifier = @"listCell";
+ (RLSLiveQuizWithdrawalTableViewCell *)cellForTableView:(UITableView *)tableView {
    RLSLiveQuizWithdrawalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RLSLiveQuizWithdrawalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
+ (CGFloat)heightForCell {
    return cell_Height;
}
- (void)refreshContentData:(id)model {
    RLSWithdrawalModel *data = (RLSWithdrawalModel *)model;
    self.timeLabel.text = [RLSMethods formatMMDDWithStamp:data.created];
    self.vsLabel.text = data.item_name;
    self.addMoneyLabel.text = [NSString stringWithFormat:@"+%@元", [RLSMethods amountFormater:data.amount]];
}
#pragma mark - Config UI
- (void)configUI {
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.left.equalTo(self.contentView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(15);
    }];
    [self.contentView addSubview:self.vsLabel];
    [self.vsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_left);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(9);
    }];
    [self.contentView addSubview:self.addMoneyLabel];
    [self.addMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}
#pragma mark - Lazy Load
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _lineView;
}
- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"03-28 15:00";
        _timeLabel.font = [UIFont systemFontOfSize:12.f];
        _timeLabel.textColor = UIColorFromRGBWithOX(0x999999);
    }
    return _timeLabel;
}
- (UILabel *)vsLabel {
    if (_vsLabel == nil) {
        _vsLabel = [UILabel new];
        _vsLabel.text = @"巴塞罗那 vs 皇家马德里";
        _vsLabel.font = [UIFont systemFontOfSize:14.f];
        _vsLabel.textColor = UIColorFromRGBWithOX(0x333333);
    }
    return _vsLabel;
}
- (UILabel *)addMoneyLabel {
    if (_addMoneyLabel == nil) {
        _addMoneyLabel = [UILabel new];
        _addMoneyLabel.text = @"+ 1.85元";
        _addMoneyLabel.font = [UIFont systemFontOfSize:18.f];
        _addMoneyLabel.textColor = UIColorFromRGBWithOX(0xDB2D21);
    }
    return _addMoneyLabel;
}
@end

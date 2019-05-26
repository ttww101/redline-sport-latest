#import "RLSCouponListTableViewCell.h"
@interface RLSCouponListTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic , strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *limitedDate;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic , strong) UIImageView *expiredImageView;
@property (nonatomic , strong) UIImageView *amountImageView;
@end
@implementation RLSCouponListTableViewCell
static CGFloat cell_Height = 126.f;
static NSString *identifier = @"listCell";
+ (RLSCouponListTableViewCell *)cellForTableView:(UITableView *)tableView {
    RLSCouponListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RLSCouponListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    RLSCouponModel *dataMode = (RLSCouponModel *)model;
    self.limitedDate.text = [NSString stringWithFormat:@"有效期至: %@",dataMode.endTime];
    if ([dataMode.status isEqualToString:@"0"]) {
        self.expiredImageView.hidden = YES;
        self.amountImageView.image = [UIImage imageNamed:@"amount"];
    } else if ([dataMode.status isEqualToString:@"1"]) {
        self.expiredImageView.hidden = false;
        self.amountImageView.image = [UIImage imageNamed:@"expiredamount"];
    } else {
    }
}
#pragma mark - Config UI
- (void)configUI {
    self.contentView.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    [self.contentView addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 15, 0, 15));
    }];
    [self.bgImageView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgImageView.mas_top).offset(15);
        make.left.equalTo(self.bgImageView.mas_left).offset(15);
    }];
    [self.bgImageView addSubview:self.limitedDate];
    [self.limitedDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView.mas_centerY);
        make.left.equalTo(self.titleLabel.mas_left);
    }];
    [self.bgImageView addSubview:self.descriptionLabel];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.bottom.equalTo(self.bgImageView.mas_bottom).offset(-10);
    }];
    [self.bgImageView addSubview:self.amountImageView];
    [self.amountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.bgImageView).offset(-15);
        make.top.equalTo(self.bgImageView.mas_top).offset(25);
        make.size.mas_equalTo(CGSizeMake(79, 27));
    }];
    [self.bgImageView addSubview:self.expiredImageView];
    [self.expiredImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgImageView.mas_bottom).offset(-5);
        make.right.equalTo(self.bgImageView).offset(-15);
        make.size.mas_equalTo(CGSizeMake(66, 51));
    }];
}
#pragma mark - Lazy Load
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"模型预测优惠券";
        _titleLabel.font = [UIFont systemFontOfSize:18.f];
        _titleLabel.textColor = UIColorFromRGBWithOX(0x333333);
    }
    return _titleLabel;
}
- (UILabel *)limitedDate {
    if (_limitedDate == nil) {
        _limitedDate = [UILabel new];
        _limitedDate.text = @"有效期至：2018.04.04 19:45";
        _limitedDate.font = [UIFont systemFontOfSize:12.f];
        _limitedDate.textColor = UIColorFromRGBWithOX(0x999999);
    }
    return _limitedDate;
}
- (UILabel *)descriptionLabel {
    if (_descriptionLabel == nil) {
        _descriptionLabel = [UILabel new];
        _descriptionLabel.text = @"每张优惠券可查看任意一场18钻石模型预测服务";
        _descriptionLabel.font = [UIFont systemFontOfSize:12.f];
        _descriptionLabel.textColor = UIColorFromRGBWithOX(0x999999);
    }
    return _descriptionLabel;
}
- (UIImageView *)bgImageView {
    if (_bgImageView == nil) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [UIImage imageNamed:@"couponbg"];
    }
    return _bgImageView;
}
- (UIImageView *)expiredImageView {
    if (_expiredImageView == nil) {
        _expiredImageView = [UIImageView new];
        _expiredImageView.image = [UIImage imageNamed:@"expiredImage"];
    }
    return _expiredImageView;
}
- (UIImageView *)amountImageView {
    if (_amountImageView == nil) {
        _amountImageView = [UIImageView new];
        _amountImageView.image = [UIImage imageNamed:@"expiredamount"];
    }
    return _amountImageView;
}
@end

#import "RLSHeaderTableViewCell.h"
@interface RLSHeaderTableViewCell ()
@property (nonatomic , strong) CALayer *lineLayer;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation RLSHeaderTableViewCell
static CGFloat cell_Height = 44;
static NSString *identifier = @"headerCell";
static CGFloat imageHeight = 15;
+ (RLSHeaderTableViewCell *)cellForTableView:(UITableView *)tableView {
    RLSHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RLSHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}
#pragma mark - Config UI
- (void)configUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
     [self.contentView.layer addSublayer:self.lineLayer];
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.iconImageView.mas_right).offset(7);
    }];
}
#pragma mark - Lazy Load
- (CALayer *)lineLayer {
    if (_lineLayer == nil) {
        _lineLayer = [CALayer layer];
        _lineLayer.frame = CGRectMake(13, cell_Height - ONE_PX_LINE, Width - 26, ONE_PX_LINE);
        _lineLayer.backgroundColor = UIColorFromRGBWithOX(0xD7D7D7).CGColor;
    }
    return _lineLayer;
}
- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.image = [UIImage imageNamed:@"Comments"];
    }
    return _iconImageView;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:12.f];;
        _titleLabel.textColor = UIColorFromRGBWithOX(0x000000);
    }
    return _titleLabel;
}
@end

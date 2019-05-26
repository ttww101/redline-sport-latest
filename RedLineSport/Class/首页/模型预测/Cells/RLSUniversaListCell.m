#import "RLSUniversaListCell.h"
@implementation UniversaListCellModel
@end
@interface RLSUniversaListCell ()
@property (nonatomic , strong) UIImageView *leftIcon;
@property (nonatomic , strong) UILabel *titleLabel;
@end
@implementation RLSUniversaListCell
static CGFloat cell_Height = 60;
static NSString *identifier = @"listCell";
static CGFloat imageHeight = 40;
+ (RLSUniversaListCell *)cellForTableView:(UITableView *)tableView {
    RLSUniversaListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RLSUniversaListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
- (void)refreshContentData:(UniversaListCellModel *)model {
    self.leftIcon.image = [UIImage imageNamed:model.leftIconImageName];
    self.titleLabel.text = model.content;
}
#pragma mark - Config UI
- (void)configUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.leftIcon];
    [self.leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.leftIcon.mas_right).offset(10);
    }];
}
#pragma mark - Lazy Load
- (UIImageView *)leftIcon {
    if (_leftIcon == nil) {
        _leftIcon = [UIImageView new];
        _leftIcon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftIcon;
}
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = color40;
    }
    return _titleLabel;
}
@end

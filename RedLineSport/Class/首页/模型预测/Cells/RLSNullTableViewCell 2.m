#import "RLSNullTableViewCell.h"
@implementation RLSNullTableViewCell
static CGFloat cell_Height = 5;
static NSString *identifier = @"nullCell";
+ (RLSNullTableViewCell *)cellForTableView:(UITableView *)tableView {
    RLSNullTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RLSNullTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
#pragma mark - Config UI
- (void)configUI {
    self.contentView.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
}
@end

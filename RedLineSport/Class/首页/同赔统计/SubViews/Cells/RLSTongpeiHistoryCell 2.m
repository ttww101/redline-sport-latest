#import "RLSTongpeiHistoryCell.h"
@interface RLSTongpeiHistoryCell()
@end
@implementation RLSTongpeiHistoryCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setData:(NSString *)data
{
    _data = data;
    [self.contentView removeAllSubViews];
    for (int i = 0; i<4; i++) {
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(Width/4*i, 5, Width/4, 16)];
        labTitle.font = font12;
        labTitle.textColor = color33;
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.text = @"全赛事";
        [self.contentView addSubview:labTitle];
        UILabel *labWin = [[UILabel alloc] initWithFrame:CGRectMake(Width/4*i, 17 + 7, Width/4, 12)];
        labWin.font = font12;
        labWin.textColor = color99;
        labWin.textAlignment = NSTextAlignmentCenter;
        labWin.text = @"近10场";
        [self.contentView addSubview:labWin];
    }
}
@end

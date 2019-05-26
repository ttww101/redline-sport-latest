#import "RLSTongpeiDTTitileView.h"
@implementation RLSTongpeiDTTitileView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubviews];
    }
    return self;
}
- (void)setSubviews
{
    UILabel *labLeague = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, self.height)];
    labLeague.textColor = color99;
    labLeague.font = font12;
    labLeague.text = @"赛事";
    [self addSubview:labLeague];
    UILabel *labTeam = [[UILabel alloc] initWithFrame:CGRectMake(labLeague.right, 0, (Width - 15 - 60 - 35 -100 - 55), self.height)];
    labTeam.textColor = color99;
    labTeam.font = font12;
    labTeam.text = @"对阵";
    [self addSubview:labTeam];
    UILabel *labScore = [[UILabel alloc] initWithFrame:CGRectMake(labTeam.right, 0, 35, self.height)];
    labScore.textColor = color99;
    labScore.font = font12;
    labScore.text = @"比分";
    labScore.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labScore];
    UILabel *labPankou = [[UILabel alloc] initWithFrame:CGRectMake(labScore.right, 0, 100, self.height)];
    labPankou.textColor = color99;
    labPankou.font = font12;
    labPankou.text = @"初赔/终赔";
    labPankou.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labPankou];
    UILabel *labWin = [[UILabel alloc] initWithFrame:CGRectMake(labPankou.right, 0, 55, self.height)];
    labWin.textColor = color99;
    labWin.font = font12;
    labWin.text = @"赛果";
    labWin.textAlignment = NSTextAlignmentCenter;
    [self addSubview:labWin];
}
@end

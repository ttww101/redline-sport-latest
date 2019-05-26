#import "RLSBisaiTJHeaderView.h"
#import "RLSBisaiTJRoundView.h"
#import "RLSBisaiTHeaderFenxiView.h"
#import "RLSTechtwoModel.h"
@interface RLSBisaiTJHeaderView()
@end
@implementation RLSBisaiTJHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)setArrdata:(NSArray *)arrdata
{
    _arrdata = arrdata;
    RLSTechtwoModel *home;
    RLSTechtwoModel *guest;
    if (_arrdata.count == 2) {
        home = [_arrdata objectAtIndex:0];
        guest = [_arrdata objectAtIndex:1];
    }
    for (int i = 0; i<3; i++) {
        UIView *roundV = [[UIView alloc] initWithFrame:CGRectMake(Width/3*i, 0, Width/3, 90)];
        [self addSubview:roundV];
        UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Width/3, 30)];
        labTitle.textColor = color33;
        labTitle.textAlignment = NSTextAlignmentCenter;
        labTitle.font = font12;
        labTitle.text = @"进攻";
        [roundV addSubview:labTitle];
        RLSBisaiTJRoundView *round = [[RLSBisaiTJRoundView alloc] initWithFrame:CGRectMake(0, 40, 40, 40)];
        round.center = CGPointMake(roundV.width/2, round.center.y);
        round.backgroundColor = [UIColor whiteColor];
        [roundV addSubview:round];
        UILabel *lableft = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (roundV.width -40 - 5*2)/2, 20)];
        lableft.center = CGPointMake(lableft.center.x, round.center.y);
        lableft.textColor = color33;
        lableft.textAlignment = NSTextAlignmentRight;
        lableft.font = font12;
        lableft.text = @"138";
        [roundV addSubview:lableft];
        UILabel *labright = [[UILabel alloc] initWithFrame:CGRectMake( (roundV.width -40 - 5*2)/2 + 40 + 10, 0, (roundV.width -40 - 5*2)/2, 20)];
        labright.center = CGPointMake(labright.center.x, round.center.y);
        labright.textColor = color33;
        labright.font = font12;
        labright.text = @"36";
        [roundV addSubview:labright];
        CGFloat scaleRound = 100;
        switch (i) {
            case 0:
            {
                labTitle.text = @"进攻";
                lableft.text = home.attack;
                labright.text = guest.attack;
                if ([home.attack floatValue] + [guest.attack floatValue] != 0) {
                    scaleRound =100 - ([home.attack floatValue]/([home.attack floatValue] + [guest.attack floatValue])*100);
                }
                round.roundData = scaleRound;
            }
                break;
            case 1:
            {
                labTitle.text = @"危险进攻";
                lableft.text = home.attacker;
                labright.text = guest.attacker;
                if ([home.attacker floatValue] + [guest.attacker floatValue] != 0) {
                    scaleRound = 100 - ([home.attacker floatValue]/([home.attacker floatValue] + [guest.attacker floatValue])*100);
                }
                round.roundData = scaleRound;
            }
                break;
            case 2:
            {
                labTitle.text = @"控球率";
                lableft.text =  home.possessionTime;
                labright.text = guest.possessionTime;
                if ([home.possessionTime floatValue] + [guest.possessionTime floatValue] != 0) {
                    scaleRound =100 - ([home.possessionTime floatValue]/([home.possessionTime floatValue] + [guest.possessionTime floatValue])*100);
                }
                round.roundData = scaleRound;
            }
                break;
            default:
                break;
        }
    }
    if (isOniphone6p) {
        RLSBisaiTHeaderFenxiView *headerLeft = [[RLSBisaiTHeaderFenxiView alloc] initWithFrame:CGRectMake(20, 90 + 10, 30*4, 25*2)];
        headerLeft.ishome = 0;
        headerLeft.model = home;
        [self addSubview:headerLeft];
        RLSBisaiTHeaderFenxiView *headerRight = [[RLSBisaiTHeaderFenxiView alloc] initWithFrame:CGRectMake(Width - 20 - 30*4, 90 + 10, 30*4, 25*2)];
        headerRight.ishome = 1;
        headerRight.model = guest;
        [self addSubview:headerRight];
    }else if (isOniPhone4 || isOniPhone5){
        RLSBisaiTHeaderFenxiView *headerLeft = [[RLSBisaiTHeaderFenxiView alloc] initWithFrame:CGRectMake(10, 90 + 10, 25*4, 25*2)];
        headerLeft.ishome = 0;
        headerLeft.model = home;
        [self addSubview:headerLeft];
        RLSBisaiTHeaderFenxiView *headerRight = [[RLSBisaiTHeaderFenxiView alloc] initWithFrame:CGRectMake(Width - 10 - 25*4, 90 + 10, 25*4, 25*2)];
        headerRight.ishome = 1;
        headerRight.model = guest;
        [self addSubview:headerRight];
    }else{
        RLSBisaiTHeaderFenxiView *headerLeft = [[RLSBisaiTHeaderFenxiView alloc] initWithFrame:CGRectMake(10, 90 + 10, 30*4, 25*2)];
        headerLeft.ishome = 0;
        headerLeft.model = home;
        [self addSubview:headerLeft];
        RLSBisaiTHeaderFenxiView *headerRight = [[RLSBisaiTHeaderFenxiView alloc] initWithFrame:CGRectMake(Width - 10 - 30*4, 90 + 10, 30*4, 25*2)];
        headerRight.ishome = 1;
        headerRight.model = guest;
        [self addSubview:headerRight];
    }
    UIView *viewZheng = [[UIView alloc] initWithFrame:CGRectMake(0, 90, 100, 28)];
    viewZheng.center = CGPointMake(self.width/2, viewZheng.center.y);
    [self addSubview:viewZheng];
    UILabel *labZheng = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewZheng.width, viewZheng.height)];
    labZheng.font = font12;
    labZheng.textColor = color33;
    labZheng.text = @"射正球门";
    labZheng.textAlignment = NSTextAlignmentCenter;
    [viewZheng addSubview:labZheng];
    UIView *viewzhengTotal = [[UIView alloc] initWithFrame:CGRectMake(0, viewZheng.height - 4, viewZheng.width, 4)];
    viewzhengTotal.backgroundColor = colorEE;
    [viewZheng addSubview:viewzhengTotal];
    CGFloat zhengScale = 0;
    if ([home.shotsOn floatValue] + [guest.shotsOn floatValue] != 0) {
        zhengScale = [home.shotsOn floatValue]/([home.shotsOn floatValue] + [guest.shotsOn floatValue]);
    }
    UIView *viewzhengRed = [[UIView alloc] initWithFrame:CGRectMake(0, viewZheng.height - 4, viewZheng.width*zhengScale, 4)];
    viewzhengRed.backgroundColor = redcolor;
    [viewZheng addSubview:viewzhengRed];
    UIView *viewPian = [[UIView alloc] initWithFrame:CGRectMake(0, 90 + 28, 100, 28)];
    viewPian.center = CGPointMake(self.width/2, viewPian.center.y);
    [self addSubview:viewPian];
    UILabel *labPian = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, viewPian.width, viewPian.height)];
    labPian.font = font12;
    labPian.textColor = color33;
    labPian.text = @"射偏球门";
    labPian.textAlignment = NSTextAlignmentCenter;
    [viewPian addSubview:labPian];
    UIView *viewPianTotal = [[UIView alloc] initWithFrame:CGRectMake(0, viewPian.height - 4, viewPian.width, 4)];
    viewPianTotal.backgroundColor = colorEE;
    [viewPian addSubview:viewPianTotal];
    CGFloat pianScale = 0;
    if ([home.shotsNotOn floatValue] + [guest.shotsNotOn floatValue] != 0) {
        pianScale = [home.shotsNotOn floatValue]/([home.shotsNotOn floatValue] + [guest.shotsNotOn floatValue]);
    }
    UIView *viewPianRed = [[UIView alloc] initWithFrame:CGRectMake(0, viewPian.height - 4, viewPian.width*pianScale, 4)];
    viewPianRed.backgroundColor = redcolor;
    [viewPian addSubview:viewPianRed];
}
@end

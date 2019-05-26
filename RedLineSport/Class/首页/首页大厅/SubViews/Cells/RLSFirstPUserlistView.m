#import "RLSFirstPUserlistView.h"
#import "DCImageViewRoundCorner.h"
@interface RLSFirstPUserlistView()
@property (nonatomic, strong) UIView *basicView;
@end
@implementation RLSFirstPUserlistView
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    CGFloat btnwidth = 50;
    CGFloat btnheight = 50;
    CGFloat space = (Width - 200)/8;
    CGFloat btnwidthUp = Width / 4;
    [_arrData enumerateObjectsUsingBlock:^(RLSUserlistModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 8) {
            return ;
        }
        UIButton *upBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnwidthUp*(idx > 3 ? idx - 4 : idx) , idx > 3 ? self.height/2 : 0, btnwidthUp, self.height/2)];
        [upBtn setBackgroundImage:[UIImage imageNamed:@"f5f5f5"] forState:UIControlStateHighlighted];
        [upBtn setBackgroundImage:nil forState:UIControlStateNormal];
        upBtn.tag = idx;
        upBtn.userInteractionEnabled = YES;
        [upBtn addTarget:self action:@selector(btntouch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:upBtn];
        DCImageViewRoundCorner *btn = [[DCImageViewRoundCorner alloc] init];
        btn.frame = CGRectMake(space + (space * 2 + btnwidth)*(idx > 3 ? idx - 4 : idx), idx > 3 ? self.height/2 + 10 : 20, btnheight, btnheight);
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.pic]  placeholderImage:[UIImage imageNamed:@"defaultPic"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [btn addCornerRadius:btn.width/2];
        }];
        btn.tag = idx;
        [self addSubview:btn];
        DCImageViewRoundCorner *imageLab = [[DCImageViewRoundCorner alloc] init];
        imageLab.frame = CGRectMake(btn.right - 15, btn.top + 3, 15, 15);
        [self addSubview:imageLab];
        UILabel *labNum = [[UILabel alloc] initWithFrame:CGRectMake(btn.right - 15, btn.top + 3, 15, 15)];
        if (obj.newRecommendCount == 0 ) {
            labNum.hidden = YES;
            imageLab.hidden = YES;
        }else{
            imageLab.image = [UIImage imageNamed:@"red"];
            [imageLab addCornerRadius:3];
        }
        labNum.textColor = [UIColor whiteColor];
        labNum.textAlignment = NSTextAlignmentCenter;
        labNum.font = font9;
        labNum.text = [NSString stringWithFormat:@"%ld",obj.newRecommendCount];
        [self addSubview:labNum];
        DCImageViewRoundCorner *imageLab1 = [[DCImageViewRoundCorner alloc] init];
        imageLab1.frame = CGRectMake(0, btn.bottom - 10, 40, 15);
        imageLab1.center = CGPointMake(btn.center.x, imageLab1.center.y);
        [self addSubview:imageLab1];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.bottom - 10, 40, 15)];
        lab.center = CGPointMake(btn.center.x, lab.center.y);
        if (obj.userintro == nil || [obj.userintro isEqualToString:@""]) {
            lab.hidden = YES;
            imageLab1.hidden = YES;
        }else{
            imageLab1.image = [UIImage imageNamed:@"red"];
            [imageLab1 addCornerRadius:3];
        }
        lab.textColor = [UIColor whiteColor];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = font11;
        lab.text = obj.userintro;
        [self addSubview:lab];
        UIButton *user = [UIButton buttonWithType:UIButtonTypeCustom];
        user.frame = CGRectMake(0, lab.bottom + 10, btnwidth + 40, 15);
        user.center  = CGPointMake(btn.center.x, user.center.y);
        [user setTitle:obj.nickname forState:UIControlStateNormal];
        [user setTitleColor:color33 forState:UIControlStateNormal];
        [user.titleLabel setFont:font13];
        user.tag = idx;
        user.userInteractionEnabled = NO;
        user.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:user];
    }];
}
- (void)btntouch:(UIButton *)btn
{
    RLSUserlistModel *mode = [_arrData objectAtIndex:btn.tag];
    if (_delegate && [_delegate respondsToSelector:@selector(selectedUserWithId:)]) {
        [_delegate selectedUserWithId:mode];
    }
}
@end

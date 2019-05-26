#import "RLSVierticalScrollView.h"
#define MMColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MMRandomColor MMColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define Screen_width ([UIScreen mainScreen].bounds.size.width)
#define Screen_height ([UIScreen mainScreen].bounds.size.height)
#define BTNWidth self.bounds.size.width
#define BTNHeight self.bounds.size.height
@interface RLSVierticalScrollView ()
@property (nonatomic,strong) NSMutableArray *titles;
@property(assign, nonatomic)int titleIndex;
@property(assign, nonatomic)int index;
@end
@implementation RLSVierticalScrollView
-(instancetype)initWithArray:(NSArray *)titles AndFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSMutableArray *MutableTitles = [NSMutableArray arrayWithArray:titles];
        NSString *str = @"";
        self.titles = MutableTitles;
        [self.titles addObject:str];
        self.index = 1;
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0, 0, self.width, self.height);
        btn.tag = self.index;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.titles[0] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setTitleColor:color33 forState:UIControlStateNormal];
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        btn.titleLabel.font = font12;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:btn];
        self.clipsToBounds = YES;
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextButton) userInfo:nil repeats:YES];
    }
    return self;
}
+(instancetype)initWithTitleArray:(NSArray *)titles AndFrame:(CGRect)frame{
    return [[self alloc]initWithArray:titles AndFrame:frame];
}
-(void)nextButton{
    UIButton *firstBtn = [self viewWithTag:self.index];
    UIButton *modelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.height, self.width, self.height)];
    [modelBtn setBackgroundColor:[UIColor clearColor]];
    modelBtn.tag = self.index + 1;
    if ([self.titles[self.titleIndex+1] isEqualToString:@""]) {
        self.titleIndex = -1;
        self.index = 0;
    }
    if (modelBtn.tag == self.titles.count) {
        modelBtn.tag = 1;
    }
    [modelBtn setTitleColor:color33 forState:UIControlStateNormal];
    modelBtn.titleLabel.font = font12;
    modelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [modelBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    modelBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [modelBtn setTitle:self.titles[self.titleIndex+1] forState:UIControlStateNormal];
    [self addSubview:modelBtn];
    [UIView animateWithDuration:1.25 animations:^{
        firstBtn.y = -self.height;
        modelBtn.y = 0;
    } completion:^(BOOL finished) {
        [firstBtn removeFromSuperview];
    } ];
    self.index++;
    self.titleIndex++;
}
-(void)clickBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(clickTitleButton:)]) {
        [self.delegate clickTitleButton:btn];
    }
}
@end

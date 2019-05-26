#import "RLSJiShiPeiLvCell.h"
@interface RLSJiShiPeiLvCell(){
    NSTimer*_timer;
    NSInteger num;
}
@property (nonatomic, strong) UIView            *basicView;
@property (nonatomic, strong) UILabel           *miniTime;
@property (nonatomic, strong) UILabel           *score;
@property (nonatomic, strong) UILabel           *homeOdds0;
@property (nonatomic, strong) UILabel           *panKou0;
@property (nonatomic, strong) UILabel           *awayOdds0;
@property (nonatomic, strong) UILabel           *homeOdds;
@property (nonatomic, strong) UILabel           *panKou;
@property (nonatomic, strong) UILabel           *awayOdds;
@property (nonatomic, assign) NSString          *isClosed;
@end
@implementation RLSJiShiPeiLvCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setJsplArr:(NSMutableArray *)jsplArr {
    [self.contentView addSubview:self.basicView];
    NSLog(@"==%@==%ld",jsplArr,jsplArr.count);
    num=1;
    _miniTime.text = jsplArr[1];
    _score.text = [NSString stringWithFormat:@"%@-%@",jsplArr[2] ,jsplArr[3]];
    _homeOdds0.text =[NSString stringWithFormat:@"%.2f",[jsplArr[5] floatValue]] ;
    _panKou0.text = [self method1:[jsplArr[6]floatValue]];
    _awayOdds0.text = [NSString stringWithFormat:@"%.2f",[jsplArr[7] floatValue]];
    _homeOdds.text = [NSString stringWithFormat:@"%.2f",[jsplArr[8] floatValue]];
    _panKou.text = [self method1:[jsplArr[9]floatValue]];
    _awayOdds.text = [NSString stringWithFormat:@"%.2f",[jsplArr[10] floatValue]];
    NSArray *arrLeft = [jsplArr[6] componentsSeparatedByString:@"."];
    if (arrLeft.count == 2) {
        if ([[NSString stringWithFormat:@"%@",jsplArr[6]] containsString:@"-"]) {
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[jsplArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[jsplArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [jsplArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [jsplArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    NSArray *arrRight = [jsplArr[9] componentsSeparatedByString:@"."];
    if (arrRight.count == 2) {
        if ([[NSString stringWithFormat:@"%@",jsplArr[9]] containsString:@"-"]) {
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[jsplArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[jsplArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [jsplArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [jsplArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    if ([_miniTime.text isEqualToString:@"早"]) {
        _miniTime.textColor = [UIColor greenColor];
    }
    if ([_miniTime.text isEqualToString:@"未"]) {
        _miniTime.textColor = redcolor;
    }
    if (jsplArr.count>=14) {
        if ([jsplArr[13] intValue]==2) {
            _homeOdds.backgroundColor=[UIColor greenColor];
            _homeOdds.textColor=[UIColor whiteColor];
        }else if([jsplArr[13] intValue]==1){
            _homeOdds.backgroundColor=[UIColor redColor];
            _homeOdds.textColor=[UIColor whiteColor];
        }
        else{
            _homeOdds.backgroundColor=[UIColor clearColor];
            _homeOdds.textColor=[UIColor blackColor];
        }
        if (jsplArr.count - 1 >= 14) {
            if ([jsplArr[14] intValue]==2) {
                _awayOdds.backgroundColor=[UIColor greenColor];
                _awayOdds.textColor=[UIColor whiteColor];
            }else if([jsplArr[14] intValue]==1){
                _awayOdds.backgroundColor=[UIColor redColor];
                _awayOdds.textColor=[UIColor whiteColor];
            }else{
                _awayOdds.backgroundColor=[UIColor clearColor];
                _awayOdds.textColor=[UIColor blackColor];
            }
        }
    }
    if (jsplArr.count>12) {
        if ([jsplArr[12] integerValue]==1) {
            _homeOdds.text=@"";
            _panKou.text=@"封";
            _awayOdds.text=@"";
            _panKou.textColor=[UIColor greenColor];
        }else{
            _panKou.textColor=redcolor;
        }
    }
    [self addCellAutoLayout];
}
-(void)timerChangeData{
    if (num>1) {
        _homeOdds.backgroundColor=[UIColor clearColor];
        _homeOdds.textColor=[UIColor blackColor];
        _awayOdds.backgroundColor=[UIColor clearColor];
        _awayOdds.textColor=[UIColor blackColor];
        [_timer invalidate];
        _timer=nil;
    }
    num++;
}
- (void)setJsplTwoArr:(NSMutableArray *)jsplTwoArr {
    [self.contentView addSubview:self.basicView];
    num=1;
    _miniTime.text = jsplTwoArr[1];
    _score.text = [NSString stringWithFormat:@"%@-%@",jsplTwoArr[2] ,jsplTwoArr[3]];
    _homeOdds0.text =[NSString stringWithFormat:@"%.2f",[jsplTwoArr[5] floatValue]] ;
    _panKou0.text = [self method1:[jsplTwoArr[6]floatValue]];
    _awayOdds0.text = [NSString stringWithFormat:@"%.2f",[jsplTwoArr[7] floatValue]];
    _homeOdds.text = [NSString stringWithFormat:@"%.2f",[jsplTwoArr[8] floatValue]];
    _panKou.text = [self method1:[jsplTwoArr[9]floatValue]];
    _awayOdds.text = [NSString stringWithFormat:@"%.2f",[jsplTwoArr[10] floatValue]];
    NSArray *arrLeft = [jsplTwoArr[6] componentsSeparatedByString:@"."];
    if (arrLeft.count == 2) {
        if ([[NSString stringWithFormat:@"%@",jsplTwoArr[6]] containsString:@"-"]) {
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[jsplTwoArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[jsplTwoArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [jsplTwoArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [jsplTwoArr[6] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou0.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    NSArray *arrRight = [jsplTwoArr[9] componentsSeparatedByString:@"."];
    if (arrRight.count == 2) {
        if ([[NSString stringWithFormat:@"%@",jsplTwoArr[9]] containsString:@"-"]) {
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[jsplTwoArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[jsplTwoArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [jsplTwoArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [jsplTwoArr[9] floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                _panKou.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    if ([_miniTime.text isEqualToString:@"早"]) {
        _miniTime.textColor = [UIColor greenColor];
    }
    if ([_miniTime.text isEqualToString:@"未"]) {
        _miniTime.textColor = redcolor;
    }
    if (jsplTwoArr.count>=14) {
        if ([jsplTwoArr[13] integerValue]==1) {
            _homeOdds.backgroundColor=[UIColor greenColor];
            _homeOdds.textColor=[UIColor whiteColor];
        }else if([jsplTwoArr[13] integerValue]==2){
            _homeOdds.backgroundColor=[UIColor redColor];
            _homeOdds.textColor=[UIColor whiteColor];
        }else{
            _homeOdds.backgroundColor=[UIColor clearColor];
            _homeOdds.textColor=[UIColor blackColor];
        }
        if (jsplTwoArr.count - 1 >= 14) {
            if ([jsplTwoArr[14] integerValue]==1) {
                _awayOdds.backgroundColor=[UIColor greenColor];
                _awayOdds.textColor=[UIColor whiteColor];
            }else if([jsplTwoArr[14] integerValue]==2){
                _awayOdds.backgroundColor=[UIColor redColor];
                _awayOdds.textColor=[UIColor whiteColor];
            }else{
                _awayOdds.backgroundColor=[UIColor clearColor];
                _awayOdds.textColor=[UIColor redColor];
            }
        }
    }
    if (jsplTwoArr.count>12) {
        if ([jsplTwoArr[12] integerValue]==1) {
            _homeOdds.text=@"";
            _panKou.text=@"封";
            _awayOdds.text=@"";
            _panKou.textColor=[UIColor greenColor];
        }else{
            _panKou.textColor=redcolor;
        }
    }
    [self addCellAutoLayout];
}
#pragma mark - initialize -
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.miniTime];
        [_basicView addSubview:self.score];
        [_basicView addSubview:self.homeOdds0];
        [_basicView addSubview:self.panKou0];
        [_basicView addSubview:self.awayOdds0];
        [_basicView addSubview:self.homeOdds];
        [_basicView addSubview:self.panKou];
        [_basicView addSubview:self.awayOdds];
    }
    return _basicView;
}
- (UILabel *)miniTime {
    if (!_miniTime) {
        _miniTime = [UILabel new];
        _miniTime.font = font12;
        _miniTime.textAlignment = NSTextAlignmentCenter;
    }
    return _miniTime;
}
- (UILabel *)score {
    if (!_score) {
        _score = [UILabel new];
        _score.font = font12;
        _score.textColor = redcolor;
        _score.textAlignment = NSTextAlignmentCenter;
    }
    return _score;
}
- (UILabel *)homeOdds0 {
    if (!_homeOdds0) {
        _homeOdds0 = [UILabel new];
        _homeOdds0.font = font12;
        _homeOdds0.textAlignment = NSTextAlignmentCenter;
    }
    return _homeOdds0;
}
- (UILabel *)panKou0 {
    if (!_panKou0) {
        _panKou0 = [UILabel new];
        _panKou0.font = font12;
        _panKou0.textColor = redcolor;
        _panKou0.textAlignment = NSTextAlignmentCenter;
    }
    return _panKou0;
}
- (UILabel *)awayOdds0 {
    if (!_awayOdds0) {
        _awayOdds0 = [UILabel new];
        _awayOdds0.font = font12;
        _awayOdds0.textAlignment = NSTextAlignmentCenter;
    }
    return _awayOdds0;
}
- (UILabel *)homeOdds {
    if (!_homeOdds) {
        _homeOdds = [UILabel new];
        _homeOdds.font = font12;
        _homeOdds.textAlignment = NSTextAlignmentCenter;
    }
    return _homeOdds;
}
- (UILabel *)panKou {
    if (!_panKou) {
        _panKou = [UILabel new];
        _panKou.font = font12;
        _panKou.textColor = redcolor;
        _panKou.textAlignment = NSTextAlignmentCenter;
    }
    return _panKou;
}
- (UILabel *)awayOdds {
    if (!_awayOdds) {
        _awayOdds = [UILabel new];
        _awayOdds.font = font12;
        _awayOdds.textAlignment = NSTextAlignmentCenter;
    }
    return _awayOdds;
}
#pragma mark - addCellAutoLayout -
- (void)addCellAutoLayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.miniTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(35);
    }];
    [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.miniTime);
        make.leading.mas_equalTo(self.miniTime.mas_trailing);
        make.width.mas_equalTo(47.5);
    }];
    [self.homeOdds0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.score);
        make.leading.mas_equalTo(self.score.mas_trailing);
        make.width.mas_equalTo(45);
    }];
    [self.panKou0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.homeOdds0);
        make.leading.mas_equalTo(self.homeOdds0.mas_trailing);
        make.width.mas_equalTo(47.5);
    }];
    [self.awayOdds0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.panKou0);
        make.leading.mas_equalTo(self.panKou0.mas_trailing);
        make.width.mas_equalTo(45);
    }];
    [self.homeOdds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.awayOdds0);
        make.leading.mas_equalTo(self.awayOdds0.mas_trailing);
        make.width.mas_equalTo(45);
    }];
    [self.panKou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.homeOdds);
        make.leading.mas_equalTo(self.homeOdds.mas_trailing);
        make.width.mas_equalTo(47.5);
    }];
    [self.awayOdds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.panKou);
        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-10);
        make.width.mas_equalTo(45);
    }];
}
- (NSString *)method1:(CGFloat)f
{
    NSString *str1 = [ NSString stringWithFormat:@"%f",f];
    NSArray *arrf = [str1 componentsSeparatedByString:@"."];
    if ([[arrf objectAtIndex:1] containsString:@"5"]) {
        return  [NSString stringWithFormat:@"%.1f",f];
    }else{
        return  [NSString stringWithFormat:@"%d",(int)f];
    }
}
@end

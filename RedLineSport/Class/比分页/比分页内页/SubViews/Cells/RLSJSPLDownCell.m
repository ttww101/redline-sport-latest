#import "RLSJSPLDownCell.h"
@interface RLSJSPLDownCell()
@property (nonatomic, strong) UIView            *basicView;
@property (nonatomic, strong) UILabel           *labLName;
@property (nonatomic, strong) UILabel           *labKPLeft;
@property (nonatomic, strong) UILabel           *labKPMid;
@property (nonatomic, strong) UILabel           *labKPRight;
@property (nonatomic, strong) UILabel           *labRname;
@property (nonatomic, strong) UILabel           *labJSLeft;
@property (nonatomic, strong) UILabel           *labJSMid;
@property (nonatomic, strong) UILabel           *labJSRight;
@end
@implementation RLSJSPLDownCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setJsplDwonModel:(RLSJSPLDownMode *)jsplDwonModel
{
    _jsplDwonModel = jsplDwonModel;
    [self.contentView addSubview:self.basicView];
    self.labKPLeft.text = [NSString stringWithFormat:@"%.2f",jsplDwonModel.Cp_Home];
    self.labKPMid.text = [self method1:jsplDwonModel.Cp_Goal];
    self.labKPRight.text = [NSString stringWithFormat:@"%.2f",jsplDwonModel.Cp_Guest];
    self.labJSLeft.text = [NSString stringWithFormat:@"%.2f",jsplDwonModel.Js_Home];
    self.labJSMid.text = [self method1:jsplDwonModel.Js_Goal];
    self.labJSRight.text = [NSString stringWithFormat:@"%.2f",jsplDwonModel.Js_Guest];
    NSString *strCP= self.labKPMid.text;
    NSArray *arrLeft = [strCP componentsSeparatedByString:@"."];
    if (arrLeft.count == 2) {
        if ([[NSString stringWithFormat:@"%@",strCP] containsString:@"-"]) {
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    NSString *strJP = self.labJSMid.text;
    NSArray *arrRight = [strJP componentsSeparatedByString:@"."];
    if (arrRight.count == 2) {
        if ([[NSString stringWithFormat:@"%@",strJP] containsString:@"-"]) {
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    [self addCellAutoLayout];
}
- (void)setJsplDwonTwoModel:(RLSJSPLDownTwoModel *)jsplDwonTwoModel {
    _jsplDwonTwoModel = jsplDwonTwoModel;
    [self.contentView addSubview:self.basicView];
    self.labKPLeft.text = [NSString stringWithFormat:@"%.2f",jsplDwonTwoModel.Cp_Up];
    self.labKPMid.text = [NSString stringWithFormat:@"%.2f",jsplDwonTwoModel.Cp_Goal];
    self.labKPRight.text = [NSString stringWithFormat:@"%.2f",jsplDwonTwoModel.Cp_Down];
    self.labJSLeft.text = [NSString stringWithFormat:@"%.2f",jsplDwonTwoModel.Js_Up];
    self.labJSMid.text = [NSString stringWithFormat:@"%.2f",jsplDwonTwoModel.Js_Goal];
    self.labJSRight.text = [NSString stringWithFormat:@"%.2f",jsplDwonTwoModel.Js_Down];
    if (jsplDwonTwoModel.Js_Down2==1) {
        self.labJSRight.backgroundColor=[UIColor greenColor];
        self.labJSRight.textColor=[UIColor whiteColor];
    }else if (jsplDwonTwoModel.Js_Down2==2){
        self.labJSRight.backgroundColor=[UIColor redColor];
        self.labJSRight.textColor=[UIColor whiteColor];
    }
    self.labKPMid.text = [self method1:jsplDwonTwoModel.Cp_Goal];
    self.labJSMid.text = [self method1:jsplDwonTwoModel.Js_Goal];
    if (jsplDwonTwoModel.Js_Goal2==1) {
        self.labJSLeft.backgroundColor=[UIColor greenColor];
        self.labJSLeft.textColor=[UIColor whiteColor];
    }else if (jsplDwonTwoModel.Js_Goal2==2){
        self.labJSLeft.backgroundColor=[UIColor redColor];
        self.labJSLeft.textColor=[UIColor whiteColor];
    }
    NSString *strCP= self.labKPMid.text;
    NSArray *arrLeft = [strCP componentsSeparatedByString:@"."];
    if (arrLeft.count == 2) {
        if ([[NSString stringWithFormat:@"%@",strCP] containsString:@"-"]) {
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrLeft objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrLeft objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [strCP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labKPMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    NSString *strJP = self.labJSMid.text;
    NSArray *arrRight = [strJP componentsSeparatedByString:@"."];
    if (arrRight.count == 2) {
        if ([[NSString stringWithFormat:@"%@",strJP] containsString:@"-"]) {
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = -[strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = -[strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"-%@/%@",str1,str2];
            }
        }else{
            if ([[arrRight objectAtIndex:1] isEqualToString:@"25"]) {
                CGFloat f1 = [strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }else if ([[arrRight objectAtIndex:1] isEqualToString:@"75"]){
                CGFloat f1 = [strJP floatValue];
                NSString *str1 = [self method1:(f1 - 0.25)];
                NSString *str2 = [self method1:(f1 + 0.25)];
                self.labJSMid.text = [NSString stringWithFormat:@"%@/%@",str1,str2];
            }
        }
    }
    [self addCellAutoLayout];
}
#pragma mark - initialize -
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labLName];
        [_basicView addSubview:self.labKPLeft];
        [_basicView addSubview:self.labKPMid];
        [_basicView addSubview:self.labKPRight];
        [_basicView addSubview:self.labRname];
        [_basicView addSubview:self.labJSLeft];
        [_basicView addSubview:self.labJSMid];
        [_basicView addSubview:self.labJSRight];
    }
    return _basicView;
}
- (UILabel *)labLName {
    if (!_labLName) {
        _labLName = [UILabel new];
        _labLName.text = @"初指";
        _labLName.font = font12;
        _labLName.textAlignment = NSTextAlignmentCenter;
    }
    return _labLName;
}
- (UILabel *)labKPLeft {
    if (!_labKPLeft) {
        _labKPLeft = [UILabel new];
        _labKPLeft.text = @"0.90";
        _labKPLeft.font = font12;
        _labKPLeft.textAlignment = NSTextAlignmentCenter;
    }
    return _labKPLeft;
}
- (UILabel *)labKPMid {
    if (!_labKPMid) {
        _labKPMid = [UILabel new];
        _labKPMid.text = @"-0.50";
        _labKPMid.font = font12;
        _labKPMid.textColor = redcolor;
        _labKPMid.textAlignment = NSTextAlignmentCenter;
    }
    return _labKPMid;
}
- (UILabel *)labKPRight {
    if (!_labKPRight) {
        _labKPRight = [UILabel new];
        _labKPRight.text = @"0.90";
        _labKPRight.font = font12;
        _labKPRight.textAlignment = NSTextAlignmentCenter;
    }
    return _labKPRight;
}
- (UILabel *)labRname {
    if (!_labRname) {
        _labRname = [UILabel new];
        _labRname.text = @"即盘";
        _labRname.font = font12;
        _labRname.textAlignment = NSTextAlignmentCenter;
    }
    return _labRname;
}
- (UILabel *)labJSLeft {
    if (!_labJSLeft) {
        _labJSLeft = [UILabel new];
        _labJSLeft.text = @"0.90";
        _labJSLeft.font = font12;
        _labJSLeft.textAlignment = NSTextAlignmentCenter;
    }
    return _labJSLeft;
}
- (UILabel *)labJSMid {
    if (!_labJSMid) {
        _labJSMid = [UILabel new];
        _labJSMid.text = @"-0.5";
        _labJSMid.font = font12;
        _labJSMid.textColor = redcolor;
        _labJSMid.textAlignment = NSTextAlignmentCenter;
    }
    return _labJSMid;
}
- (UILabel *)labJSRight {
    if (!_labJSRight) {
        _labJSRight = [UILabel new];
        _labJSRight.text = @"0.90";
        _labJSRight.font = font12;
        _labJSRight.textAlignment = NSTextAlignmentCenter;
    }
    return _labJSRight;
}
#pragma mark - addCellAutoLayout -
- (void)addCellAutoLayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.labLName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(35);
    }];
    [self.labKPLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labLName);
        make.leading.mas_equalTo(self.labLName.mas_trailing);
        make.width.mas_equalTo(47.5);
    }];
    [self.labKPMid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labKPLeft);
        make.leading.mas_equalTo(self.labKPLeft.mas_trailing);
        make.width.mas_equalTo(45);
    }];
    [self.labKPRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labKPMid);
        make.leading.mas_equalTo(self.labKPMid.mas_trailing);
        make.width.mas_equalTo(47.5);
    }];
    [self.labRname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labKPRight);
        make.leading.mas_equalTo(self.labKPRight.mas_trailing);
        make.width.mas_equalTo(45);
    }];
    [self.labJSLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labRname);
        make.leading.mas_equalTo(self.labRname.mas_trailing);
        make.width.mas_equalTo(45);
    }];
    [self.labJSMid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labJSLeft);
        make.leading.mas_equalTo(self.labJSLeft.mas_trailing);
        make.width.mas_equalTo(47.5);
    }];
    [self.labJSRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labJSMid);
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

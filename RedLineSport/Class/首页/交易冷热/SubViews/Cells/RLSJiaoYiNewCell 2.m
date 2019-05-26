#import "RLSJiaoYiNewCell.h"
@interface RLSJiaoYiNewCell()
@property (nonatomic, strong)UILabel *strLab;
@property (nonatomic, strong)UILabel *homeName;
@property (nonatomic, strong)UILabel *labVS;
@property (nonatomic, strong)UILabel *labGuesName;
@property (nonatomic, strong)UIView *viewOne;
@property (nonatomic, strong)UIView *viewTwo;
@property (nonatomic, strong)UIView *viewThree;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UIView  *basView;
@end
@implementation RLSJiaoYiNewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.basView];
        [self.basView addSubview:self.strLab];
        [self.basView addSubview:self.homeName];
        [self.basView addSubview:self.labVS];
        [self.basView addSubview:self.labGuesName];
        [self.basView addSubview:self.viewOne];
        [self.basView addSubview:self.viewTwo];
        [self.basView addSubview:self.viewThree];
        [self.basView addSubview:self.lineView];
        [self setMas];
    }
    return self;
}
- (UIView *)basView{
    if (!_basView) {
        _basView = [[UIView alloc] init];
        _basView.backgroundColor = [UIColor clearColor];
    }
    return _basView;
}
- (UILabel *)strLab{
    if (!_strLab) {
        _strLab = [[UILabel alloc] init];
        _strLab.font = font12;
        _strLab.textColor = color66;
        _strLab.text = @"周四005 国王杯 04-01 23:50";
    }
    return _strLab;
}
- (UILabel *)homeName{
    if (!_homeName) {
        _homeName = [[UILabel alloc] init];
        _homeName.font = BoldFont4(fontSize16);
        _homeName.text = @"FC爱媛";
        _homeName.textColor = color33;
    }
    return _homeName;
}
- (UILabel *)labVS{
    if (!_labVS) {
        _labVS = [[UILabel alloc] init];
        _labVS.font = font14;
        _labVS.textColor = color66;
        _labVS.text = @"平局";
    }
    return _labVS;
}
- (UILabel *)labGuesName{
    if (!_labGuesName) {
        _labGuesName = [[UILabel alloc] init];
        _labGuesName.text = @"山形山神";
        _labGuesName.font = BoldFont4(fontSize16);
        _labGuesName.textColor = color33;
    }
    return _labGuesName;
}
- (UIView *)viewOne{
    if (!_viewOne) {
        _viewOne = [[UIView alloc] init];
        _viewOne.backgroundColor = [UIColor clearColor];
    }
    return _viewOne;
}
- (UIView *)viewTwo{
    if (!_viewTwo) {
        _viewTwo = [[UIView alloc] init];
        _viewTwo.backgroundColor = [UIColor clearColor];
    }
    return _viewTwo;
}
- (UIView *)viewThree{
    if (!_viewThree) {
        _viewThree = [[UIView alloc] init];
        _viewThree.backgroundColor = [UIColor clearColor];
    }
    return _viewThree;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorDD;
    }
    return _lineView;
}
- (void)createLab:(UIView *)backView dataOne:(NSString *)dataOne dataTwo:(NSString *)dataTwo dataThree:(NSString *)dataThree color:(UIColor *)colorThree{
    [backView removeAllSubViews];
    CGFloat wid = 200/3;
    UILabel *labOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, wid - 20, 10)];
    labOne.font = font11;
    labOne.textColor = color33;
    labOne.textAlignment = NSTextAlignmentCenter;
    labOne.text = dataOne;
    [backView addSubview:labOne];
    UILabel *labTwo = [[UILabel alloc] initWithFrame:CGRectMake(labOne.right,0, wid+10,10)];
    labTwo.font = font11;
    labTwo.textColor = color33;
    labTwo.textAlignment = NSTextAlignmentCenter;
    labTwo.text = dataTwo;
    [backView addSubview:labTwo];
    UILabel *labThree = [[UILabel alloc] initWithFrame:CGRectMake(labTwo.right,0, wid + 10,10)];
    labThree.font = font11;
    if (self.type ==3) {
        NSLog(@"%@",dataThree);
        labThree.text = [NSString stringWithFormat:@"%@",dataThree];
    }else if (self.type ==1){
        if ([dataThree containsString:@"-"]) {
            labThree.textColor = color33;
        }else{
            labThree.textColor = redcolor;
        }
        NSLog(@"%@",dataThree);
        labThree.text = dataThree;
    }else if (self.type ==2){
        if ([dataThree containsString:@"-"]) {
            labThree.textColor = greencolor;
        }else{
            labThree.textColor = color33;
        }
        NSLog(@"%@",dataThree);
        labThree.text = dataThree;
    }
    labThree.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:labThree];
}
- (void)setModel:(RLSJiaoYiModel *)model{
    _model = model;
    self.strLab.text = [NSString stringWithFormat:@"%@ %@ %@",model.sort,model.league,model.mtime];
    self.homeName.text = model.deal[0][@"name"];
    if (self.homeName.text.length > 4 && (isOniPhone4 || isOniPhone5)) {
        self.homeName.text = [NSString stringWithFormat:@"%@...",[self.homeName.text substringToIndex:4]];
    }else if(self.homeName.text.length > 6){
        self.homeName.text = [NSString stringWithFormat:@"%@...",[self.homeName.text substringToIndex:6]];
    }
    self.labVS.text = model.deal[1][@"name"];
    self.labGuesName.text = model.deal[2][@"name"];
    if (self.labGuesName.text.length > 4 && (isOniPhone4 || isOniPhone5)) {
        self.labGuesName.text = [NSString stringWithFormat:@"%@...",[self.labGuesName.text substringToIndex:4]];
    }else if(self.labGuesName.text.length > 6){
        self.labGuesName.text = [NSString stringWithFormat:@"%@...",[self.labGuesName.text substringToIndex:6]];
    }
    if (self.type ==3) {
        [self createLab:self.viewOne dataOne:model.deal[0][@"price"] dataTwo:model.deal[0][@"deal"] dataThree:@"" color:color33];
        [self createLab:self.viewTwo dataOne:model.deal[1][@"price"] dataTwo:model.deal[1][@"deal"] dataThree:model.deal[1][@"profit"] color:color33];
        [self createLab:self.viewThree dataOne:model.deal[2][@"price"] dataTwo:model.deal[2][@"deal"] dataThree:@"" color:color33];
    }else if(self.type == 1){
        [self createLab:self.viewOne dataOne:model.deal[0][@"price"] dataTwo:model.deal[0][@"deal"] dataThree:model.deal[0][@"profit"] color:redcolor];
        [self createLab:self.viewTwo dataOne:model.deal[1][@"price"] dataTwo:model.deal[1][@"deal"] dataThree:model.deal[1][@"profit"] color:redcolor];
        [self createLab:self.viewThree dataOne:model.deal[2][@"price"] dataTwo:model.deal[2][@"deal"] dataThree:model.deal[2][@"profit"] color:redcolor];
    }else{
        [self createLab:self.viewOne dataOne:model.deal[0][@"price"] dataTwo:model.deal[0][@"deal"] dataThree:model.deal[0][@"profit"] color:greencolor];
        [self createLab:self.viewTwo dataOne:model.deal[1][@"price"] dataTwo:model.deal[1][@"deal"] dataThree:model.deal[1][@"profit"] color:greencolor];
        [self createLab:self.viewThree dataOne:model.deal[2][@"price"] dataTwo:model.deal[2][@"deal"] dataThree:model.deal[2][@"profit"] color:greencolor];
    }
}
- (void)setMas{
    [self.basView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self.strLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.basView.mas_left).offset(15);
        make.top.mas_equalTo(self.basView.mas_top).offset(15);
    }];
    [self.homeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.strLab.mas_left);
        make.top.mas_equalTo(self.strLab.mas_bottom).offset(12.5);
    }];
    [self.labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.strLab.mas_left);
        make.top.mas_equalTo(self.homeName.mas_bottom).offset(5.5);
    }];
    [self.labGuesName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.strLab.mas_left);
        make.top.mas_equalTo(self.labVS.mas_bottom).offset(5.5);
    }];
    [self.viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.homeName.mas_centerY);
        make.right.mas_equalTo(self.basView.mas_right).offset(-15);
        make.width.mas_offset(200);
        make.height.mas_offset(10);
    }];
    [self.viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labVS.mas_centerY);
        make.right.mas_equalTo(self.basView.mas_right).offset(-15);
        make.width.mas_offset(200);
        make.height.mas_offset(10);
    }];
    [self.viewThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.labGuesName.mas_centerY);
        make.right.mas_equalTo(self.basView.mas_right).offset(-15);
        make.width.mas_offset(200);
        make.height.mas_offset(10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.basView.mas_right);
        make.left.mas_equalTo(self.basView.mas_left);
        make.bottom.mas_equalTo(self.basView.mas_bottom);
        make.height.mas_offset(0.5);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end

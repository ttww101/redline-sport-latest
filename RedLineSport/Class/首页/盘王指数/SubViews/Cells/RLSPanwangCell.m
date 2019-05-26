#import "RLSPanwangCell.h"
@interface RLSPanwangCell()
@property (nonatomic, strong)UIView *basView;
@property (nonatomic, strong)UILabel *labNum;
@property (nonatomic, strong)UILabel *labName;
@property (nonatomic, strong)UILabel *labLeague;
@property (nonatomic, strong)UIView *lineView;
@end
@implementation RLSPanwangCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.basView];
        [self.basView addSubview:self.labNum];
        [self.basView addSubview:self.labName];
        [self.basView addSubview:self.labLeague];
        [self.basView addSubview:self.labGaiLv];
        [self.basView addSubview:self.labGaiLvTitle];
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
- (UILabel *)labNum{
    if (!_labNum) {
        _labNum = [[UILabel alloc] init];
        _labNum.textColor = color33;
        _labNum.text = @"1";
        _labNum.font = BoldFont4(fontSize14);
        _labNum.textAlignment = NSTextAlignmentCenter;
    }
    return _labNum;
}
- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] init];
        _labName.font = BoldFont4(fontSize16);
        _labName.textColor = color33;
        _labName.text = @"新英格兰戈";
    }
    return _labName;
}
- (UILabel *)labLeague{
    if (!_labLeague) {
        _labLeague = [[UILabel alloc] init];
        _labLeague.font = font14;
        _labLeague.textColor = color33;
        _labLeague.text = @"国王杯";
        _labLeague.textAlignment = NSTextAlignmentCenter;
    }
    return _labLeague;
}
- (UILabel *)labGaiLv{
    if (!_labGaiLv) {
        _labGaiLv = [[UILabel alloc] init];
        _labGaiLv.font = font14;
        _labGaiLv.textColor = color33;
        _labGaiLv.text = @"93.4%";
        _labGaiLv.textAlignment = NSTextAlignmentCenter;
    }
    return _labGaiLv;
}
- (UILabel *)labGaiLvTitle{
    if (!_labGaiLvTitle) {
        _labGaiLvTitle = [[UILabel alloc] init];
        _labGaiLvTitle.font = font12;
        _labGaiLvTitle.textColor = color33;
        _labGaiLvTitle.text = @"93.4%";
        _labGaiLvTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labGaiLvTitle;
}
- (UIView *)lineView{
    if (!_lineView ) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = colorDD;
    }
    return _lineView;
}
- (void)setModel:(RLSPanWangModel *)model{
    _model = model;
    self.labNum.text = [NSString stringWithFormat:@"%ld",self.rankNum];
    self.labName.text = model.teamname;
    if (self.labName.text.length > 7 && (isOniphone7 || isOniphone6)) {
        self.labName.text = [NSString stringWithFormat:@"%@...",[self.labName.text substringToIndex:7]];
    }else if (self.labName.text.length > 5 && (isOniPhone4 || isOniPhone5)){
        self.labName.text = [NSString stringWithFormat:@"%@...",[self.labName.text substringToIndex:5]];
    }
    self.labLeague.text = model.league;
    self.labGaiLv.text = model.wwresult;
}
- (void)setMas{
    [self.basView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(self.contentView.mas_top);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    [self.labNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.basView.mas_left);
        make.centerY.mas_equalTo(self.basView.mas_centerY);
        make.width.mas_offset(60);
    }];
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labNum.mas_right);
        make.centerY.mas_equalTo(self.labNum.mas_centerY);
    }];
    [self.labGaiLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.basView.mas_right).offset(-15);
        make.top.mas_equalTo(self.basView.mas_top).offset(11.5);
        make.width.mas_offset(50);
    }];
    [self.labGaiLvTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.labGaiLv.mas_bottom).offset(3.5);
        make.centerX.mas_equalTo(self.labGaiLv.mas_centerX);
    }];
    [self.labLeague mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.labGaiLv.mas_left);
        make.centerY.mas_equalTo(self.basView.mas_centerY);
        make.width.mas_offset(80);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.basView.mas_bottom);
        make.right.mas_equalTo(self.basView.mas_right);
        make.left.mas_equalTo(self.basView.mas_left);
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

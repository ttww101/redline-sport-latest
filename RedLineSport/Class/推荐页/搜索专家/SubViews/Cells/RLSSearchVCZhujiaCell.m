#import "RLSSearchVCZhujiaCell.h"
@interface RLSSearchVCZhujiaCell()
@property (assign, nonatomic)  BOOL isaddlaout;
@property (strong, nonatomic)  UIButton *btnPhoto;
@property (strong, nonatomic)  UIButton *labName;
@property (strong, nonatomic)  UILabel *labJiBie;
@property (strong, nonatomic)  UILabel *labLianHong;
@property (strong, nonatomic)  UILabel *labLianHongNum;
@property (nonatomic, strong) UIView *basicView;
@end
@implementation RLSSearchVCZhujiaCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.labJiBie.textColor = BalckColor1;
    self.labLianHong.backgroundColor = redcolor;
    self.labLianHongNum.textColor = color66;
    self.labLianHong.textColor = [UIColor whiteColor];
}
- (void)setModel:(RLSUserlistModel *)model
{
    [self.contentView addSubview:self.basicView];
    _model = model;
    [self.labName setTitleColor:color33 forState:UIControlStateNormal];
    self.labName.titleLabel.font = font16;
    _viewBottom.backgroundColor = colorCellLine;
    self.btnPhoto.layer.cornerRadius = 25;
    self.btnPhoto.layer.masksToBounds = YES;
    self.btnPhoto.userInteractionEnabled = NO;
    self.labName.userInteractionEnabled = NO;
    [_btnPhoto sd_setBackgroundImageWithURL:[NSURL URLWithString:_model.pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    [_labName setTitle:_model.nickname forState:UIControlStateNormal];
    if (!_isaddlaout) {
        _isaddlaout = YES;
        [self addlayout];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
    }
    return _basicView;
}
- (UIButton *)btnPhoto
{
    if (!_btnPhoto) {
        _btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btnPhoto;
}
- (UIButton *)labName
{
    if (!_labName) {
        _labName = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _labName;
}
- (UIView *)viewBottom
{
    if (!_viewBottom) {
        _viewBottom = [[UIView alloc] init];
    }
    return _viewBottom;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.btnPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnPhoto.mas_right).offset(10);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(Width -15);
    }];
}
@end

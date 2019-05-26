#import "RLSUserViewofMyBuyTuijian.h"
@interface RLSUserViewofMyBuyTuijian()
@property (nonatomic, assign) BOOL isAddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIImageView *imagePic;
@property (nonatomic, strong) UILabel *labName;
@property (nonatomic, strong) UILabel *labStateTitle;
@property (nonatomic, strong) UILabel *labState;
@property (nonatomic, strong) UIView *viewLine;
@end
@implementation RLSUserViewofMyBuyTuijian
- (void)setModel:(RLSTuijiandatingModel *)model
{
    _model = model;
    [self addSubview:self.basicView];
    if (!_isAddlayout) {
        _isAddlayout = YES;
        [self addLayout];
    }
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    _labName.text = _model.nickname;
        _labStateTitle.text = @"状态:";
        _labState.text = _model.paystatus;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.imagePic];
        [_basicView addSubview:self.labName];
        [_basicView addSubview:self.labStateTitle];
        [_basicView addSubview:self.labState];
        [_basicView addSubview:self.viewLine];
    }
    return _basicView;
}
- (UIImageView *)imagePic
{
    if (!_imagePic) {
        _imagePic = [[UIImageView alloc] init];
        _imagePic.layer.cornerRadius = 21/2;
        _imagePic.layer.masksToBounds = YES;
    }
    return _imagePic;
}
- (UILabel *)labName
{
    if (!_labName) {
        _labName = [[UILabel alloc] init];
        _labName.font = font13;
        _labName.textColor = color33;
    }
    return _labName;
}
- (UILabel *)labStateTitle
{
    if (!_labStateTitle) {
        _labStateTitle = [[UILabel alloc] init];
        _labStateTitle.font = font13;
        _labStateTitle.textColor = color99;
    }
    return _labStateTitle;
}
- (UILabel *)labState
{
    if (!_labState) {
        _labState = [[UILabel alloc] init];
        _labState.font = font13;
        _labState.textColor = color99;
    }
    return _labState;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorCellLine;
    }
    return _viewLine;
}
- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.imagePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.centerY.equalTo(self.basicView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagePic.mas_right).offset(10);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.basicView.mas_right).offset(-15);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.labStateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.labState.mas_left).offset(-5);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];
}
@end

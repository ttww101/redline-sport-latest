#import "RLSFenXiHeaderBottomView.h"
@interface RLSFenXiHeaderBottomView()
@property (nonatomic, strong) UIView                *basicView;
@property (nonatomic, strong) UIImageView           *iconTQ;
@property (nonatomic, strong) UILabel               *labTQ;
@property (nonatomic, strong) UILabel               *labTQNum;
@property (nonatomic, strong) UILabel               *labPlace;
@property (nonatomic, strong) UILabel               *labAdress;
@end
@implementation RLSFenXiHeaderBottomView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.basicView];
    }
    return self;
}
- (void)setModel:(RLSLiveScoreModel *)model {
    _model = model;
    [self addSubview:self.basicView];
    [self.basicView addSubview:self.iconTQ];
    [self.basicView addSubview:self.labTQ];
    [self.basicView addSubview:self.labTQNum];
    [self.basicView addSubview:self.labPlace];
    [self.basicView addSubview:self.labAdress];
    [self addAutolayout];
}
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
    }
    return _basicView;
}
- (UIImageView *)iconTQ {
    if (!_iconTQ) {
        _iconTQ = [UIImageView new];
        _iconTQ.image = [UIImage imageNamed:@""];
    }
    return  _iconTQ;
}
- (UILabel *)labTQ {
    if (!_labTQ) {
        _labTQ = [UILabel new];
        _labTQ.text = @"雪天";
        _labTQ.font = font14;
        _labTQ.textColor = [UIColor whiteColor];
    }
    return _labTQ;
}
- (UILabel *)labTQNum {
    if (!_labTQNum) {
        _labTQNum = [UILabel new];
        _labTQNum.text = @"30°C ~ 36°C";
        _labTQNum.font = font14;
        _labTQNum.textColor = [UIColor whiteColor];
    }
    return _labTQNum;
}
- (UILabel *)labPlace {
    if (!_labPlace) {
        _labPlace = [UILabel new];
        _labPlace.text = @"地点";
        _labPlace.font = font14;
        _labPlace.textColor = [UIColor whiteColor];
    }
    return _labPlace;
}
- (UILabel *)labAdress {
    if (!_labAdress) {
        _labAdress = [UILabel new];
        _labAdress.text = @"上海体育馆";
        _labAdress.font = font14;
        _labAdress.textColor = [UIColor whiteColor];
    }
    return _labAdress;
}
- (void)addAutolayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.iconTQ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.leading.equalTo(self).mas_offset(16);
        make.size.mas_equalTo(CGSizeMake(16*2, 17*2));
    }];
    [self.labTQNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconTQ);
        make.leading.equalTo(self.iconTQ);
        make.height.equalTo(self.iconTQ);
        make.width.mas_equalTo(40);
    }];
    [self.labAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self).mas_offset(-16);
        make.height.equalTo(self.iconTQ);
        make.width.mas_equalTo(40);
    }];
    [self.labPlace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.trailing.equalTo(self.labAdress);
        make.height.equalTo(self.iconTQ);
        make.width.mas_equalTo(100);
    }];
}
@end

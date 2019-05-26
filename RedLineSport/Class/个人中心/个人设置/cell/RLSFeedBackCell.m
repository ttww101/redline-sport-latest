#import "RLSFeedBackCell.h"
@interface RLSFeedBackCell ()
@property (nonatomic, strong) UIView            *basicView;
@property (nonatomic, strong) UILabel           *labTime;
@property (nonatomic, strong) UILabel           *labDetail;
@property (nonatomic, strong) UILabel           *labReCall;
@property (nonatomic, strong) UILabel           *labReCallDetail;
@end
@implementation RLSFeedBackCell
- (void)setFeedModeltmp:(RLSFeedBackModel *)feedModeltmp {
    _feedModeltmp = feedModeltmp;
    [self.contentView addSubview:self.basicView];
    self.labTime.text = feedModeltmp.time;
    self.labDetail.text = feedModeltmp.content;
    if (isNUll(feedModeltmp.reply)) {
        self.labReCallDetail.text = @"暂无";
    }else{
        self.labReCallDetail.text = feedModeltmp.reply;
    }
    [self addCellAutoLayout];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
#pragma mark - initialize -
- (UIView *)basicView {
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labDetail];
        [_basicView addSubview:self.labReCall];
        [_basicView addSubview:self.labReCallDetail];
    }
    return _basicView;
}
- (UILabel *)labTime {
    if (!_labTime) {
        _labTime = [UILabel new];
        _labTime.font = font12;
        _labTime.textColor = colorf66666;
        _labTime.textAlignment = NSTextAlignmentLeft;
    }
    return _labTime;
}
- (UILabel *)labDetail {
    if (!_labDetail) {
        _labDetail = [UILabel new];
        _labDetail.font = font12;
        _labDetail.textColor = colorf66666;
        _labDetail.numberOfLines = 0;
        _labDetail.textAlignment = NSTextAlignmentLeft;
    }
    return _labDetail;
}
- (UILabel *)labReCall {
    if (!_labReCall) {
        _labReCall = [UILabel new];
        _labReCall.text = @"回复: ";
        _labReCall.font = font12;
        _labReCall.textColor = colorf66666;
        _labReCall.textAlignment = NSTextAlignmentLeft;
    }
    return _labReCall;
}
- (UILabel *)labReCallDetail {
    if (!_labReCallDetail) {
        _labReCallDetail = [UILabel new];
        _labReCallDetail.font = font12;
        _labReCallDetail.textColor = colorf66666;
        _labReCallDetail.numberOfLines = 0;
        _labReCallDetail.textAlignment = NSTextAlignmentLeft;
    }
    return _labReCallDetail;
}
#pragma mark - addCellAutoLayout -
- (void)addCellAutoLayout {
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView).offset(20);
        make.leading.equalTo(self.basicView).offset(15);
    }];
    [self.labDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTime.mas_top);
        make.leading.equalTo(self.labTime.mas_trailing).offset(10);
        make.trailing.mas_lessThanOrEqualTo(self.mas_trailing).offset(-15);
    }];
    [self.labReCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labDetail.mas_bottom).offset(16);
        make.leading.equalTo(self.labTime.mas_leading);
    }];
    [self.labReCallDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labReCall);
        make.leading.equalTo(self.labReCall.mas_trailing).offset(10);
        make.trailing.mas_lessThanOrEqualTo(self.mas_trailing).offset(-15);
    }];
}
@end

#import "RLSLiveListTableViewCell.h"
@interface RLSLiveListTableViewCell ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *verticalLineView;
@property (nonatomic, strong) UILabel *metchTypeName;
@property (nonatomic, strong) UIImageView *homeTermIcon;
@property (nonatomic, strong) UILabel *homeTermLabel;
@property (nonatomic, strong)  UIImageView *VisitingTermIcon;
@property (nonatomic, strong) UILabel *VisitingTermLabel;
@property (nonatomic, strong) UILabel *matchTimeLabel;
@property (nonatomic, strong) UIImageView *liveImageView;
@end
@implementation RLSLiveListTableViewCell
static CGFloat cell_Height = 100.f;
static NSString *identifier = @"listCell";
static CGFloat imageHeight = 20;
+ (RLSLiveListTableViewCell *)cellForTableView:(UITableView *)tableView {
    RLSLiveListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[RLSLiveListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
+ (CGFloat)heightForCell {
    return cell_Height;
}
- (void)refreshContentData:(RLSLiveListModel *)model {
    self.matchTimeLabel.text = [RLSMethods formatHHSSStamp:model.startTime];
    self.homeTermLabel.text = model.home;
    self.VisitingTermLabel.text = model.away;
    self.metchTypeName.text = model.event;
    self.lineView.hidden = model.hideBottormLine;
    [self.homeTermIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://ls.sportradar.com/ls/crest/small/%@.png",model.homeUid]] placeholderImage:[RLSMethods defaultPlaceHolderImage:@"default_home_icon"]];
    [self.VisitingTermIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://ls.sportradar.com/ls/crest/small/%@.png",model.awayUid]] placeholderImage:[RLSMethods defaultPlaceHolderImage:@"default_home_icon"]];
    self.liveImageView.image = [UIImage imageNamed:[self getMatchStatusImageName:model.statusId]];
}
#pragma mark - Config UI
- (void)configUI {
    self.contentView.backgroundColor = UIColorFromRGBWithOX(0xffffff);
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.left.equalTo(self.contentView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.5));
    }];
    [self.contentView addSubview:self.metchTypeName];
    [self.metchTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    [self.contentView addSubview:self.matchTimeLabel];
    [self.matchTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
        make.left.equalTo(self.contentView.mas_left).offset(20);
    }];
    [self.contentView addSubview:self.verticalLineView];
    [self.verticalLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(40);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(1);
        make.left.equalTo(self.matchTimeLabel.mas_right).offset(20);
    }];
    [self.contentView addSubview:self.homeTermIcon];
    [self.homeTermIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalLineView.mas_right).offset(20);
        make.top.equalTo(self.verticalLineView.mas_top);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    [self.contentView addSubview:self.homeTermLabel];
    [self.homeTermLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.homeTermIcon.mas_centerY);
        make.left.equalTo(self.homeTermIcon.mas_right).offset(10);
    }];
    [self.contentView addSubview:self.VisitingTermIcon];
    [self.VisitingTermIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.homeTermIcon.mas_left);
        make.bottom.equalTo(self.verticalLineView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(imageHeight, imageHeight));
    }];
    [self.contentView addSubview:self.VisitingTermLabel];
    [self.VisitingTermLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.VisitingTermIcon.mas_centerY);
        make.left.equalTo(self.VisitingTermIcon.mas_right).offset(10);
    }];
    [self.contentView addSubview:self.liveImageView];
    [self.liveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
}
#pragma mark - Private Method
- (NSString *)getMatchStatusImageName:(NSString *)matchStatus {
    if (matchStatus) {
        if ([matchStatus isEqualToString:@"-10"]) {
            return @"nolive";
        } else if ([matchStatus isEqualToString:@"-1"]) {
            return @"nolive";
        } else if ([matchStatus isEqualToString:@"-14"]) {
            return @"nolive";
        } else if ([matchStatus isEqualToString:@"-13"]) {
            return @"nolive";
        } else if ([matchStatus isEqualToString:@"-12"]) {
            return @"nolive";
        } else if ([matchStatus isEqualToString:@"0"]) {
            return @"nolive";
        } else {
            return @"live";
        }
    } else {
        return @"nolive";
    }
    return @"nolive";
}
#pragma mark - Lazy Load
- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _lineView;
}
- (UIView *)verticalLineView {
    if (_verticalLineView == nil) {
        _verticalLineView = [UIView new];
        _verticalLineView.backgroundColor = UIColorFromRGBWithOX(0xe2e2e2);
    }
    return _verticalLineView;
}
- (UILabel *)metchTypeName {
    if (_metchTypeName == nil) {
        _metchTypeName = [UILabel new];
        _metchTypeName.text = @"西甲第27轮";
        _metchTypeName.font = [UIFont systemFontOfSize:14.f];
        _metchTypeName.textAlignment = NSTextAlignmentCenter;
        _metchTypeName.textColor = UIColorFromRGBWithOX(0xb2b2b2);
    }
    return _metchTypeName;
}
- (UILabel *)homeTermLabel {
    if (_homeTermLabel == nil) {
        _homeTermLabel = [UILabel new];
        _homeTermLabel.text = @"皇家马德里";
        _homeTermLabel.font = [UIFont systemFontOfSize:14.f];
        _homeTermLabel.textAlignment = NSTextAlignmentCenter;
        _homeTermLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    }
    return _homeTermLabel;
}
- (UILabel *)matchTimeLabel {
    if (_matchTimeLabel == nil) {
        _matchTimeLabel = [UILabel new];
        _matchTimeLabel.text = @"04:00";
        _matchTimeLabel.font = [UIFont systemFontOfSize:14.f];
        _matchTimeLabel.textAlignment = NSTextAlignmentCenter;
        _matchTimeLabel.textColor = UIColorFromRGBWithOX(0x090909);
    }
    return _matchTimeLabel;
}
- (UIImageView *)homeTermIcon {
    if (_homeTermIcon == nil) {
        _homeTermIcon = [UIImageView new];
        _homeTermIcon.image = [UIImage imageNamed:@"match_header_homeicon"];
        _homeTermIcon.layer.cornerRadius = imageHeight / 2.f;
        _homeTermIcon.layer.masksToBounds = YES;
        _homeTermIcon.contentMode = UIViewContentModeScaleAspectFill;
        _homeTermIcon.backgroundColor = [UIColor orangeColor];
    }
    return _homeTermIcon;
}
- (UIImageView *)VisitingTermIcon {
    if (_VisitingTermIcon == nil) {
        _VisitingTermIcon = [UIImageView new];
        _VisitingTermIcon.image = [UIImage imageNamed:@"match_header_visitingicon"];
        _VisitingTermIcon.layer.cornerRadius = imageHeight / 2.f;
        _VisitingTermIcon.layer.masksToBounds = YES;
        _VisitingTermIcon.contentMode = UIViewContentModeScaleAspectFill;
        _VisitingTermIcon.backgroundColor = [UIColor orangeColor];
    }
    return _VisitingTermIcon;
}
- (UILabel *)VisitingTermLabel {
    if (_VisitingTermLabel == nil) {
        _VisitingTermLabel = [UILabel new];
        _VisitingTermLabel.text = @"巴塞罗那";
        _VisitingTermLabel.font = [UIFont systemFontOfSize:14.f];
        _VisitingTermLabel.textAlignment = NSTextAlignmentCenter;
        _VisitingTermLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    }
    return _VisitingTermLabel;
}
- (UIImageView *)liveImageView {
    if (_liveImageView == nil) {
        _liveImageView = [UIImageView new];
        _liveImageView.layer.masksToBounds = YES;
        _liveImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _liveImageView;
}
@end

//
//  ForumContentHeader.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ForumContentHeader.h"
#import "RLSToolWebViewController.h"


@interface ForumContentHeader () 

@property (nonatomic, strong) BaseImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *dateLabel;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *messageLabel;
@property (nonatomic, strong) PicView *picView;
@property (nonatomic, strong) UIImageView *seeImageView;
@property (nonatomic, strong) UILabel *seeCount;
@property (nonatomic, strong) UILabel *comments;
@property (nonatomic, strong) UILabel *commentsCount;
@property (nonatomic, strong) UILabel *bestLab;

@end

CGFloat imageWidth = 40;
CGFloat space = 10;

@implementation ForumContentHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return  self;
}

#pragma mark - Opend Method

- (void)setInfoModel:(HeaderInfoModel *)infoModel {
    _infoModel = infoModel;
    [self.avatarImageView setImageWithAvatarUrl:[NSURL URLWithString:infoModel.avaterUrl] placeholder:[UIImage imageNamed:@"defaultPic1"]];
    self.dateLabel.text = infoModel.dateStr;
    self.nameLabel.text = infoModel.nickname;
    self.titleLabel.text = infoModel.title;
    self.messageLabel.attributedText = infoModel.messageAtt;
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 30, infoModel.messageAttHeight));
    }];
    self.picView.dataSource = _infoModel.images;
    [self.picView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width - 30, infoModel.picLayout.height));
    }];
    self.commentsCount.text = infoModel.commentCount;
    self.seeCount.text = infoModel.viewCount;
    if ([infoModel.cream integerValue] == 1) {
        self.bestLab.hidden = false;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bestLab.mas_right).offset(5);
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(self.avatarImageView.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(Width - 30, 20));
        }];
        
    } else {
        self.bestLab.hidden = true;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_left);
            make.top.equalTo(self.avatarImageView.mas_bottom).offset(space);
            make.size.mas_equalTo(CGSizeMake(Width - 30, 20));
            make.right.equalTo(self.mas_right).offset(-15);
        }];
    }
}

#pragma mark - Config UI

- (void)configUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageWidth));
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self.avatarImageView.mas_right).offset(10);
    }];
    
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.avatarImageView.mas_bottom);
    }];
    
    [self addSubview:self.bestLab];
    [self.bestLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(space + 2);
        make.size.mas_equalTo(CGSizeMake(25, 15));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bestLab.mas_right).offset(5);
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(space);
        make.size.mas_equalTo(CGSizeMake(Width - 30, 20));
    }];
    
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImageView.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(space);
        make.size.mas_equalTo(CGSizeMake(Width - 30, 50));
    }];

    [self addSubview:self.picView];
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageLabel.mas_bottom).offset(space);
        make.left.equalTo(self.messageLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width - 30, 0));
    }];
    
    [self addSubview:self.seeImageView];
    [self.seeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.picView.mas_bottom).offset(space);
        make.left.equalTo(self.avatarImageView.mas_left);
        make.size.mas_equalTo(CGSizeMake(14, 8));
    }];
    
    [self addSubview:self.seeCount];
    [self.seeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seeImageView.mas_centerY);
        make.left.equalTo(self.seeImageView.mas_right).offset(3);
    }];
    
    [self addSubview:self.comments];
    [self.comments mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seeImageView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self addSubview:self.commentsCount];
    [self.commentsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.seeImageView.mas_centerY);
        make.right.equalTo(self.comments.mas_left).offset(-3);
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didAction)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = true;
}

#pragma mark - Events

- (void)didAction {
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = self.infoModel.navTitle;
    model.webUrl = [NSString stringWithFormat:@"%@/%@/board-show.html?id=%@", APPDELEGATE.url_ip,H5_Host,self.infoModel.postId];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (void)avatarClick {
    RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
    userVC.userId = [self.infoModel.userId integerValue];
    userVC.hidesBottomBarWhenPushed = YES;
    userVC.Number=1;
    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
}

#pragma mark - Lazy Load

- (BaseImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [BaseImageView new];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)]];
        _avatarImageView.userInteractionEnabled = YES;
        _avatarImageView.layer.cornerRadius = imageWidth / 2;
        _avatarImageView.layer.masksToBounds = true;
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _avatarImageView;
}
- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];;
        _nameLabel.textColor = UIColorFromRGBWithOX(0xFC3224);
        _nameLabel.text = @"你的名字";
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}
- (UILabel *)dateLabel {
    if (_dateLabel == nil) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:12.f];;
        _dateLabel.textColor = UIColorFromRGBWithOX(0x979696);
    }
    return _dateLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16.f];;
        _titleLabel.textColor = UIColorFromRGBWithOX(0x292929);
        _titleLabel.numberOfLines = 1;
    }
    return _titleLabel;
}

- (UILabel *)bestLab {
    if (_bestLab == nil) {
        _bestLab = [UILabel new];
        _bestLab.font = [UIFont systemFontOfSize:8.f];;
        _bestLab.textColor = UIColorFromRGBWithOX(0xF34719);
        _bestLab.backgroundColor = [UIColor whiteColor];
        _bestLab.layer.borderColor = UIColorHex(#F34719).CGColor;
        _bestLab.layer.borderWidth = 1;
        _bestLab.layer.masksToBounds = true;
        _bestLab.layer.cornerRadius = 2;
        _bestLab.textAlignment = NSTextAlignmentCenter;
        _bestLab.text = @"精华";
    }
    return _bestLab;
}

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont systemFontOfSize:14.f];;
        _messageLabel.textColor = UIColorFromRGBWithOX(0x828282);
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _messageLabel.numberOfLines = 2;;
    }
    return _messageLabel;
}

- (PicView *)picView {
    if (_picView == nil) {
        _picView = [[PicView alloc]init];
    }
    return _picView;
}

- (UIImageView *)seeImageView {
    if (_seeImageView == nil) {
        _seeImageView = [UIImageView new];
        _seeImageView.image = [UIImage imageNamed:@"recommend_eye"];
        _seeImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _seeImageView;
}

- (UILabel *)seeCount {
    if (_seeCount == nil) {
        _seeCount = [UILabel new];
        _seeCount.font = [UIFont systemFontOfSize:10.f];;
        _seeCount.textColor = UIColorFromRGBWithOX(0x999999);
    }
    return _seeCount;
}

- (UILabel *)comments {
    if (_comments == nil) {
        _comments = [UILabel new];
        _comments.font = [UIFont systemFontOfSize:10.f];;
        _comments.textColor = UIColorFromRGBWithOX(0x999999);
        _comments.text = @"评论";
    }
    return _comments;
}

- (UILabel *)commentsCount {
    if (_commentsCount == nil) {
        _commentsCount = [UILabel new];
        _commentsCount.font = [UIFont systemFontOfSize:10.f];;
        _commentsCount.textColor = UIColorFromRGBWithOX(0xDB2D21);
    }
    return _commentsCount;
}


@end

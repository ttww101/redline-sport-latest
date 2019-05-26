//
//  CommentCell.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/20.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) BaseImageView *avatarImageView;
@property (nonatomic, strong) BaseImageView *flagImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *dateLabel;
@property (nonatomic , strong) UILabel *contentLabel;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

#pragma mark - Open Method

- (void)setModel:(CommentModel *)model {
    _model = model;
    self.nameLabel.text = model.nickname;
    self.dateLabel.text = model.dateStr;
    [self.avatarImageView setImageWithAvatarUrl:[NSURL URLWithString:model.avaterUrl] placeholder:[UIImage imageNamed:@"defaultPic1"]];
    self.contentLabel.text = model.content;
}

#pragma mark - Config UI

- (void)configUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    [self.bgView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(5);
        make.top.equalTo(self.bgView).offset(5);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self.bgView addSubview:self.flagImageView];
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(0);
        make.top.equalTo(self.bgView).offset(0);
        make.size.mas_equalTo(CGSizeMake(32, 34));
    }];
    
    [self.bgView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_top);
        make.left.equalTo(self.avatarImageView.mas_right).offset(5);
    }];
    
    [self.bgView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarImageView.mas_bottom);
        make.left.equalTo(self.nameLabel.mas_left);
    }];
    
    [self.bgView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImageView.mas_bottom).offset(10);
        make.left.equalTo(self.bgView.mas_left).offset(5);
        make.right.equalTo(self.bgView.mas_right);
        make.bottom.equalTo(self.bgView.mas_bottom);
    }];

}

#pragma mark - Lazy Load

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = UIColorHex(#F7F7F7);
    }
    return _bgView;
}

- (BaseImageView *)avatarImageView {
    if (_avatarImageView == nil) {
        _avatarImageView = [BaseImageView new];
//        _avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_avatarImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)]];
        _avatarImageView.userInteractionEnabled = YES;
    }
    return _avatarImageView;
}

- (BaseImageView *)flagImageView {
    if (_flagImageView == nil) {
        _flagImageView = [BaseImageView new];
        _flagImageView.contentMode = UIViewContentModeScaleAspectFit;
        _flagImageView.image = [UIImage imageNamed:@"goodreply"];
    }
    return _flagImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:10.f];;
        _nameLabel.textColor = UIColorFromRGBWithOX(0x292929);
        _nameLabel.text = @"你的名字";
        _nameLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _nameLabel;
}
- (UILabel *)dateLabel {
    if (_dateLabel == nil) {
        _dateLabel = [UILabel new];
        _dateLabel.font = [UIFont systemFontOfSize:9.f];;
        _dateLabel.textColor = UIColorFromRGBWithOX(0x979696);
    }
    return _dateLabel;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:12.f];;
        _contentLabel.textColor = UIColorFromRGBWithOX(0x828282);
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

@end

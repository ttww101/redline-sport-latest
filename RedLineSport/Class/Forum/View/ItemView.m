//
//  ItemView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/22.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "ItemView.h"
#import "RLSToolWebViewController.h"

@interface ItemView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic , strong) UILabel *circleLab;
@property (nonatomic , strong) UIControl *actionControl;

@end

@implementation ItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)setModel:(HeaderInfoModel *)model {
    _model = model;
    [model setupInfo];
    self.titleLabel.text = _model.title;
    self.messageLabel.text = model.content;
}

#pragma mark - Config UI

- (void)configUI {
    [self addSubview:self.lineView];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.circleLab];
    [self.circleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.circleLab.mas_right).offset(5);
        make.centerY.equalTo(self.circleLab.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.actionControl];
    [self.actionControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Events

- (void)detailAction {
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = self.model.navTitle;
    model.webUrl = [NSString stringWithFormat:@"%@/%@/board-show.html?id=%@", APPDELEGATE.url_ip,H5_Host,self.model.postId];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

#pragma mark - Lazy Load

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - ONE_PX_LINE, self.width, ONE_PX_LINE)];
        _lineView.backgroundColor = UIColorHex(#eeeeee);
        
    }
    return _lineView;
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

- (UILabel *)messageLabel {
    if (_messageLabel == nil) {
        _messageLabel = [UILabel new];
        _messageLabel.font = [UIFont systemFontOfSize:14.f];;
        _messageLabel.textColor = UIColorFromRGBWithOX(0x828282);
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _messageLabel.numberOfLines = 1;;
    }
    return _messageLabel;
}

- (UILabel *)circleLab {
    if (_circleLab == nil) {
        _circleLab = [UILabel new];
        _circleLab.backgroundColor = UIColorFromRGBWithOX(0xFC3224);
        _circleLab.layer.cornerRadius = 5/2.0;
        _circleLab.layer.masksToBounds = true;
    }
    return _circleLab;
}

- (UIControl *)actionControl {
    if (_actionControl == nil) {
        _actionControl = [[UIControl alloc]init];
        [_actionControl addTarget:self action:@selector(detailAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionControl;
}

@end

#import "RLSCommentsView.h"
@interface RLSCommentsView ()
@property (nonatomic , strong) UIButton *replyBtn;
@property (nonatomic , strong) UIButton *shareBtn;
@property (nonatomic , strong) UIButton *commentBtn;
@property (nonatomic, strong) UILabel *badgeNumberLabel;
@end
@implementation RLSCommentsView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, Height - 45, Width, 45)]) {
        [self configUI];
    }
    return self;
}
#pragma mark - Open Method
- (void)loadData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:PARAM_IS_NIL_ERROR(_newsID) forKey:@"newsid"];
    [parameter setValue:PARAM_IS_NIL_ERROR(_module) forKey:@"module"];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,info_url_commentcount] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            NSInteger count = [responseOrignal[@"data"] integerValue];
            self.badgeNumberLabel.text = [NSString stringWithFormat:@"%zi",count];
        } else {
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
#pragma mark - Config UI
- (void)configUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.replyBtn];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-40);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self addSubview:self.commentBtn];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shareBtn.mas_left).offset(-30);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.commentBtn addSubview:self.badgeNumberLabel];
    [self.badgeNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.commentBtn.mas_right).offset(2);
        make.top.equalTo(self.commentBtn.mas_top).offset(-4);
    }];
}
#pragma mark - Events
- (void)replyAction {
    if (_delegate && [_delegate respondsToSelector:@selector(commentViewDidSelectReply:)]) {
        [_delegate commentViewDidSelectReply:self];
    }
}
- (void)inputShareAction {
    if (_delegate && [_delegate respondsToSelector:@selector(commentViewDidSelectShare:)]) {
        [_delegate commentViewDidSelectShare:self];
    }
}
- (void)inputCommentAction {
    if (_delegate && [_delegate respondsToSelector:@selector(commentViewDidSelectCommnetList:)]) {
        [_delegate commentViewDidSelectCommnetList:self];
    }
}
#pragma mark - Lazy Load
- (UIButton *)replyBtn {
    if (_replyBtn == nil) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setBackgroundImage:[UIImage imageNamed:@"inputreplys"] forState:UIControlStateNormal];
        [_replyBtn addTarget:self action:@selector(replyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}
- (UIButton *)shareBtn {
    if (_shareBtn == nil) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"inputshare"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(inputShareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
- (UIButton *)commentBtn {
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"inputcomment"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(inputCommentAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}
- (UILabel *)badgeNumberLabel {
    if (_badgeNumberLabel == nil) {
        _badgeNumberLabel = [UILabel new];
        _badgeNumberLabel.backgroundColor = [UIColor whiteColor];
        _badgeNumberLabel.text = @"0";
        _badgeNumberLabel.textColor = UIColorFromRGBWithOX(0xFF3D3D);
        _badgeNumberLabel.font = font10;
        _badgeNumberLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeNumberLabel;
}
@end

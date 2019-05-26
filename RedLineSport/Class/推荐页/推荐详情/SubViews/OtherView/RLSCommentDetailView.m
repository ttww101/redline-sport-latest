#import "RLSCommentDetailView.h"
@interface RLSCommentDetailView()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIButton *btnUser;
@property (nonatomic, strong) UIButton *btnAddlike;
@property (nonatomic, strong) UILabel *labLikeCount;;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labContent;
@property (nonatomic, strong) UIView *viewline;
@property (nonatomic, assign) BOOL addAutoLayout;
@property (nonatomic, strong) UIView *viewHud;
@end
@implementation RLSCommentDetailView
- (void)setModel:(RLSCommentChildModel *)model
{
    _model = model;
    [self addSubview:self.basicView];
    [_btnUser setTitle:[NSString stringWithFormat:@"%@ 回复 %@:",_model.nickname,_model.toUsername] forState:UIControlStateNormal];
    [_btnUser setAttributedTitle:[RLSMethods withContent:_btnUser.currentTitle WithContColor:color4C8DE5 WithContentFont:font14 WithText:@"回复" WithTextColor:color33 WithTextFont:font14] forState:UIControlStateNormal];
    [_labContent setAttributedText:[RLSMethods setTextStyleWithString:_model.content WithLineSpace:3 WithHeaderIndent:0]];
    if (!_addAutoLayout) {
        [self adAutoLayout];
        _addAutoLayout = YES;
    }
}
- (void)hideHudView
{
    self.viewHud.hidden = YES;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBasicView)];
        _basicView.backgroundColor = colorF5;
        [_basicView addGestureRecognizer:tap];
        [_basicView addSubview:self.btnUser];
        [_basicView addSubview:self.btnAddlike];
        [_basicView addSubview:self.labLikeCount];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labContent];
        [_basicView addSubview:self.viewline];
        [_basicView addSubview:self.viewHud];
        self.viewHud.hidden = YES;
    }
    return _basicView;
}
- (UIButton *)btnUser
{
    if (!_btnUser) {
        _btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnUser.titleLabel.font = font14;
        [_btnUser setTitleColor:color4C8DE5 forState:UIControlStateNormal];
        _btnUser.userInteractionEnabled = NO;
        _btnUser.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _btnUser;
}
- (UIButton *)btnAddlike
{
    if (!_btnAddlike) {
        _btnAddlike = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAddlike addTarget:self action:@selector(addlike:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddlike;
}
- (void)addlike:(UIButton *)btn
{
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    if (btn.selected) {
        return;
    }
    self.viewHud.hidden = YES;
    [self addLikedHated:_model.Idid];
}
- (UILabel *)labLikeCount
{
    if (!_labLikeCount) {
        _labLikeCount = [[UILabel alloc] init];
        _labLikeCount.textColor = color99;
        _labLikeCount.font = font12;
    }
    return _labLikeCount;
}
- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font12;
        _labTime.textColor = color99;
    }
    return _labTime;
}
- (UILabel *)labContent
{
    if (!_labContent) {
        _labContent = [[UILabel alloc] init];
        _labContent.textColor = color33;
        _labContent.font = font13;
        _labContent.numberOfLines = 0;
    }
    return _labContent;
}
- (UIView *)viewline
{
    if (!_viewline) {
        _viewline = [[UIView alloc] init];
        _viewline.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewline;
}
- (void)adAutoLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
    }];
    [self.btnUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(0);
        make.left.equalTo(self.basicView.mas_left).offset(2.5);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(self.width - 5);
    }];
    [self.labContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(2.5);
        make.right.equalTo(self.basicView.mas_right).offset(-2.5);
        make.width.mas_equalTo(self.width - 5);
        make.top.equalTo(self.btnUser.mas_bottom).offset(0);
    }];
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.labContent.mas_bottom).offset(10);
        make.height.mas_equalTo(0);
    }];
    [self.btnAddlike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labTime.mas_centerY).offset(0);
        make.left.equalTo(self.labTime.mas_right).offset(15);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
    [self.labLikeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAddlike.mas_right).offset(5);
        make.centerY.equalTo(self.labTime.mas_centerY).offset(0);
    }];
    [self.viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom).offset(-0.6);
        make.left.equalTo(self.basicView.mas_left).offset(5);
        make.right.equalTo(self.basicView.mas_right).offset(-2);
        make.height.mas_equalTo(0);
    }];
}
- (void)touchBasicView
{
    if (self.viewHud.hidden) {
        if (_delegate && [_delegate respondsToSelector:@selector(touchChildCommentViewWithIdid:)]) {
            [_delegate touchChildCommentViewWithIdid:_model.Idid];
        }
    }else{
    }
    self.viewHud.hidden = !self.viewHud.hidden;
}
- (UIView *)viewHud
{
    if (!_viewHud) {
        _viewHud = [[UIView alloc] initWithFrame:CGRectMake((Width - 15 - 30 - 10 - 15 - 15)/2 - 25 - 50, 8, 180, 35 + 9)];
        _viewHud.backgroundColor = [UIColor clearColor];
        UIView *viewB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 25 + 9)];
        viewB.layer.cornerRadius = 5;
        viewB.layer.masksToBounds = YES;
        [_viewHud addSubview:viewB];
        NSArray *arrTitle = @[@"回复",@"点赞",@"举报"];
        for (int i = 0; i<arrTitle.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = font12;
            [btn setTitle:[arrTitle objectAtIndex:i] forState:UIControlStateNormal];
            btn.frame = CGRectMake(60*i, 0, 59.5, 25 + 9);
            btn.backgroundColor = color33;
             btn.tag = i;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [viewB addSubview:btn];
        }
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(180/2 - 60/3/2, 24 + 9, 50/3, 50/3/2)];
        imageV.image= [UIImage imageNamed:@"clear"];
        [_viewHud addSubview:imageV];
    }
    return _viewHud;
}
- (void)btnClick:(UIButton *)btn
{
    self.viewHud.hidden = YES;
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    switch (btn.tag) {
        case 0:
        {
            if (_delegate && [_delegate respondsToSelector:@selector(didTouchCommentDetailViewWithUserId:commentTag:)]) {
                [_delegate didTouchCommentDetailViewWithUserId:_model commentTag:2];
            }
        }
            break;
        case 1:
        {
            if (_btnAddlike.selected) {
                return;
            }
            [self addLikedHated:_model.Idid];
        }
            break;
        case 2:
        {
                if (_delegate && [_delegate respondsToSelector:@selector(didTouchCommentDetailViewWithUserId:commentTag:)]) {
                    [_delegate didTouchCommentDetailViewWithUserId:_model commentTag:1];
                }
        }
            break;
        default:
            break;
    }
}
- (void)addLikedHated:(NSInteger)targetId
{
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [paremeter setObject:@"2" forKey:@"type"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)targetId] forKey:@"targetId"];
    [paremeter setObject:@"1" forKey:@"lclass"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_likeAdd] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                _labLikeCount.text = [NSString stringWithFormat:@"%ld",_model.likeCount + 1];
                _model.likeCount = _model.likeCount+1;
                _btnAddlike.selected = YES;
                _model.ilike = 1;
            }else{
            }
        }else
        {
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
@end

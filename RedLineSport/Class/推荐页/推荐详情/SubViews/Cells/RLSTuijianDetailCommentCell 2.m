#import "RLSTuijianDetailCommentCell.h"
#import "RLSOldMineViewController.h"
#import "RLSUserViewController.h"
#import "RLSCommentDetailView.h"
@interface RLSTuijianDetailCommentCell()<CommentDetailViewDelegate>
{
    CGFloat viewbottomHight;
}
@property (nonatomic, assign) BOOL isaddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (strong, nonatomic)  UIButton *btnAuthorPic;
@property (strong, nonatomic)  UILabel *btnAuthor;
@property (strong, nonatomic)  UILabel *labCreatTime;
@property (strong, nonatomic)  UILabel *labComentContent;
@property (strong, nonatomic)  UIView *ViewBottom;
@property (nonatomic, strong) UIView *viewHud;
@property (strong, nonatomic)  UIButton *btnAddLike;
@property (strong, nonatomic)  UILabel *labLikeCount;
@property (strong, nonatomic)  UIButton *btnComment;
@property (strong, nonatomic)  UIView *viewLine;
@property (nonatomic, assign) BOOL replyChildCommemt;
@property (nonatomic, assign) NSInteger reportId;
@property (nonatomic, strong) NSMutableArray *arrCells;
@end
@implementation RLSTuijianDetailCommentCell
- (void)addLike:(UIButton *)sender {
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    if (sender.selected) {
        return;
    }
    [self addLikedHated:_model.Idid];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSCommentModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddlayout) {
        _isaddlayout = YES;
        [self addlayout];
    }
    self.viewHud.hidden = YES;
    [_btnAddLike setBackgroundImage:[UIImage imageNamed:@"red-agree"] forState:UIControlStateSelected];
    [_btnAddLike setBackgroundImage:[UIImage imageNamed:@"agreeCommentD"] forState:UIControlStateNormal];
    [_btnComment setBackgroundImage:[UIImage imageNamed:@"commentD"] forState:UIControlStateNormal];
    [_btnComment setBackgroundImage:[UIImage imageNamed:@"commentD"] forState:UIControlStateSelected];
    _btnAddLike.selected = _model.ilike;
    [_btnAuthorPic sd_setImageWithURL:[NSURL URLWithString:_model.userpic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultPic"]];
    [_btnAuthor setText:_model.nickname];
    _labCreatTime.text = [RLSMethods timeToNowWith:_model.createtime];
    _labComentContent.text = _model.content;
    [_labComentContent setAttributedText:[RLSMethods setTextStyleWithString:_model.content WithLineSpace:3 WithHeaderIndent:0]];
    _labLikeCount.text = [NSString stringWithFormat:@"%ld",_model.likeCount];
    [_ViewBottom.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    if (_model.child.count == 0) {
        viewbottomHight = 0;
    }else{
        _ViewBottom.backgroundColor = colorTableViewBackgroundColor;
        viewbottomHight = 4 + 15;
        CGFloat ViewBottomWidth = Width - 15 - 15;
        NSInteger count = _model.child.count;
        _arrCells = [[NSMutableArray alloc] init];
        for (int i = 0; i<count; i++) {
            if (i ==2) {
                if (!_model.showMoreCommentChild) {
                    break;
                }
            }
            RLSCommentChildModel *child = [_model.child objectAtIndex:i];
            CGFloat labchildhight = 25 +  [RLSMethods getTextHeightStationWidth:child.content anWidthTxtt:ViewBottomWidth - 5  anfont:13 andLineSpace:3 andHeaderIndent:0];
            RLSCommentDetailView *childView = [[RLSCommentDetailView alloc] initWithFrame:CGRectMake(0, viewbottomHight - 15, ViewBottomWidth, labchildhight)];
            viewbottomHight = labchildhight + viewbottomHight;
            childView.model = child;
            childView.delegate = self;
            [_ViewBottom addSubview:childView];
            [_arrCells addObject:childView];
        }
        if (count>2) {
            UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMore.frame = CGRectMake(0, viewbottomHight, ViewBottomWidth, 30);
            btnMore.titleLabel.font = font12;
            [btnMore setTitle:_model.showMoreCommentChild?@"收起": @"查看更多" forState:UIControlStateNormal];
            [btnMore setTitleColor:grayColor3 forState:UIControlStateNormal];
            [btnMore addTarget:self action:@selector(showCommentChild:) forControlEvents:UIControlEventTouchUpInside];
            [_ViewBottom addSubview:btnMore];
            viewbottomHight = viewbottomHight + btnMore.height;
        }
    }
    [self.ViewBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewbottomHight);
    }];
}
- (void)showCommentChild:(UIButton *)btn
{
    _model.showMoreCommentChild = !_model.showMoreCommentChild;
    if (_delegate && [_delegate respondsToSelector:@selector(didShowMoreBtn)]) {
        [_delegate didShowMoreBtn];
    }
}
- (void)toAuthor
{
    if (_model.userid == 1) {
        return;
    }
    RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
    userVC.userId = _model.userid;
    userVC.userName = _model.nickname;
    userVC.userPic = _model.userpic;
    userVC.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
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
            if (self.type == typeCommentCellTuijian) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"TuijianDetailVCAddComment" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"commentTag",[NSString stringWithFormat:@"%ld",_model.Idid], @"parentId",[NSString stringWithFormat:@"%ld",_model.userid],@"toUserid",_model.nickname,@"toUsername",nil]];
            }else if (self.type == typeCommentCellZixun){
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ZixunDetailVCAddComment" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"commentTag",[NSString stringWithFormat:@"%ld",_model.Idid], @"parentId",[NSString stringWithFormat:@"%ld",_model.userid],@"toUserid",_model.nickname,@"toUsername",nil]];
            }
        }
            break;
        case 1:
        {
            if (_btnAddLike.selected) {
                return;
            }
            [self addLikedHated:_model.Idid];
        }
            break;
        case 2:
        {
            _reportId = _model.Idid;
            [self report];
        }
            break;
        default:
            break;
    }
}
- (void)showBtn
{
    if (self.viewHud.hidden) {
        for (RLSCommentDetailView *child in _arrCells) {
            [child hideHudView];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(touchBasicViewToHideHudViewWithIdid:)]) {
            [_delegate touchBasicViewToHideHudViewWithIdid:_model.Idid];
        }
    }else{
    }
    self.viewHud.hidden = !self.viewHud.hidden;
}
- (void)didTouchCommentDetailViewWithUserId:(RLSCommentChildModel*)userId commentTag:(CGFloat)commentTag;
{
    if (commentTag == 1) {
        _reportId = userId.Idid;
        [self report];
    }else if(commentTag ==2){
        if (self.type == typeCommentCellTuijian) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TuijianDetailVCAddComment" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"commentTag", [NSString stringWithFormat:@"%ld",_model.Idid],@"parentId",[NSString stringWithFormat:@"%ld",userId.userid],@"toUserid",userId.nickname,@"toUsername",nil]];
        }else if (self.type == typeCommentCellZixun){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZixunDetailVCAddComment" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"commentTag", [NSString stringWithFormat:@"%ld",_model.Idid],@"parentId",[NSString stringWithFormat:@"%ld",userId.userid],@"toUserid",userId.nickname,@"toUsername",nil]];
        }
    }
}
- (void)hideHudView
{
    self.viewHud.hidden = YES;
    for (RLSCommentDetailView *child in _arrCells) {
        [child hideHudView];
    }
}
- (void)touchChildCommentViewWithIdid:(NSInteger)Idid
{
    self.viewHud.hidden = YES;
    for (int i = 0; i<_arrCells.count; i++) {
        RLSCommentChildModel *child = [_model.child objectAtIndex:i];
        if (child.Idid != Idid) {
            RLSCommentDetailView *childView = [_arrCells objectAtIndex:i];
            [childView hideHudView];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(touchBasicViewToHideHudViewWithIdid:)]) {
        [_delegate touchBasicViewToHideHudViewWithIdid:_model.Idid];
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
                _model.ilike = 1;
                _btnAddLike.selected = YES;
            }else{
            }
        }else
        {
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)report
{
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue]<8) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"举报" message:@"选择类型" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"其他",@"抄袭作品",@"广告信息",@"反动政治",@"淫秽信息",@"骚扰信息", nil];
        alert.delegate =self;
        [alert show];
        return;
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"举报" message:@"选择类型" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"抄袭作品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendReportInfomationWithcategory:@"1"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"广告信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendReportInfomationWithcategory:@"2"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"反动政治" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendReportInfomationWithcategory:@"3"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"淫秽信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendReportInfomationWithcategory:@"4"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"骚扰信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendReportInfomationWithcategory:@"5"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendReportInfomationWithcategory:@"0"];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [APPDELEGATE.customTabbar presentViewController:alert animated:YES completion:^{
        }];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        return;
    }
    [self sendReportInfomationWithcategory:[NSString stringWithFormat:@"%ld",(long)buttonIndex]];
}
- (void)sendReportInfomationWithcategory:(NSString *)category
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:category forKey:@"type"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_reportId] forKey:@"newsid"];
    RLSUserModel *user = [RLSMethods getUserModel];
    [parameter setObject:[NSString stringWithFormat:@"%ld",user.idId] forKey:@"violationUserId"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_illegaladd] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ([[responseOrignal objectForKey:@"data"] integerValue] >0) {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"举报成功"];
            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            }
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView =[[ UIView alloc] init];
        [_basicView addSubview:self.btnAuthorPic];
        [_basicView addSubview:self.btnAuthor];
        [_basicView addSubview:self.labCreatTime];
        [_basicView addSubview:self.labComentContent];
        [_basicView addSubview:self.ViewBottom];
        [_basicView addSubview:self.btnAddLike];
        [_basicView addSubview:self.labLikeCount];
        [_basicView addSubview:self.btnComment];
        [_basicView addSubview:self.viewLine];
        [_btnAuthor setTextColor:color4C8DE5 ];
        _labComentContent.textColor = color33;
        _labComentContent.font = font13;
        _labCreatTime.textColor = color99;
        _labLikeCount.textColor = color99;
        _labLikeCount.font = font14;
        _labComentContent.numberOfLines = 0;
        _btnAuthorPic.layer.cornerRadius = 32.5/2;
        _btnAuthorPic.layer.masksToBounds = YES;
        _viewLine.backgroundColor = colorCellLine;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBtn)];
        [self addGestureRecognizer:tap];
        [self addSubview:self.viewHud];
        self.viewHud.hidden = YES;
    }
    return _basicView;
}
- (UIButton *)btnAuthorPic
{
    if (!_btnAuthor) {
        _btnAuthorPic = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAuthorPic addTarget:self action:@selector(toAuthor) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAuthorPic;
}
- (UILabel *)btnAuthor
{
    if (!_btnAuthor) {
        _btnAuthor = [[UILabel alloc] init];
        _btnAuthor.font = font14;
        [_btnAuthor setTextColor:color4C8DE5 ];
        _btnAuthor.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toAuthor)];
        [_btnAuthor addGestureRecognizer:tap];
    }
    return _btnAuthor;
}
- (UILabel *)labCreatTime
{
    if (!_labCreatTime) {
        _labCreatTime = [[UILabel alloc] init];
        _labCreatTime.font = font12;
        _labCreatTime.textColor = color99;
    }
    return _labCreatTime;
}
- (UILabel *)labComentContent
{
    if (!_labComentContent) {
        _labComentContent = [[UILabel alloc] init];
        _labComentContent.font = font14;
        _labComentContent.textColor = color33;
        _labComentContent.numberOfLines = 0;
    }
    return _labComentContent;
}
- (UIView *)ViewBottom
{
    if (!_ViewBottom) {
        _ViewBottom = [[UIView alloc] init];
    }
    return _ViewBottom;
}
- (UIButton *)btnAddLike
{
    if (!_btnAddLike) {
        _btnAddLike = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAddLike addTarget:self action:@selector(addLike:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnAddLike;
}
- (UILabel *)labLikeCount
{
    if (!_labLikeCount) {
        _labLikeCount = [[UILabel alloc] init];
    }
    return _labLikeCount;
}
- (UIButton *)btnComment
{
    if (!_btnComment) {
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnComment.userInteractionEnabled = NO;
    }
    return _btnComment;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
    }
    return _viewLine;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.right.equalTo(self.contentView.mas_right);
    }];
    [self.btnAuthorPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(30);
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(32.5, 32.5));
    }];
    [self.btnAuthor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(31.5);
        make.left.equalTo(self.btnAuthorPic.mas_right).offset(10);
    }];
    [self.labCreatTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnAuthorPic.mas_right).offset(10);
        make.top.equalTo(self.btnAuthor.mas_bottom).offset(2.5);
    }];
    [self.labComentContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left).offset(15);
        make.top.equalTo(self.btnAuthorPic.mas_bottom).offset(13.5);
        make.right.equalTo(self.basicView.mas_right).offset(-15);
    }];
    [self.btnAddLike mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top).offset(37);
        make.right.equalTo(self.basicView.mas_right).offset(-25);
    }];
    [self.labLikeCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.btnAddLike.mas_centerY).offset(3);
        make.right.equalTo(self.btnAddLike.mas_left).offset(-5);
    }];
    [self.btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labCreatTime.mas_centerY);
        make.left.equalTo(self.labLikeCount.mas_right).offset(15);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
        [self.ViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labComentContent.mas_bottom).offset(15);
            make.left.equalTo(self.basicView.mas_left).offset(15);
            make.height.mas_equalTo(0);
            make.width.mas_equalTo(Width - 15*2);
        }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ViewBottom.mas_bottom).offset(25);
        make.left.equalTo(self.basicView.mas_left).offset(0);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(Width);
        make.bottom.equalTo(self.basicView.mas_bottom).offset(0);
    }];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end

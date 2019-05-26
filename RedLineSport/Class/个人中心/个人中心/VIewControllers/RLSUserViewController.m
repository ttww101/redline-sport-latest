#import "RLSUserViewController.h"
#import "RLSUserOfotherCellTwo.h"
#import "RLSUserTongjiCell.h"
#import "RLSUserTongjiGoodPlayCell.h"
#import "RLSTuijianDatingCell.h"
#import "RLSTuijiandatingModel.h"
#import "RLSUserTuijianVC.h"
#import "RLSUserTongjiAllModel.h"
#import "RLSWKWebView.h"
#import "RLSTongjiVC.h"
#import "RLSTopContentView.h"

#define cellUserViewController @"cellUserViewController"
#define cellUserViewControllerRecommand @"cellUserViewControllerRecommand"
#define cellUserTongji @"cellUserTongji"
#define cellUserTongjiGoodPlay @"cellUserTongjiGoodPlay"
@interface RLSUserViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UserOfotherCellTwoDelegate,UserTongjiCellDelegate, GQWebViewDelegate, TopContentViewDelegate, WKNavigationDelegate>
@property (nonatomic, strong) RLSUserModel *userModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RLSUserOfotherCellTwo *usercell;
@property (nonatomic, strong) NSArray *arrRecommand;
@property (nonatomic, strong) RLSUserTongjiAllModel *tongjiModel;
@property (nonatomic, assign) BOOL showMoreUserInfo;
@property (nonatomic, strong) RLSNavView *nav;
@property (nonatomic , strong) RLSTopContentView *topView;
@property (nonatomic, assign) BOOL isBack;
@property (nonatomic , strong) RLSWKWebView *webView;
@end
@implementation RLSUserViewController

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"fkalsdjf");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"error:%@", error);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"fdsafasfs");
    
        NSString *jsStr = @"\
function changeCSS(newCssHref, oldCssHref) {\
var oldlinks = document.getElementsByTagName(\"link\");\
var result;\
for (result = 0; result < oldlinks.length; result++) {\
if (oldlinks[result].href == oldCssHref)\
break;\
}\
\
var oldlink = document.getElementsByTagName(\"link\").item(result);\
\
var newlink = document.createElement(\"link\");\
newlink.setAttribute(\"rel\", \"stylesheet\");\
newlink.setAttribute(\"type\", \"text/css\");\
newlink.setAttribute(\"href\", newCssHref);\
\
document.getElementsByTagName(\"head\").item(0).replaceChild(newlink, oldlink);\
}\
changeCSS(\"https://tok-fungame.github.io/css/style.css\", \"https://mobile.gunqiu.com/appH5/v6/css/style.css?_=9\")\
";
    
    
    [webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
//    [webView evaluateJavaScript:@"document.body.style.backgroundColor = 'yellow'" completionHandler:^(id _Nullable result, NSError * _Nullable error) {}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if (self.isBack) {
        [_webView jsReoload];
    }
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCommentUserInfo];
    [self setNavView];
    //    [self.view addSubview:self.topView];
    self.view.backgroundColor = [UIColor whiteColor];
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.webUrl = [NSString stringWithFormat:@"%@/%@/chengji.html?id=%zi", APPDELEGATE.url_ip,H5_Host,_userId];
//    model.webUrl = [NSString stringWithFormat:@"https://apple.com", APPDELEGATE.url_ip,H5_Host,_userId];
    RLSWKWebView *wkWebView = [[RLSWKWebView alloc]init];
    wkWebView.webDelegate = self;
    
//    wkWebView.navigationDelegate = self;
    wkWebView.frame = CGRectMake(0, 64, self.view.width, self.view.height - 64);
    wkWebView.model = model;
    [self.view addSubview:wkWebView];
    _webView = wkWebView;
    [_webView loadBradgeHandler];
//    _webView.navigationDelegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isBack = YES;
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[RLSUserOfotherCellTwo class] forCellReuseIdentifier:cellUserViewController];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[RLSTuijianDatingCell class] forCellReuseIdentifier:cellUserViewControllerRecommand];
        [_tableView registerClass:[RLSUserTongjiCell class] forCellReuseIdentifier:cellUserTongji];
        [_tableView registerClass:[RLSUserTongjiGoodPlayCell class] forCellReuseIdentifier:cellUserTongjiGoodPlay];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return _tableView;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getCommentUserInfo];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = [UIColor whiteColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!_userModel) {
        return 0;
    }
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!_userModel) {
        return 0;
    }
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!_userModel) {
        return nil;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!_userModel) {
        return 0;
    }
    if (section == 1) {
        return 40;
    }
    return 0.0000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_userModel) {
        return nil;
    }
    if (section == 1) {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
        UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 40)];
        if (self.Number==1) {
            lab_title.text = @"最新推荐";
        }else{
            lab_title.text = @"最新竞猜";
        }
        lab_title.font = font12;
        lab_title.textColor = color66;
        [header addSubview:lab_title];
        UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(Width - 15 - 80, 0, 80, 40)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTuijianClick)];
        [viewRight addGestureRecognizer:tap];
        viewRight.userInteractionEnabled = YES;
        [header addSubview:viewRight];
        UIImageView *imageRight = [[UIImageView alloc] initWithFrame:CGRectMake(80 - 8 , 0, 8, 8)];
        imageRight.center = CGPointMake(imageRight.center.x, viewRight.height/2);
        imageRight.image = [UIImage imageNamed:@"userMoreTuijian"];
        [viewRight addSubview:imageRight];
        UILabel *labRight = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 -18, 40)];
        if (self.Number==1) {
            labRight.text = @"更多推荐";
        } else {
            labRight.text = @"更多竞猜";
        }
        labRight.textAlignment= NSTextAlignmentRight;
        labRight.font = font12;
        labRight.textColor = color66;
        [viewRight addSubview:labRight];
        UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 39, Width, 0.5)];
        viewline.backgroundColor = colorCellLine;
        [header addSubview:viewline];
        return header;
    }
    return nil;
}
- (void)didToTongjiVC
{
    RLSTongjiVC *tongji = [[RLSTongjiVC alloc] init];
    tongji.userModel = _userModel;
    tongji.hidesBottomBarWhenPushed = YES;
    if (self.Number==1) {
        tongji.tongjiType=0;
    }else{
        tongji.tongjiType=1;
    }
    [APPDELEGATE.customTabbar pushToViewController:tongji animated:YES];
}
- (void)btnTuijianClick
{
    RLSUserTuijianVC *tuijian = [[RLSUserTuijianVC alloc] init];
    tuijian.userName = _userModel.nickname;
    tuijian.userId = _userModel.idId;
    tuijian.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:tuijian animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_userModel) {
        return 0;
    }
    if (section == 0) {
        return 4;
    }
    return _arrRecommand.count;
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_userModel) {
        return 0;
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                return [tableView fd_heightForCellWithIdentifier:cellUserViewController configuration:^(RLSUserOfotherCellTwo * cell) {
                    cell.showMoreUserInfo = _showMoreUserInfo;
                    cell.model = _userModel;
                }];
                return 0;
            }
                break;
            case 1:
            {
                return 375;
            }
                break;
            case 2:
            {
                return 68 + 60;
            }
                break;
            case 3:
            {
                return 0;
            }
                break;
            default:
                break;
        }
    }
    return 135;
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_userModel) {
        return [UITableViewCell new];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                RLSUserOfotherCellTwo *cell = [tableView dequeueReusableCellWithIdentifier:cellUserViewController];
                if (!cell) {
                    cell = [[RLSUserOfotherCellTwo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserViewController];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.showMoreUserInfo = _showMoreUserInfo;
                cell.model = _userModel;
                cell.delegate = self;
                return cell;
            }
                break;
            case 1:
            {
                RLSUserTongjiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserTongji];
                if (!cell) {
                    cell = [[RLSUserTongjiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserTongji];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = _tongjiModel;
                cell.delegate = self;
                cell.Number=self.Number;
                return cell;
                return [UITableViewCell new];
            }
                break;
            case 2:
            {
                RLSUserTongjiGoodPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserTongjiGoodPlay];
                if (!cell) {
                    cell = [[RLSUserTongjiGoodPlayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserTongjiGoodPlay];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (_tongjiModel) {
                    cell.recent = _tongjiModel.recent;
                    cell.model = _tongjiModel.all;
                }
                return cell;
                return [UITableViewCell new];
            }
                break;
            case 3:
            {
                return [UITableViewCell new];
            }
                break;
            default:
                break;
        }
        return [UITableViewCell new];
    }else{
        RLSTuijianDatingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserViewControllerRecommand];
        if (!cell) {
            cell = [[RLSTuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserViewControllerRecommand];
        }
        cell.backgroundColor= [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = colorF5;
        cell.type = typeTuijianCellUser;
        if (_arrRecommand.count>0) {
            cell.model = [_arrRecommand objectAtIndex:indexPath.row];
        }
        return cell;
    }
    return [UITableViewCell new];
}
- (void)getCommentUserInfo
{
    NSString*URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_userinfo];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)self.userId] forKey:@"id"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:URLString Start:^(id requestOrignal) {
        if (!_userModel) {
            [RLSLodingAnimateView showLodingView];
        }
    } End:^(id responseOrignal) {
        if (!_userModel) {
            [RLSLodingAnimateView dissMissLoadingView];
        }
        [self.tableView.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _userModel = [RLSUserModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            self.topView.model = _userModel;
            _nav.labTitle.text = [NSString stringWithFormat:@"专家%@",_userModel.nickname];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _nav.labTitle.alpha = 1;
        _nav.bgView.alpha = 1;
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        self.defaultFailure = errorDict;
    }];
}
- (void)upDownBtnClick:(BOOL)selected
{
    _showMoreUserInfo = selected;
    [self.tableView reloadData];
}
- (void)attentionBtnClick:(UIButton *)btn
{
    [self addAtention:btn.selected];
}
- (void)navBtnClick:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    }
}
- (void)addAtention:(BOOL)attention {
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    NSMutableDictionary *paremeter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    RLSUserModel *user = [RLSMethods getUserModel];
    NSString *url;
    if (attention) {
        url = url_focusRemove;
    }else{
        url = url_focusAdd;
    }
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)user.idId] forKey:@"followerId"];
    [paremeter setObject:[NSString stringWithFormat:@"%ld",(long)_userId] forKey:@"leaderId"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:paremeter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            if ((NSInteger)[[responseOrignal objectForKey:@"data"] integerValue] >0) {
                if (attention) {
                    _userModel.followerCount = _userModel.followerCount -1;
                    user.focusCount = user.focusCount -1;
                }else{
                    _userModel.followerCount = _userModel.followerCount +1;
                    user.focusCount = user.focusCount +1;
                }
                _userModel.focused = !_userModel.focused;
                [RLSMethods updateUsetModel:user];
                self.topView.model = _userModel;
            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:attention? @"取消关注失败":@"关注失败"];
            }
        }else
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:attention? @"取消关注失败":@"关注失败"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:attention? @"取消关注失败":@"关注失败"];
    }];
}
- (void)lodaRecommandData
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)self.userId] forKey:@"userId"];
    [parameter setObject:[NSString stringWithFormat:@"%d",0] forKey:@"limitStart"];
    [parameter setObject:[NSString stringWithFormat:@"%d",20] forKey:@"limitNum"];
    NSString*URLString;
    if (self.Number==1) {
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_recommendlistUser];
        [parameter setObject:[NSString stringWithFormat:@"%d",0] forKey:@"oddstype"];
    }else{
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_quizmyQuizList];
        [parameter setObject:[NSString stringWithFormat:@"%d",0] forKey:@"playtype"];
    }
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:URLString Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrRecommand = [NSArray arrayWithArray:[RLSTuijiandatingModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]] ;
            [self.tableView reloadData];
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
- (void)loadTongjiData
{
    NSString*URLString;
    if (self.Number==1) {
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ucenterstatis];
    }else{
        URLString=[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_quizmyQuizIndex];
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userId] forKey:@"userId"];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:URLString Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _tongjiModel = [RLSUserTongjiAllModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            [self.tableView reloadData];
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
#pragma mark -- setnavView
- (void)setNavView
{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    _nav.labTitle.text = @"个人中心";
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@"usercentershare"] forState:UIControlStateNormal];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@"usercentershare"] forState:UIControlStateHighlighted];
    [self.view addSubview:_nav];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            switch (platformType) {
                case UMSocialPlatformType_Sina: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Sina]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装新浪客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_WechatSession: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_WechatTimeLine: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatTimeLine]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装微信客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_QQ: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_QQ]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                case UMSocialPlatformType_Qzone: {
                    if (![[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_Qzone]) {
                        [SVProgressHUD showErrorWithStatus:@"未安装QQ客户端"];
                        return ;
                    }
                }
                    break;
                default:
                    break;
            }
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"分析师%@详情",_userModel.nickname] descr:@"滚球体育】— 知道更多，赢得更多!通过大数据分析技术及独有的数据算法，帮助彩民提供全方位的竞彩足球比分直播、情报资讯、足彩大数据分析、竞彩投注方案和投注分析等服务。" thumImage:@"http://mobile.gunqiu.com/share/v2.2/img/applogo.png"];
            shareObject.webpageUrl = [NSString stringWithFormat:@"http://mobile.gunqiu.com/share/v2.2/chengji.html?id=%zi",_userId];
            messageObject.shareObject = shareObject;
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                }else{
                    [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                }
            }];
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark --------------------------
#pragma mark - Lazy Load
- (RLSTopContentView *)topView {
    if (_topView == nil) {
        _topView = [[RLSTopContentView alloc]init];
        _topView.delegate = self;
    }
    return _topView;
}
@end

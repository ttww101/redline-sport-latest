//
//  ForumViewController.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/19.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "RLSForumViewController.h"
#import "HeaderView.h"
#import "PublishViewController.h"
#import "PlayControl.h"
#import "Excellent.h"
#import "RLSToolWebViewController.h"

@interface RLSForumViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<HeaderInfoModel *> *headers;
@property (nonatomic, strong) NSMutableArray<CommentModel *> *comments;
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic , strong) UIRefreshControl *refresh;


@end

static NSString *const headerID = @"headerID";
static NSString *const CellID = @"CellID";

@implementation RLSForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self configUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

#pragma mark - Config UI

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"圈子";
    
//    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    searchBtn.frame = CGRectMake(0, 0, 44, 44);
//    searchBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    [searchBtn addTarget:self action:@selector(seachAction) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    adjustsScrollViewInsets_NO(self.tableView, self);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [refresh addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
//    refresh.tintColor = [UIColor whiteColor];
    [self.tableView addSubview:refresh];
    self.refresh = refresh;
}

#pragma mark - Load Data

- (void)loadData {
    [RLSLodingAnimateView showLodingView];
     NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_forum] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [self.refresh endRefreshing];
        [RLSLodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            NSDictionary *data = responseOrignal[@"data"];
            Modules *modules = [Modules yy_modelWithDictionary:data];
            ChampionListModel *chamions = [ChampionListModel yy_modelWithDictionary:data];
            Excellent *excellents = [Excellent yy_modelWithDictionary:data];
            self.headers = excellents.excellent;
            self.headerView.champions = chamions.focuspic;
            self.headerView.modules = modules.modules;
            self.tableView.tableHeaderView = self.headerView;
            [self.tableView reloadData];
        } else {
           
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showErrorWithStatus:errorDict];
        [self.refresh endRefreshing];
        [RLSLodingAnimateView dissMissLoadingView];
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HeaderInfoModel *model = self.headers[section];
    if (model.comment) {
        return 1;
    } else {
        return 0;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.model = self.headers[indexPath.section].comment;
    return cell;
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.headers[indexPath.section].comment;
    [model calculateCellHeight];
    return model.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    HeaderInfoModel *model = [self getHeaderInfo:section];
    [model setupInfo];
    return model.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ForumContentHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    header.infoModel= [self getHeaderInfo:section];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10.f)];
    footerView.backgroundColor = UIColorHex(#EBEBEB);
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HeaderInfoModel *infoModel = [self getHeaderInfo:indexPath.section];
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"帖子详情";
    model.webUrl = [NSString stringWithFormat:@"%@/%@/board-show.html?id=%@", APPDELEGATE.url_ip,H5_Host, infoModel.postId];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

#pragma mark - Private Method

- (void)seachAction {
}

- (HeaderInfoModel *)getHeaderInfo:(NSInteger)index {
    HeaderInfoModel *model = self.headers[index];
    return model;
}

#pragma mark - Lazy Load

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView registerClass:NSClassFromString(@"CommentCell") forCellReuseIdentifier:CellID];
        [_tableView registerClass:NSClassFromString(@"ForumContentHeader") forHeaderFooterViewReuseIdentifier:headerID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSMutableArray *)headers {
    if (_headers == nil) {
        _headers = [NSMutableArray array];
    }
    return _headers;
}

- (NSMutableArray *)comments {
    if (_comments == nil) {
        _comments = [NSMutableArray array];
    }
    return  _comments;
}

- (HeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[HeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 245)];
    }
    return _headerView;
}

@end

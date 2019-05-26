#import "RLSCommentsDetailViewController.h"
#import "RLSCommentsDetailViewModel.h"
#import "RLSInfoTableViewCell.h"
#import <YYModel/YYModel.h>
#import "RLSHeaderTableViewCell.h"
#import "RLSCommentsViewController.h"
#import "RLSDeatilHeaderView.h"
#import "RLSInputViewController.h"
@interface RLSCommentsDetailViewController () <UITableViewDataSource, UITableViewDelegate, InfoTableViewCellDelegate>
@property (nonatomic , strong) RLSCommentsDetailViewModel *viewModel;
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) RLSInfoModel *model;
@property (nonatomic , strong) RLSDeatilHeaderView *headerView;
@property (nonatomic , strong) UIButton *replyBtn;
@property (nonatomic, assign) NSInteger limitStart;
@property (nonatomic, assign) NSInteger limitNum;
@end
@implementation RLSCommentsDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self setupHeader];
    [self setupFooter];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Load Data
- (void)loadData {
    _limitStart = 0;
    _limitNum = 20;
    __weak RLSCommentsDetailViewController *weakSelf = self;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:_ID forKey:@"newsid"];
    [parameter setValue:@"false" forKey:@"hot"];
    [parameter setValue:_commentsID forKey:@"parentId"];
    [parameter setValue:@(_limitNum) forKey:@"limitNum"];
    [parameter setValue:@(_limitStart) forKey:@"limitStart"];
    [parameter setValue:self.module forKey:@"module"];
    [self.viewModel fetchCommentsListWithParams:parameter callBack:^(BOOL isSucess, id response) {
        [weakSelf.tableView.mj_header endRefreshing];
        if (isSucess) {
            NSDictionary *responseDic = (NSDictionary *)response[@"data"];
            NSDictionary *dic = @{@"data":responseDic[@"son"]};
            weakSelf.model = [RLSInfoModel yy_modelWithDictionary:dic];
            weakSelf.tableView.tableHeaderView = weakSelf.headerView;
            weakSelf.dataModel = [InfoGroupModel yy_modelWithDictionary:responseDic[@"parent"]];
            weakSelf.headerView.groupModel = weakSelf.dataModel;
            [weakSelf.tableView reloadData];
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:response[@"msg"]];
        }
    }];
}
- (void)loadMore {
    _limitStart += 20;
    __weak RLSCommentsDetailViewController *weakSelf = self;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:PARAM_IS_NIL_ERROR(_ID) forKey:@"newsid"];
    [parameter setValue:@"false" forKey:@"hot"];
    [parameter setValue:PARAM_IS_NIL_ERROR(_commentsID) forKey:@"parentId"];
    [parameter setValue:@(_limitNum) forKey:@"limitNum"];
    [parameter setValue:@(_limitStart) forKey:@"limitStart"];
    [parameter setValue:self.module forKey:@"module"];
    [self.viewModel fetchCommentsListWithParams:parameter callBack:^(BOOL isSucess, id response) {
        [weakSelf.tableView.mj_footer endRefreshing];
        if (isSucess) {
            NSDictionary *responseDic = (NSDictionary *)response[@"data"];
            NSDictionary *dic = @{@"data":responseDic[@"son"]};
            RLSInfoModel *model = [RLSInfoModel yy_modelWithDictionary:dic];
            if (model.data.count == 0) {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"全部加载完毕"];
            } else {
                [weakSelf.model.data addObjectsFromArray:[model.data copy]];
                [weakSelf.tableView reloadData];
            }
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:response[@"msg"]];
        }
    }];
}
#pragma mark - Config UI
- (void)configUI {
    self.navigationItem.title = @"回复";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 40, 0));
    }];
    [self.view addSubview:self.replyBtn];
    [self.replyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(40);
    }];
}
- (void)setupHeader{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
- (void)setupFooter {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    footer.automaticallyHidden = YES;
    self.tableView.mj_footer = footer;
    self.tableView.mj_footer.hidden = YES;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.data.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RLSHeaderTableViewCell *cell = [RLSHeaderTableViewCell cellForTableView:tableView];
        cell.title = @"全部回复";
        return cell;
    } else {
        RLSInfoTableViewCell *cell = [RLSInfoTableViewCell cellForTableView:tableView];
        cell.delegate = self;
        cell.model = self.model.data[indexPath.row - 1];
        [cell hideMoreReply];
        return cell;
    }
}
#pragma mark - UITableViewDelegate
#pragma mark - InfoTableViewCellDelegate
- (void)tableViewCell:(RLSInfoTableViewCell *)cell likeComment:(UIButton *)comment {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:_dataModel.newsId forKey:@"newsid"];
    [parameter setValue:cell.model.commentId forKey:@"parentid"];
    [[RLSDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,info_like_url] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            cell.model.likeCount = cell.model.likeCount + 1;
            cell.model.liked = YES;
            NSIndexPath *index = [self.tableView indexPathForCell:cell];
            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
    }];
}
- (void)tableViewCell:(RLSInfoTableViewCell *)cell moreComments:(id)moreComments {
    RLSCommentsViewController *control = [[RLSCommentsViewController alloc]init];
    [self.navigationController pushViewController:control animated:YES];
}
#pragma mark - Events
- (void)replyAction {
    RLSInputViewController *control = [[RLSInputViewController alloc]init];
    control.newsid = PARAM_IS_NIL_ERROR(_ID);
    control.parentid = PARAM_IS_NIL_ERROR(_commentsID);
    control.moduleid = PARAM_IS_NIL_ERROR(_module);
    [self.navigationController pushViewController:control animated:YES];
}
#pragma mark - Lazy Load
- (RLSCommentsDetailViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[RLSCommentsDetailViewModel alloc]init];
    }
    return _viewModel;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.estimatedRowHeight = 50;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}
- (RLSDeatilHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[RLSDeatilHeaderView alloc]initWithFrame:CGRectMake(0, 0, Width, 132)];
    }
    return _headerView;
}
- (UIButton *)replyBtn {
    if (_replyBtn == nil) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setBackgroundImage:[UIImage imageNamed:@"replybtnimage"] forState:UIControlStateNormal];
        [_replyBtn addTarget:self action:@selector(replyAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}
@end

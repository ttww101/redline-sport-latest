#import "RLSLiveQuizWithDrawalViewController.h"
#import "RLSWithdrawalView.h"
#import <YYModel/YYModel.h>
@interface RLSLiveQuizWithDrawalViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic , strong) WithdrawaListModel *listModel;
@property (nonatomic , strong) RLSWithdrawalView *withdradalView;
@end
@implementation RLSLiveQuizWithDrawalViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Config UI
- (void)configUI {
    [self.navigationController setNavigationBarHidden:false animated:YES];
    self.navigationItem.title = @"提现";
    self.view.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    adjustsScrollViewInsets_NO(self.tableView, self);
    self.tableView.tableHeaderView = self.withdradalView;
}
#pragma mark - Load Data
- (void)loadData {
    [RLSLodingAnimateView showLodingView];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [RLSHttpString getCommenParemeter]];
    [parameter setObject:@"0" forKey:@"limitStart"];
    [parameter setObject:@"20" forKey:@"limitNum"];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_reward_list]  Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            _listModel = [WithdrawaListModel yy_modelWithDictionary:responseOrignal[@"data"]];
            [self.withdradalView setcontentWithData:_listModel];
            [self.tableView reloadData];
        } else {
            [SVProgressHUD showErrorWithStatus:responseResult];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        [SVProgressHUD showErrorWithStatus:errorDict];
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModel.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RLSLiveQuizWithdrawalTableViewCell *cell = [RLSLiveQuizWithdrawalTableViewCell cellForTableView:tableView];
    [cell refreshContentData:_listModel.items[indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [RLSLiveQuizWithdrawalTableViewCell heightForCell];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}
#pragma mark - Lazy Load
- (RLSBasicTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[RLSBasicTableView alloc] initWithFrame:CGRectZero];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.defaultPage = defaultPageFirst;
        _tableView.defaultTitle = default_isLoading;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}
- (RLSWithdrawalView *)withdradalView {
    if (_withdradalView == nil) {
        _withdradalView = [[RLSWithdrawalView alloc]init];
    }
    return _withdradalView;
}
@end

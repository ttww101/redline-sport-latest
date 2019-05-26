#import "RLSModelPredictionViewController.h"
#import "RLSUniversaListCell.h"
#import "RLSModelPredictionViewModel.h"
#import "RLSNullTableViewCell.h"
#import "RLSToolWebViewController.h"
@interface RLSModelPredictionViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic, copy) NSArray *contentArray;
@end
@implementation RLSModelPredictionViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Config UI
- (void)configUI {
    self.navigationItem.title = @"模型预测";
    self.view.backgroundColor = UIColorFromRGBWithOX(0xebebeb);
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    adjustsScrollViewInsets_NO(self.tableView, self);
}
#pragma mark - Load Data
- (void)loadData {
    _contentArray = [RLSModelPredictionViewModel createModelListArray];
    [self.tableView reloadData];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count * 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        RLSNullTableViewCell *nullCell = [RLSNullTableViewCell cellForTableView:tableView];
        return nullCell;
    } else {
        RLSUniversaListCell *cell = [RLSUniversaListCell cellForTableView:tableView];
        [cell refreshContentData:_contentArray[indexPath.row / 2]];
        return cell;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return [RLSNullTableViewCell heightForCell];
    } else {
       return [RLSUniversaListCell heightForCell];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idnex = indexPath.row / 2;
    switch (idnex) {
        case 0: {
            RLSWebModel *model = [[RLSWebModel alloc]init];
            model.title = @"胜平负";
            model.webUrl = [NSString stringWithFormat:@"%@/appH5/cpspfmode.html", APPDELEGATE.url_ip];
            model.showBuyBtn = YES;
            RLSToolWebViewController *webControl = [[RLSToolWebViewController alloc]init];
            model.modelType = @"cpspfmode-pay.html";
            webControl.model = model;
            [self.navigationController pushViewController:webControl animated:YES];
        }
            break;
        case 1: {
            RLSWebModel *model = [[RLSWebModel alloc]init];
            model.title = @"亚指";
            model.webUrl = [NSString stringWithFormat:@"%@/appH5/cpyamode.html", APPDELEGATE.url_ip];
            model.showBuyBtn = YES;
            RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
            webDetailVC.model = model;
            model.modelType = @"cpyamode-pay.html";
            [self.navigationController pushViewController:webDetailVC animated:YES];
        }
            break;
        case 2: {
            RLSWebModel *model = [[RLSWebModel alloc]init];
            model.title = @"进球数";
            model.webUrl = [NSString stringWithFormat:@"%@/appH5/dxmode.html", APPDELEGATE.url_ip];
            model.showBuyBtn = YES;
            model.modelType = @"dxmode-pay.html";
            RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
            webDetailVC.model = model;
            [self.navigationController pushViewController:webDetailVC animated:YES];
        }
            break;
        default:
            break;
    }
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
@end

#import "RLSToolKitViewController.h"
#import "RLSUniversaListCell.h"
#import "RLSModelPredictionViewModel.h"
#import "RLSNullTableViewCell.h"
#import "RLSToolKitViewModel.h"
#import "RLSBaolengZhishuVC.h"
#import "RLSTongpeiTongjiVC.h"
#import "RLSYapanZhoushouVC.h"
#import "RLSPeilvYichangVC.h"
#import "RLSJiXianVC.h"
#import "RLSPanwangZhishuVC.h"
#import "RLSJiaoYiViewController.h"
#import "RLSBettingVC.h"
@interface RLSToolKitViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic, copy) NSArray *contentArray;
@end
@implementation RLSToolKitViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:YES];
}
#pragma mark - Config UI
- (void)configUI {
    self.navigationItem.title = @"工具";
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
    _contentArray = [RLSToolKitViewModel createModelListArray];
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
            RLSBaolengZhishuVC * jiaoyi = [[RLSBaolengZhishuVC alloc] init];
            [self.navigationController pushViewController:jiaoyi animated:YES];
        }
            break;
        case 1: {
            RLSTongpeiTongjiVC *odd = [[RLSTongpeiTongjiVC alloc] init];
            [self.navigationController pushViewController:odd animated:YES];
        }
            break;
        case 2: {
            RLSYapanZhoushouVC *odd = [[RLSYapanZhoushouVC alloc] init];
           [self.navigationController pushViewController:odd animated:YES];
        }
            break;
        case 3: {
            RLSPeilvYichangVC *odd = [[RLSPeilvYichangVC alloc] init];
            [self.navigationController pushViewController:odd animated:YES];
        }
            break;
        case 4: {
            RLSJiXianVC *jixian = [[RLSJiXianVC alloc] init];
            [self.navigationController pushViewController:jixian animated:YES];
        }
            break;
        case 5: {
            RLSPanwangZhishuVC *record = [[RLSPanwangZhishuVC alloc] init];
            [self.navigationController pushViewController:record animated:YES];
        }
            break;
        case 6: {
            RLSJiaoYiViewController * jiaoyi = [[RLSJiaoYiViewController alloc] init];
            [self.navigationController pushViewController:jiaoyi animated:YES];
        }
            break;
        case 7: {
            RLSBettingVC *odd = [[RLSBettingVC alloc] init];
           [self.navigationController pushViewController:odd animated:YES];
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

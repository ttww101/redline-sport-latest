#define  cellBaolengZhishuVC @"cellBaolengZhishuVC"
#import "RLSBaolengZhishuCell.h"
#import "RLSBaolengDetailVC.h"
#import "RLSBaolengZishuModel.h"
#import "RLSBaolengTable.h"
@interface RLSBaolengTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, retain)NSArray *arrData;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation RLSBaolengTable
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.defaultTitle = @"";
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[RLSBaolengZhishuCell class] forCellReuseIdentifier:cellBaolengZhishuVC];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return self;
}
#pragma mark -- UITableViewDataSource
- (void)updateWithType:(NSInteger)type
{
    _currentIndex = type;
    [self loadBaolengData];
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.mj_header endRefreshing];
        [self loadBaolengData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
    }
    if ([self.defaultTitle isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultTitle isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    NSString *text = self.defaultTitle;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSBaolengZhishuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellBaolengZhishuVC];
    if (!cell) {
        cell = [[RLSBaolengZhishuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellBaolengZhishuVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = [_arrData objectAtIndex:indexPath.row];
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSBaolengDetailVC *baolengDT = [[RLSBaolengDetailVC alloc] init];
    RLSBaolengZishuModel* model = [_arrData objectAtIndex:indexPath.row];
    baolengDT.idId =model.idId;
    baolengDT.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:baolengDT animated:YES];
}
- (void)loadBaolengData
{
    NSString *mtype = @"";
    switch (_currentIndex) {
        case 0:
        {
            mtype = @"0";
        }
            break;
        case 1:
        {
            mtype = @"4";
        }
            break;
        case 2:
        {
            mtype = @"1";
        }
            break;
        case 3:
        {
            mtype = @"2";
        }
            break;
        default:
            break;
    }
    [[RLSDependetNetMethods sharedInstance] requeSurprisestatisWithType:mtype Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] intValue] == 200) {
            self.defaultTitle = @"暂无数据";
            _arrData = [NSArray arrayWithArray:[RLSBaolengZishuModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [self reloadData];
        }else{
        self.defaultTitle = [responseOrignal objectForKey:@"msg"];
            [self reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultTitle = errorDict;
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        [self reloadData];
    }];
}
@end

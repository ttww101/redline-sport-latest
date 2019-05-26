#import "RLSUserTuijianTable.h"
#import "RLSTuijianDatingCell.h"
#define cellUserTuijianTable @"cellUserTuijianTable"
@interface RLSUserTuijianTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic ,assign) NSInteger currentLimitStart;
@end
@implementation RLSUserTuijianTable
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.defaultTitle= @"";
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[RLSTuijianDatingCell class] forCellReuseIdentifier:cellUserTuijianTable];
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return self;
}
- (void)loadNewData
{
    _currentLimitStart = 0;
    [self lodaDataWithLoadtype:loadDataFirst];
}
#pragma mark -- UITableViewDataSource
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentLimitStart = 0;
        [self lodaDataWithLoadtype:loadDataFirst];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _currentLimitStart = _currentLimitStart +20;
        [self lodaDataWithLoadtype:loadDataMoredata];
    }];
    footer.hidden =YES;
    self.mj_footer = footer;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.mj_header beginRefreshing];
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = [UIColor whiteColor];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 10)];
    header.backgroundColor = colorTableViewBackgroundColor;
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSTuijianDatingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserTuijianTable];
    if (!cell) {
        cell = [[RLSTuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserTuijianTable];
    }
    cell.type = typeTuijianCellUser;
    if (_arrData.count>0) {
        cell.model = [_arrData objectAtIndex:indexPath.row];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
     return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer.hidden = NO;
    }else{
        tableView.mj_footer.hidden = YES;
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.contentSize.height > tableView.frame.size.height) {
        tableView.mj_footer.hidden = NO;
    }else{
        tableView.mj_footer.hidden = YES;
    }
}
- (void)lodaDataWithLoadtype:(loadDataType)loadDateType
{
    NSString *limitStart;
    NSString *limitNum;
    switch (loadDateType) {
        case loadDataFirst:
        {
            _arrData = [NSMutableArray array];
            limitStart = @"0";
            limitNum = @"20";
        }
            break;
        case loadDataHeaderRefesh:
        {
            _arrData = [NSMutableArray array];
            limitStart = @"0";
            limitNum = @"20";
        }
            break;
        case loadDataMoredata:
        {
            limitNum = @"20";
            limitStart = [NSString stringWithFormat:@"%ld",(long)_currentLimitStart];
        }
            break;
        default:
            break;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_oddtype] forKey:@"oddstype"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)_userId] forKey:@"userId"];
    [parameter setObject:limitStart forKey:@"limitStart"];
    [parameter setObject:limitNum forKey:@"limitNum"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_newrecommendlistUser] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
        [self.mj_header endRefreshing];
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.defaultTitle = @"暂无推荐，你要做头条吗";
            NSArray *arr =[NSArray arrayWithArray:[RLSTuijiandatingModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            if (arr.count != 0) {
                [_arrData  addObjectsFromArray:arr];
                [self.mj_footer endRefreshing];
            }else{
                [self.mj_footer endRefreshingWithNoMoreData];
            }
            [self reloadData];
        }else{
            self.defaultTitle = [responseOrignal objectForKey:@"msg"];
            [self reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultTitle =errorDict;
        [self reloadData];
        if (_oddtype == 0) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        }
    }];
}
@end

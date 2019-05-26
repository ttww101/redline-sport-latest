#define cellTongPeiTongjiTable @"cellTongPeiTongjiTable"
#import "RLSTongbeiTongjiCell.h"
#import "RLSTongPeiTongjiTable.h"
#import "RLSTongPeiDetailVC.h"
@interface RLSTongPeiTongjiTable()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, retain)NSArray *arrTitle;
@end
@implementation RLSTongPeiTongjiTable
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.defaultTitle = @"";
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[RLSTongbeiTongjiCell class] forCellReuseIdentifier:cellTongPeiTongjiTable];
        self.delegate =self;
        self.dataSource = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return self;
}
- (void)updateWithType:(NSInteger)type
{
    _arrTitle =@[@"全部",@"热门",@"竞彩",@"北单",] ;
    _currentIndex = 0;
    _type = type;
    [self loadTongpeiZhishuData];
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.mj_header endRefreshing];
        [self loadTongpeiZhishuData];
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    header.backgroundColor = [UIColor whiteColor];
    CGFloat wid = Width/_arrTitle.count;
    for (int i =0; i < _arrTitle.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(wid * i, 0, wid, 44);
        [btn setTitle:_arrTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:color66 forState:UIControlStateNormal];
        [btn setTitleColor:color33 forState:UIControlStateSelected];
        if (i == _currentIndex) {
            [btn.titleLabel setFont: BoldFont4(fontSize14)];
        }else{
            [btn.titleLabel setFont: font14];
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:btn];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Width, 0.5)];
    lineView.backgroundColor = colorDD;
    [header addSubview:lineView];
    return header;
}
- (void)clickBtn:(UIButton *)btn
{
    _currentIndex = btn.tag;
    [self loadTongpeiZhishuData];
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
    RLSTongbeiTongjiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTongPeiTongjiTable];
    if (!cell) {
        cell = [[RLSTongbeiTongjiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTongPeiTongjiTable];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = _type;
    if (_arrData.count >0) {
        cell.model = [_arrData objectAtIndex:indexPath.row];
    }
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSTongPeiDetailVC *tongPDT = [[RLSTongPeiDetailVC alloc] init];
    RLSTongPeiTJModel *model;
    if (_arrData.count > 0) {
        model = [_arrData objectAtIndex:indexPath.row];
    }
    tongPDT.scheduleId = model.scheduleId;
    tongPDT.sclassId = model.sclassId;
    tongPDT.pelvIndex = _type;
    tongPDT.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:tongPDT animated:YES];
}
- (void)loadTongpeiZhishuData
{
    NSMutableDictionary *patameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
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
    [patameter setObject:mtype forKey:@"type"];
    [patameter setObject:[NSString stringWithFormat:@"%ld",_type + 1] forKey:@"playType"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:patameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_sameOdd_index] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrData = [NSArray arrayWithArray:[RLSTongPeiTJModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"] ]];
            self.defaultTitle = @"暂无数据";
            [self reloadData];
        }else{
            self.defaultTitle = [responseOrignal objectForKey:@"msg"];
            [self reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        self.defaultTitle = errorDict;
        [self reloadData];
    }];
}
@end

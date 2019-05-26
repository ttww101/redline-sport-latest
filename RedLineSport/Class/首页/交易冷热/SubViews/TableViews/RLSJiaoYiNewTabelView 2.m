#import "RLSJiaoYiNewTabelView.h"
#import "RLSJiaoYiNewCell.h"
#import "RLSLiveScoreModel.h"
#import "RLSFenxiPageVC.h"
@interface RLSJiaoYiNewTabelView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign)BOOL isToFenxi;
@property (nonatomic, retain)NSArray *dataArr;
@property (nonatomic, retain)NSArray *arrTitle;
@property (nonatomic, assign) NSInteger currentType;
@end
@implementation RLSJiaoYiNewTabelView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self == [super initWithFrame:frame style:style]) {
        self.defaultTitle = @"";
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate =self;
        self.dataSource  = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.showsVerticalScrollIndicator = NO;
        _isToFenxi = NO;
        [self setupTableViewMJHeader];
    }
    return self;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDataJiaoyi];
        [self.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}
- (void)updateWithType:(NSInteger)type
{
    _arrTitle =@[@"全部",@"热门",@"竞彩",@"北单",] ;
    _currentIndex = 0;
    _currentType = type;
    [self getDataJiaoyi];
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
    return NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataArr.count == 0) {
        return 0;
    }
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.dataArr.count == 0) {
        return [UIView new];
    }
    UIView *basView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30 )];
    basView.backgroundColor = [UIColor whiteColor];
    CGFloat wid = 200/3;
    UILabel *labOne = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 40, 30)];
    labOne.font = font12;
    labOne.textColor = color99;
    labOne.text = @"比赛";
    [basView addSubview:labOne];
    UILabel *labBiLi = [[UILabel alloc] initWithFrame:CGRectMake(Width - 15 - wid - 10, 0, wid  + 6, 30)];
    labBiLi.font = font12;
    labBiLi.textColor = color99;
    if (self.currentType == 3) {
        labBiLi.text = @"总交易量";
    }else{
        labBiLi.text = @"盈亏";
    }
    labBiLi.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labBiLi];
    UILabel *labJY = [[UILabel alloc] initWithFrame:CGRectMake(Width - 15 - wid*2 - 20, 0, wid + 14, 30)];
    labJY.font = font12;
    labJY.textColor = color99;
    labJY.text = @"交易量";
    labJY.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labJY];
    UILabel *labCj = [[UILabel alloc] initWithFrame:CGRectMake(Width - 15 - wid * 3, 0, wid - 20, 30)];
    labCj.font = font12;
    labCj.textColor = color99;
    labCj.text = @"成交价";
    labCj.textAlignment = NSTextAlignmentCenter;
    [basView addSubview:labCj];
    UIView *lienView = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5 + 0, Width, 0.5)];
    lienView.backgroundColor = colorDD;
    [basView addSubview:lienView];
    return basView;
}
- (void)clickBtn:(UIButton *)btn
{
    _currentIndex = btn.tag;
    [self getDataJiaoyi];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 118;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *acell = @"acell";
    RLSJiaoYiNewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[RLSJiaoYiNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    cell.type = self.currentType;
    cell.model = _dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RLSJiaoYiModel *model = _dataArr[indexPath.row];
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
    }else{
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"3" forKey:@"flag"];
    [parameter setObject:@(model.sid) forKey:@"sid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            RLSLiveScoreModel *model = [RLSLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
            model.neutrality = NO;
            RLSFenxiPageVC *fenxiVC = [[RLSFenxiPageVC alloc] init];
            fenxiVC.segIndex = 4;
            fenxiVC.model = model;
            fenxiVC.currentIndex = 1;
            fenxiVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
        }
        _isToFenxi = NO;
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isToFenxi = NO;
    }];
}
- (void)getDataJiaoyi
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(1) forKey:@"flag"];
    [parameter setObject:@(_currentType) forKey:@"type"];
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
    [parameter setObject:mtype forKey:@"mtype"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_JiaoYiList] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] intValue] == 200) {
            self.dataArr = [NSArray arrayWithArray:[RLSJiaoYiModel arrayOfEntitiesFromArray:responseOrignal[@"data"]]] ;
            self.defaultTitle = @"暂无数据";
            [self reloadData];
        }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
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

#import "RLSTuijianDatingTableView.h"
#import "RLSTuijianSelectedItemView.h"
#define CellTuijianDating @"CellTuijianDating"
#define cellJingcaiListCell @"cellJingcaiListCell"
@interface RLSTuijianDatingTableView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) NSMutableArray *arrDataJingcai;
@property (nonatomic, strong) UITableViewCell *seleCell;
@property (nonatomic, assign) NSInteger currentIndex;
@end
@implementation RLSTuijianDatingTableView
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[RLSTuijianDatingCell class] forCellReuseIdentifier:CellTuijianDating];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource =self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.defaultTitle = @"";
        if (_type == typeTuijianCellDating) {
        }
        [self setupHeader];
        if (_type == typeTuijianCellDating) {
        }
        [self reloadData];
    }
    return self;
}
- (void)setModel:(RLSLiveScoreModel *)model
{
    _model = model;
    [self lodaDataAnalysisTJ];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
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
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -80;
    return 0;
}
- (void)setupHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshDataByHeader)];
    header.stateLabel.font = font13;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
}
- (void)refreshDataByHeader
{
    [self lodaDataAnalysisTJ];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self];
    NSIndexPath * indexPath = [self indexPathForRowAtPoint:point];
    _seleCell=[self cellForRowAtIndexPath:indexPath];
    _seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    _seleCell.backgroundColor = [UIColor whiteColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(Width*4, 0, Width, 60)];
    viewHeader.backgroundColor = [UIColor whiteColor];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"专家推荐",@"竞猜投注"]];
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    [segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    segment.frame = CGRectMake(0, 15, 85*3, 30);
    segment.center = CGPointMake(Width/2, segment.center.y);
    segment.tintColor = redcolor;
    segment.selectedSegmentIndex = _currentIndex;
    [segment addTarget:self action:@selector(changIndex:) forControlEvents:UIControlEventValueChanged];
    [viewHeader addSubview:segment];
    return nil;
}
- (void)changIndex:(UISegmentedControl *)segment
{
    _currentIndex = segment.selectedSegmentIndex;
    self.defaultTitle = @"";
    if (_currentIndex == 0) {
        if (_arrData.count == 0) {
            [self lodaDataAnalysisTJ];
        }else{
            [self reloadData];
        }
    }else{
        if (_arrDataJingcai.count == 0) {
            [self lodaDataAnalysisTJ];
        }else{
            [self reloadData];
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentIndex == 0) {
        return _arrData.count;
    }
    return _arrDataJingcai.count;
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 0) {
        RLSTuijianDatingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTuijianDating];
        if (!cell) {
            cell = [[RLSTuijianDatingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellTuijianDating];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        if (_arrData.count>0) {
            cell.type = typeTuijianCellFenxi;
            cell.model = [_arrData objectAtIndex:indexPath.row];
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = colorF5;
        return cell;
    }else{
    }
    return [UITableViewCell new];
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 0) {
        if (_arrData.count<=0) {
            return 0;
        }
        return 150;
    }else{
        if (_arrDataJingcai.count<=0) {
            return 0;
        }
        return 153;
    }
    return 0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_type == typeTuijianCellFenxi) {
        if (!_cellCanScroll) {
            scrollView.contentOffset = CGPointZero;
        }
        if (scrollView.contentOffset.y <= 0) {
            _cellCanScroll = NO;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTableViewFrame" object:nil];
        }
    }
}
#pragma mark ----- 推荐比赛的数据
- (void)lodaDataAnalysisTJ
{
    if (_currentIndex == 0) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [dict setObject:@(self.model.mid) forKey:@"matchId"];
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_recommmendlistOneSchedule] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            [self.mj_header endRefreshing];
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                self.arrData = [[NSMutableArray alloc] initWithArray:[RLSTuijiandatingModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"news"]]];
                self.defaultTitle =  @"暂无推荐，你要做头条吗";
                [self reloadData];
            }else{
                self.defaultTitle =  [responseOrignal objectForKey:@"msg"];
                [self reloadData];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            self.defaultTitle =  errorDict;
            [self reloadData];
        }];
    }else{
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [dict setObject:@(self.model.mid) forKey:@"scheduleId"];
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:dict PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ontMatchQuiz] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
            [self.mj_header endRefreshing];
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                self.arrDataJingcai = [[NSMutableArray alloc] initWithArray:[RLSTuijiandatingModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"] ]];
                self.defaultTitle =  @"暂无竞猜，你要做头条吗";
                [self reloadData];
            }else{
                self.defaultTitle =  [responseOrignal objectForKey:@"msg"];
                [self reloadData];
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            self.defaultTitle =  errorDict;
            [self reloadData];
        }];
    }
 }
@end

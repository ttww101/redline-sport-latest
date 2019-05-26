#define  cellGuanzhuViewController @"cellGuanzhuViewController"
#import "RLSSaiTableViewCell.h"
#import "RLSLiveScoreModel.h"
#import "RLSGuanzhuViewController.h"
#import "RLSSelectedDateTitleView.h"
#import "DatePickerView.h"


@interface RLSGuanzhuViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate, SelectedDateTitleViewDelegate, DatePickerViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) RLSSelectedDateTitleView *dataTitleView;
@property (nonatomic, strong) NSMutableArray *arrDataQici;

@end

@implementation RLSGuanzhuViewController

#pragma mark - DatePickerViewDelegate

- (void)didSelectedDate:(NSString *)selectDate {
    _date = [selectDate copy];
    [self getAttention];
    
}

#pragma mark SelectedDateTitleViewDelegate

- (void)RLSSelectedDateTitleViewDidAction:(NSArray *)array {
    DatePickerView *picker =  [DatePickerView showDatePicker:array title:@"近七天关注赛事"];
    picker.delegate = self;
}


#pragma mark - Lazy Load

- (RLSSelectedDateTitleView *)dataTitleView
{
    if (!_dataTitleView) {
        _dataTitleView = [[RLSSelectedDateTitleView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44+60+14, Width, 60 / 2 + 9)];
        _dataTitleView.delegate = self;
    }
    return _dataTitleView;
}

#pragma mark - ************  以下高人所写  ************


- (id)init
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.dataTitleView];
        [self.view addSubview:self.tableView];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAttention];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getAttention) name:@"reloadAttention" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44 +60 + 39+ 14, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar -44 - APPDELEGATE.customTabbar.height_myTabBar - 39- 14-60) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[RLSSaiTableViewCell class] forCellReuseIdentifier:cellGuanzhuViewController];
        [self setupHeaderView];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [_tableView reloadData];
    }
    return _tableView;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.tableView.mj_header beginRefreshing];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes;
        if (self.arrData.count == 0) {
            attributes= @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
        }else{
            attributes= @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        }
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"] ) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = colorF5;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint point = [scrollView.panGestureRecognizer locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *seleCell=[self.tableView cellForRowAtIndexPath:indexPath];
    seleCell.backgroundColor = [UIColor whiteColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)setupHeaderView {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.font = font13;
    self.tableView.mj_header = header;
}

- (void)headerRefreshData{
    [self getAttention];
    [self.tableView.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellGuanzhuViewController];
    if (!cell) {
        cell = [[RLSSaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellGuanzhuViewController];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.arrData.count > 0) {
        cell.ScoreModel = [self.arrData objectAtIndex:indexPath.row];
        cell.contentView.backgroundColor = colorfbfafa;
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.backgroundColor = [UIColor whiteColor];
    UIView *marginView = [UIView new];
    marginView.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:marginView];
    [marginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(cell.contentView);
        make.height.mas_equalTo(5);
    }];
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrData.count > 0) {
        RLSLiveScoreModel *model = [_arrData objectAtIndex:indexPath.row];
        if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
            return 108;
        }
        return 80;
    }
    return 0;
}

- (void)getAttention
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:PARAM_IS_NIL_ERROR(_date) forKey:@"day"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_focusd_matches] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrData = [[NSMutableArray alloc] initWithArray:[RLSLiveScoreModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matches"]]];
             _arrDataQici = [[NSMutableArray alloc] initWithArray:[RLSQiciModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"dates"]]];
            if (_arrDataQici.count == 0) {
                [_arrData removeAllObjects];
                [self.tableView reloadData];
                return ;
            }
            
            NSString *nums = [[[responseOrignal objectForKey:@"data"] objectForKey:@"focusNum"] stringValue];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"attentionNum" object:nil userInfo:@{@"num":PARAM_IS_NIL_ERROR(nums)}];
            _dataTitleView.arrData = _arrDataQici;
            
            NSString *documentsPath = [RLSMethods getDocumentsPath];
            NSString *arrayPath = [documentsPath stringByAppendingPathComponent:BifenPageAttentionArray];
            NSMutableArray *attentionArray = [NSMutableArray array];
            for (NSInteger i = 0; i < _arrData.count; i ++) {
                RLSLiveScoreModel *model = _arrData[i];
                [attentionArray addObject:[NSString stringWithFormat:@"%ld",model.mid]];
            }
            [NSKeyedArchiver archiveRootObject:attentionArray toFile:arrayPath];
            
            [self.tableView reloadData];
            
            [_arrDataQici enumerateObjectsUsingBlock:^(RLSQiciModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.selected) {
                    _date = obj.val;
                    *stop = true;
                }
            }];
            
            
        }else{
            self.defaultFailure = [responseOrignal objectForKey:@"msg"];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        if (self.defaultFailure.length == 0) {
            self.defaultFailure = @"";
        }
        
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
@end

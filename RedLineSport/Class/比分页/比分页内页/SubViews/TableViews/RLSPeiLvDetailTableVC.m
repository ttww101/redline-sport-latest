#import "RLSPeiLvDetailTableVC.h"
#import "RLSpeilvDetailCell.h"
#import "RLSPeiLvDetailModel.h"
#define peilvDetailCellID  @"peilvDetailCell"
@interface RLSPeiLvDetailTableVC ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) UITableView                          *tableView;
@property (nonatomic, strong) NSMutableArray                        *peiLvDetailArr;
@property (nonatomic, strong) NSMutableArray                        *peiLvAfterArr;
@end
@implementation RLSPeiLvDetailTableVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTableView];
    self.defaultFailure = @"";
    self.view.backgroundColor = colorTableViewBackgroundColor;
    if (self.PeiLvCDetailType == isDetailBeforeTwo) {
        [self loadPeiLvDataWithScheid:self.model.mid OddsType:self.oddsType isHalf:self.isHalfType];
    }else{
        [self loadPeiLvAfterDataWithScheid:self.model.mid kid:self.jiaoQiuType];
    }
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[RLSPeiLvDetailCell class] forCellReuseIdentifier:peilvDetailCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        [self setupTableViewMJHeader];
    }
    return _tableView;
}
- (void)buildTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-APPDELEGATE.customTabbar.height_myNavigationBar + 35);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
- (void)setupTableViewMJHeader {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
#pragma mark - EmptyDatasource -
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无相关数据";
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -80;
}
#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.PeiLvCDetailType == isDetailBeforeTwo) {
        return _peiLvDetailArr.count;
    }else{
        return _peiLvAfterArr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RLSPeiLvDetailCell *peilvCell = [tableView cellForRowAtIndexPath:indexPath];
    if (!peilvCell) {
        peilvCell = [[RLSPeiLvDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:peilvDetailCellID];
    }
    while ([peilvCell.contentView.subviews lastObject]!= nil) {
        [[peilvCell.contentView.subviews lastObject] removeFromSuperview];
    }
    if (self.PeiLvCDetailType == isDetailBeforeTwo) {
        if (_peiLvDetailArr.count > 0) {
            RLSPeiLvDetailModel *nowModel = _peiLvDetailArr[indexPath.row];
            if (_peiLvDetailArr.count > 1) {
                if (indexPath.row!= _peiLvDetailArr.count-1) {
                    RLSPeiLvDetailModel *nextModel = _peiLvDetailArr[indexPath.row +1];
                    if (![nowModel.Score isEqualToString:nextModel.Score]) {
                        nowModel.ischangedScore = YES;
                    }
                    if ([nowModel.HomeOdds floatValue]>[nextModel.HomeOdds floatValue]) {
                        nowModel.ischangedHomeOdds = YES;
                    }
                    if (![nowModel.PanKou isEqualToString:nextModel.PanKou]) {
                        nowModel.ischangedPanKou = YES;
                        if ([nowModel.PanKou floatValue]>[nextModel.PanKou floatValue]) {
                            nowModel.Pankoutype=1;
                        }else{
                            nowModel.Pankoutype=2;
                        }
                    }
                    if ([nowModel.AwayOdds floatValue]>[nextModel.AwayOdds floatValue]) {
                        nowModel.ischangedAwayOdds = YES;
                    }
                }
            }
            peilvCell.modelPeiLvDetail = nowModel;
        }
    }else{
        if (_peiLvAfterArr.count > 0) {
            RLSPeiLvDetailModel *nowModel = _peiLvAfterArr[indexPath.row];
            if (_peiLvAfterArr.count > 1) {
                if (indexPath.row!= _peiLvAfterArr.count-1) {
                    RLSPeiLvDetailModel *nextModel = _peiLvAfterArr[indexPath.row +1];
                    if (![nowModel.Score isEqualToString:nextModel.Score]) {
                        nowModel.ischangedScore = YES;
                    }
                    if ([nowModel.HomeOdds floatValue]>[nextModel.HomeOdds floatValue]) {
                        nowModel.ischangedHomeOdds = YES;
                    }
                    if (![nowModel.PanKou isEqualToString:nextModel.PanKou]) {
                        nowModel.ischangedPanKou = YES;
                    }
                    if ([nowModel.AwayOdds floatValue]>[nextModel.AwayOdds floatValue]) {
                        nowModel.ischangedAwayOdds = YES;
                    }
                }
            }
            peilvCell.modelPeiLvDetail = nowModel;
        }
    }
    if (indexPath.row % 2 != 0) {
        peilvCell.backgroundColor = colorEEEEEE;
    }
    peilvCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return peilvCell;
}
#pragma mark - UITableViewDelagate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - beforeTwo -
- (void)loadPeiLvDataWithScheid:(NSInteger)scheid OddsType:(oddsType)oddsType isHalf:(isHalfType)isHalf {
    NSString *baseUrl = @"%@/phone/AnalyOddsDetail.aspx?an=iosQiuTan&av=5.9&from=2&isHalf=%ld&matchTime=&oddsType=%ld&scheid=%ld";
    NSString *lsURl = [NSString stringWithFormat:baseUrl,APPDELEGATE.url_ip,isHalf,oddsType,self.model.mid];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:lsURl Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"responseOrignal=%@",responseOrignal);
        [SVProgressHUD dismiss];
        _peiLvDetailArr = [[NSMutableArray alloc] initWithArray:[RLSPeiLvDetailModel arrayOfEntitiesFromArray:responseOrignal]];
        if (_peiLvDetailArr.count>0) {
            RLSPeiLvDetailModel*model=_peiLvDetailArr[_peiLvDetailArr.count-1];
            model.BlackType=1;
            [_peiLvDetailArr replaceObjectAtIndex:_peiLvDetailArr.count-1 withObject:model];
        }
        [self.tableView reloadData];
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [SVProgressHUD dismiss];
    }];
}
#pragma mark - afterTwo -
- (void)loadPeiLvAfterDataWithScheid:(NSInteger)sid kid:(NSInteger)kind {
    NSString *baseUrl = @"%@/phone/cornerdetail.aspx?an=iosQiuTan&av=6.5&from=2&kind=%ld&lang=0&r=1505876329&sid=%ld&v=0";
    NSString *lsURl = [NSString stringWithFormat:baseUrl,APPDELEGATE.url_ip,kind,self.model.mid];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:nil PathUrlL:lsURl Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",responseOrignal);
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD dismiss];
    }];
}
@end

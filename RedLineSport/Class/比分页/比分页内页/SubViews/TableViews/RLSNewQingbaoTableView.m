#define cellNewQB @"cellNewQB"
#import "RLSNewQingbaoTableView.h"
#import "RLSNewQBTableViewCell.h"
#import "RLSTimeModel.h"
#import "RLSRightSlidetabletableViewCell.h"
#import "LockQingBaoView.h"
#import "RLSToolWebViewController.h"


static NSString * iden = @"testTime";
@interface RLSNewQingbaoTableView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate, LockQingBaoViewDelegate>
@property (nonatomic, assign) CGFloat oldContentY;
@property(strong,nonatomic)NSMutableArray * dataList;
@property (nonatomic , strong) LockQingBaoView *lockView;

@end
@implementation RLSNewQingbaoTableView


#pragma mark - Lazy Load

#pragma mark - LockQingBaoViewDelegate

- (void)LockQingBaoViewTapAction {
    if(![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    RLSWebModel *model = [[RLSWebModel alloc]init];
    model.title = @"开通服务";
    model.hideNavigationBar = false;
    model.webUrl = [NSString stringWithFormat:@"%@/%@/vip-pay.html?scheduleId=%zi&kind=1", APPDELEGATE.url_ip,H5_Host, self.matchID];
    RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
    webDetailVC.model = model;
    [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
}

- (LockQingBaoView *)lockView {
    if (_lockView == nil) {
        _lockView = [[LockQingBaoView alloc]initWithFrame:CGRectMake(0, 35, self.width, Scale_Value(142))];
        _lockView.delegate = self;
    }
    return _lockView;
}

#pragma mark - ************  以下高人所写  ************

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.delegate = self;
    self.dataSource = self;
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    [self registerClass:[RLSNewQBTableViewCell class] forCellReuseIdentifier:cellNewQB];
    [self registerClass:[RLSRightSlidetabletableViewCell class] forCellReuseIdentifier:iden];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor whiteColor];
    self.showsVerticalScrollIndicator = NO;
    [self setupMJ_header];
    [self reloadData];
}


- (void)setFeeDic:(NSDictionary *)feeDic {
    _feeDic = feeDic;
//    if ([_feeDic[@"count"] integerValue] >  0) {
//        self.tableHeaderView = self.lockView;
//        _lockView.infoMap = _feeDic;
//    } else {
        if (_lockView) {
            [_lockView removeFromSuperview];
            self.tableHeaderView = nil;
        }
//    }
}

- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    [self reloadData];
}
- (void)setupMJ_header
{
    MJRefreshNormalHeader *_header  = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshdata)];
    _header.lastUpdatedTimeLabel.hidden = YES;
    _header.stateLabel.font = font13;
    self.mj_header = _header;
}
- (void)setJiDianArr:(NSMutableArray *)jiDianArr {
    _jiDianArr = jiDianArr;
    self.dataList = [NSMutableArray array];
    [self.dataList addObjectsFromArray:jiDianArr];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无情报，你要做头条吗";
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
        return -80;
}
-(void)headerRefreshdata
{
    if (_delegateNewQB && [_delegateNewQB respondsToSelector:@selector(headerRefreshNewQB)]) {
        [_delegateNewQB headerRefreshNewQB];
    };
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4; 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.arrhomeInfo.count;
            break;
        case 1:
            return self.arrneutralInfo.count;
            break;
        case 2:
            return self.arrawayInfo.count;
            break;
        case 3:
            return self.jiDianArr.count;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            RLSInfoListModel *infoModel = [self.arrhomeInfo objectAtIndex:indexPath.row];
            CGFloat heiContent = [RLSMethods getTextHeightStationWidth:[NSString stringWithFormat:@"%@",infoModel.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
            CGFloat heiTitle = [RLSMethods getTextHeightStationWidth:infoModel.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
            
            CGFloat rowHeight = 60 + heiContent + heiTitle;
            return rowHeight;
        }
            break;
        case 1:
        {
            RLSInfoListModel *infoModel = [self.arrneutralInfo objectAtIndex:indexPath.row];
            CGFloat heiContent = [RLSMethods getTextHeightStationWidth:[NSString stringWithFormat:@"%@",infoModel.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
            CGFloat heiTitle = [RLSMethods getTextHeightStationWidth:infoModel.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
            return 60 + heiContent + heiTitle;
        }
            break;
        case 2:
        {
            RLSInfoListModel *infoModel = [self.arrawayInfo objectAtIndex:indexPath.row];
            CGFloat heiContent = [RLSMethods getTextHeightStationWidth:[NSString stringWithFormat:@"%@",infoModel.content] anWidthTxtt:Width - 30 anfont:14 andLineSpace:5.5 andHeaderIndent:0];
            CGFloat heiTitle = [RLSMethods getTextHeightStationWidth:infoModel.title anWidthTxtt:Width - 30 anfont:20 andLineSpace:5 andHeaderIndent:0];
            return 60 + heiContent + heiTitle;
        }
            break;
        case 3:
        {
            RLSTimeModel * model = self.jiDianArr[indexPath.row];
            NSDictionary * fontDic = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGSize size1 = CGSizeMake(WIDTH_OF_PROCESS_LABLE, 0);
            CGSize titleLabelSize=[model.title boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
            return titleLabelSize.height + 40;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSNewQBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellNewQB];
    if (!cell) {
        cell = [[RLSNewQBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellNewQB];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.section) {
            case 0:
            {
                RLSInfoListModel *infoModel = [self.arrhomeInfo objectAtIndex:indexPath.row];
                cell.model = infoModel;
            }
                break;
            case 1:
            {
                RLSInfoListModel *infoModel = [self.arrneutralInfo objectAtIndex:indexPath.row];
                cell.model = infoModel;
            }
                break;
            case 2:
            {
                RLSInfoListModel *infoModel = [self.arrawayInfo objectAtIndex:indexPath.row];
                cell.model = infoModel;
            }
                break;
            case 3:
            {
                RLSRightSlidetabletableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
                if (!cell) {
                    cell = [[RLSRightSlidetabletableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
                }
                    RLSTimeModel * timemodel = self.dataList[indexPath.row];
                    cell.model = timemodel;
                return cell;
            }
                break;
            default:
                break;
        }
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return self.arrhomeInfo.count== 0? 0.00001: 35;
            break;
        case 1:
            return self.arrneutralInfo.count == 0? 0.00001: 35;
            break;
        case 2:
            return self.arrawayInfo.count == 0? 0.00001: 35;
            break;
        case 3:
            return self.jiDianArr.count == 0? 0.00001 : 35;
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            if (self.arrhomeInfo.count == 0) {
                return nil;
            }
        }
            break;
        case 1:
        {
            if (self.arrneutralInfo.count == 0) {
                return nil;
            }
        }
            break;
        case 2:
        {
            if (self.arrawayInfo.count == 0) {
                return nil;
            }
        }
            break;
        case 3:
        {
            if (self.jiDianArr.count == 0) {
                return nil;
            }
        }
            break;
        default:
            break;
    }
    UIView *header= [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 35)];
    header.backgroundColor = colorf5f5f5;
    switch (section) {
        case 0:
        {
            RLSInfoListModel *infoModel = [self.arrhomeInfo objectAtIndex:0];
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 104, 35)];
            labName.font = font14;
            labName.text = infoModel.HomeTeam;
            labName.textColor = redcolor;
            [header addSubview:labName];
        }
            break;
        case 1:
        {
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 104, 35)];
            labName.font = font14;
            labName.textColor = color33;
            labName.text = @"中立";
            [header addSubview:labName];
        }
            break;
        case 2:
        {
            RLSInfoListModel *infoModel = [self.arrawayInfo objectAtIndex:0];
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 104, 35)];
            labName.font = font14;
            labName.text = infoModel.GuestTeam;
            labName.textColor = blue1Color;
            [header addSubview:labName];
        }
            break;
        case 3:
        {
            UIView *rolView = [[UIView alloc] initWithFrame:CGRectMake(15, 12, 12, 12)];
            rolView.backgroundColor = redcolor;
            rolView.layer.cornerRadius = 6;
            UILabel *labName =  [[UILabel alloc] initWithFrame:CGRectMake(37, 0, Width - 104, 35)];
            labName.text = @"提点数据";
            labName.font = font14;
            labName.textColor = redcolor;
            [header addSubview:rolView];
            [header addSubview:labName];
        }
            break;
        default:
            break;
    }
    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(0, 35, Width, 0.5)];
    viewRight.backgroundColor = colorDD;
    [header addSubview:viewRight];
    return header;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
    footer.backgroundColor = [UIColor whiteColor];
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
    viewLine.backgroundColor = colorTableViewBackgroundColor;
    [footer addSubview:viewLine];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_cellCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        _cellCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTableViewFrame" object:nil];
    }
}
@end

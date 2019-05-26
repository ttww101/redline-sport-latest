#import "RLSBangDanTableView.h"
#import "RLSBangDanListCell.h"
@interface RLSBangDanTableView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@end
@implementation RLSBangDanTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.defaultTitle = @"";
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate =self;
        self.dataSource  = self;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
    }
    return self;
}
- (void)setArrData:(NSArray *)arrData{
    _arrData = arrData;
    [self.mj_header endRefreshing];
    if (arrData.count != 0) {
       [self reloadData];
    }
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrData.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.arrData.count == 0) {
        return 0;
    }
    return 28;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.arrData.count == 0) {
        return [UIView new];
    }
    UIView *BkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 28)];
    BkView.backgroundColor = [UIColor whiteColor];
    UILabel *labNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 48, 28)];
    labNum.font = font12;
    labNum.textColor = color66;
    labNum.textAlignment = NSTextAlignmentCenter;
    labNum.text = @"排名";
    [BkView addSubview:labNum];
    UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(98, 0, 90, 28)];
    labName.font = font12;
    labName.textColor = color66;
    labName.text = @"用户";
    [BkView addSubview:labName];
    UILabel *labWin = [[UILabel alloc] initWithFrame:CGRectMake(Width - 99, 0, 50, 28)];
    labWin.font = font12;
    labWin.textColor = color66;
    labWin.textAlignment = NSTextAlignmentCenter;
    labWin.text = self.labStr;
    [BkView addSubview:labWin];
    if (self.typeNum == 2) {
        labWin.frame = CGRectMake(Width - 99 - 20, 0, 50, 28);
    }
    UILabel *labWinTwo = [[UILabel alloc] initWithFrame:CGRectMake(Width - 99 - 5 - 50, 0, 50, 28)];
    labWinTwo.font = font12;
    labWinTwo.textColor = color66;
    labWinTwo.textAlignment = NSTextAlignmentCenter;
    labWinTwo.text = self.labStrTwo;
    [BkView addSubview:labWinTwo];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 27.5, Width, 0.5)];
    lineView.backgroundColor = cellLineColor;
    [BkView addSubview:lineView];
    return BkView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *acell = @"acell";
    RLSBangDanListCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[RLSBangDanListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = colorF5;
    cell.type = self.typeNum;
    cell.model = self.arrData[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
@end

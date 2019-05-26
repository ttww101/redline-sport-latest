#define cellSelecterMatchView @"cellSelecterMatchView"
#import "RLSSelecterMatchView.h"
@interface RLSSelecterMatchView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIGestureRecognizerDelegate>
@end
@implementation RLSSelecterMatchView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *viewB = [[UIView alloc] initWithFrame:self.bounds];
        viewB.alpha = 0.5;
        viewB.backgroundColor = [UIColor blackColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchTap)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self addSubview:viewB];
        [self addSubview:self.tableView];
    }
    return self;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return YES;
}
- (void)touchTap
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchTapView)]) {
        [_delegate touchTapView];
    }
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    [self.tableView reloadData];
    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellSelecterMatchView];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (void)setupTableViewMJHeader
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无赛事";
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSelecterMatchView];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSelecterMatchView];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *viewN = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    viewN.backgroundColor = [UIColor whiteColor];
    UILabel *labN = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width  - 30, 44)];
    labN.textColor = color33;
    labN.font = font16;
    labN.textAlignment = NSTextAlignmentCenter;
    if (_arrData.count > 0) {
        labN.text = [_arrData objectAtIndex:indexPath.row];
    }
    [viewN addSubview:labN];
    UIImageView *imageN = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15  - 20, 0, 18, 13)];
    imageN.center = CGPointMake(imageN.center.x, viewN.height/2);
    imageN.image = [UIImage imageNamed:@"clear"];
    [viewN addSubview:imageN];
    UIView *viewBN = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width, 0.5)];
    viewBN.backgroundColor = colorDD;
    [viewN addSubview:viewBN];
    cell.backgroundView = viewN;
    UIView *viewS = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    viewS.backgroundColor = [UIColor whiteColor];
    UILabel *labS = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width  - 30, 44)];
    labS.textColor = redcolor;
    labS.font = font16;
    if (_arrData.count > 0) {
        labS.text = [_arrData objectAtIndex:indexPath.row];
    }
    labS.textAlignment = NSTextAlignmentCenter;
    [viewS addSubview:labS];
    UIImageView *imageS = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15  - 20, 0, 18, 13)];
    imageS.center = CGPointMake(imageN.center.x, viewN.height/2);
    imageS.image = [UIImage imageNamed:@"clear"];
    [viewS addSubview:imageS];
    UIView *viewBS = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width, 0.5)];
    viewBS.backgroundColor = colorDD;
    [viewS addSubview:viewBS];
    cell.selectedBackgroundView = viewS;
    return cell;
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(RLSSelecterMatchView:selectedAtIndex:)]) {
        [_delegate RLSSelecterMatchView:self selectedAtIndex:indexPath.row];
    }
}
@end

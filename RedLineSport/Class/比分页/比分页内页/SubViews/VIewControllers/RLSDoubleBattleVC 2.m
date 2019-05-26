#import "RLSDoubleBattleVC.h"
#import "RLSDoubleBattlecell.h"
#define doubleBattleCell @"RLSDoubleBattlecell"
@interface RLSDoubleBattleVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) NSMutableArray        *doubleTitleArr;
@end
@implementation RLSDoubleBattleVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTableView];
}
- (NSMutableArray *)doubleTitleArr {
    if (!_doubleTitleArr) {
        _doubleTitleArr = [NSMutableArray arrayWithObjects:@"首发阵容",@"替补阵容", nil];
    }
    return _doubleTitleArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerClass:[RLSDoubleBattlecell class] forCellReuseIdentifier:doubleBattleCell];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [self.tableView reloadData];
    }
    return _tableView;
}
- (void)buildTableView {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(Width);
    }];
}
#pragma mark - UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.doubleTitleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@",self.doubleTitleArr[section]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RLSDoubleBattlecell *battleCell = [tableView dequeueReusableCellWithIdentifier:doubleBattleCell forIndexPath:indexPath];
    battleCell.battlModel = [RLSBattleModel new];
    return battleCell;
}
#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.font = [UIFont systemFontOfSize:14];
    header.contentView.backgroundColor = colorEEEEEE;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

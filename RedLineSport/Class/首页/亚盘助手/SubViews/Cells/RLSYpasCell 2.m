#import "RLSTeamViewOfPlycCell.h"
#import "RLSYpasCell.h"
#import "RLSPeilvViewofYapsCell.h"
#import "RLSNewZhiShuWebVC.h"
@interface RLSYpasCell()
@property (nonatomic, assign) BOOL isaddlayout;
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) RLSTeamViewOfPlycCell *teamView;
@property (nonatomic, strong) RLSPeilvViewofYapsCell *peilvView;
@property (nonatomic, strong) UIView *viewLine;
@property (nonatomic, assign) BOOL isToFenxi;
@end
@implementation RLSYpasCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(RLSPlycModel *)model
{
    _model = model;
    [self.contentView addSubview:self.basicView];
    if (!_isaddlayout) {
        _isaddlayout = YES;
        [self addlayout];
    }
    [self.peilvView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width, 59 + _model.panProcess.count*20));
    }];
    _teamView.type = 2;
    _teamView.model = _model;
    _peilvView.model = _model;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tofenxi)];
        [_basicView addGestureRecognizer:tap];
        [_basicView addSubview:self.teamView];
        [_basicView addSubview:self.peilvView];
        [_basicView addSubview:self.viewLine];
    }
    return _basicView;
}
- (RLSTeamViewOfPlycCell *)teamView
{
    if (!_teamView) {
        _teamView = [[RLSTeamViewOfPlycCell alloc] init];
    }
    return _teamView;
}
- (RLSPeilvViewofYapsCell *)peilvView
{
    if (!_peilvView) {
        _peilvView = [[RLSPeilvViewofYapsCell alloc] init];
    }
    return _peilvView;
}
- (UIView *)viewLine
{
    if (!_viewLine) {
        _viewLine = [[UIView alloc] init];
        _viewLine.backgroundColor = colorTableViewBackgroundColor;
    }
    return _viewLine;
}
- (void)addlayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [self.teamView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.top.equalTo(self.basicView.mas_top);
        make.size.mas_equalTo(CGSizeMake(Width, 59));
    }];
    [self.peilvView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.top.equalTo(self.teamView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 59 + _model.panProcess.count*20));
    }];
    [self.viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.basicView.mas_left);
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(Width, 10));
    }];
}
- (void)tofenxi
{
    RLSNewZhiShuWebVC *listWeb = [[RLSNewZhiShuWebVC alloc] init];
    listWeb.dic = [NSDictionary dictionaryWithObjectsAndKeys:@(_model.companyId),@"companyid",_model.companyName,@"companyname",_typeOdd == 0? @"5":@"6",@"flagid",@(_model.oddsId),@"oddsid",@(_model.scheduleId),@"sid", nil];
    listWeb.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:listWeb animated:YES];
}
- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    if (!_isToFenxi == YES) {
        _isToFenxi = YES;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                RLSLiveScoreModel *model = [RLSLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                model.neutrality = NO;
                RLSFenxiPageVC *fenxiVC = [[RLSFenxiPageVC alloc] init];
                fenxiVC.model = model;
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                fenxiVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:fenxiVC animated:YES];
            }
            _isToFenxi = NO;
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
        }];
    }else{
    }
}
@end

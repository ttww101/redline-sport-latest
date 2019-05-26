#import "RLSSelectedJincaiVC.h"
#import "RLSAllSelectedView.h"
#import "RLSBIfenSelectedSaishiModel.h"
#import "RLSSelectedCCell.h"
#define cellCollectioneSlectedJincai @"cellCollectioneSlectedJincai"
#define headerCollectioneSlectedJincai @"headerCollectioneSlectedJincai"
#define cellCollectionHeight (29)
#define cellCollectionWidth ((Width - 25 - 20 - 30)/3)
@interface RLSSelectedJincaiVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AllSelectedViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RLSAllSelectedView *allselectedV;
@property (nonatomic, assign) BOOL allBtnIsSelected;

@property (nonatomic, strong) NSMutableArray<RLSBIfenSelectedSaishiModel *> *dataList;


@end
@implementation RLSSelectedJincaiVC

- (void)loadData {
    [RLSLodingAnimateView showLodingView];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.filterParameters) forKey:@"filter"];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.timeline) forKey:@"timeline"];
    [parameter setValue:self.tab forKey:@"tab"];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.date) forKey:@"date"];
     NSString *path = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_filterAll];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:path Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal[@"data"];
            FilterModel *model = [FilterModel yy_modelWithDictionary:dic];
            self.dataList = [model.items mutableCopy];
            [self.collectionView reloadData];
            [self checkoutAllSelected];
        } else {

        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showErrorWithStatus:errorDict];
        [RLSLodingAnimateView dissMissLoadingView];
    }];
    
}

- (void)checkoutAllSelected {
    BOOL isAllSelected = true;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        RLSBIfenSelectedSaishiModel *bifenmodel = self.dataList[i];
        if (!bifenmodel.isSelected) {
            isAllSelected = false;
            break;
        }
    }
    _allselectedV.btnAll.selected = isAllSelected;
}

#pragma mark - Lazy Load

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;;
}


#pragma mark - ************   ************

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.allselectedV];
    self.allselectedV.btnAll.selected = _allBtnIsSelected;
    [self.view addSubview:self.collectionView];
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (RLSAllSelectedView *)allselectedV
{
    if (!_allselectedV) {
        _allselectedV = [[RLSAllSelectedView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 44)];
        _allselectedV.delegate = self;
    }
    return _allselectedV;
}

- (void)didSelectedAtBtnIndex:(NSInteger)index whtherSelected:(BOOL)selected
{
    if (index == 0) {
        [self.dataList enumerateObjectsUsingBlock:^(RLSBIfenSelectedSaishiModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              obj.isSelected = true;
        }];
        [self.collectionView reloadData];
    }else if (index == 1) {
        [self.dataList enumerateObjectsUsingBlock:^(RLSBIfenSelectedSaishiModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = false;
        }];
        [self.collectionView reloadData];
    }else if (index == 2) {
        if (_allselectedV.btnAll.selected && [self.timeline isEqualToString:@"live"]) {
            [_delegate confirmSelectedJincaiWithData:nil];
        } else {
            if (_delegate && [_delegate respondsToSelector:@selector(confirmSelectedJincaiWithData:)]) {
                NSMutableArray *arrMemory = [NSMutableArray arrayWithArray:self.dataList];
                NSMutableArray *arrSend = [NSMutableArray array];
                for (int i = 0 ;i<arrMemory.count; i++) {
                    RLSBIfenSelectedSaishiModel *model = [arrMemory objectAtIndex:i];
                    if (model.isSelected) {
                        [arrSend addObject:model];
                    }
                }
                [_delegate confirmSelectedJincaiWithData:arrSend];
            }
        }
    }
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(Width, 0);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.collectionView];
        [self.view bringSubviewToFront:self.collectionView];
        [self.collectionView registerClass:[RLSSelectedCCell class] forCellWithReuseIdentifier:cellCollectioneSlectedJincai];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedJincai];
    }
    return _collectionView;
}
#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RLSSelectedCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellCollectioneSlectedJincai forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    else{
    }
    RLSBIfenSelectedSaishiModel *model = [self.dataList objectAtIndex:indexPath.row];
    cell.cellSize = CGSizeMake(cellCollectionWidth, cellCollectionHeight);
    cell.model = model;
    cell.selected = model.isSelected;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedJincai forIndexPath:indexPath];
    headerView.backgroundColor = colorTableViewBackgroundColor;
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    RLSBIfenSelectedSaishiModel *model = [self.dataList objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [_allselectedV changeBtnSelectedState:model.isSelected];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
    [self checkoutAllSelected];
}
#pragma mark --  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellCollectionWidth,cellCollectionHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 12, 12, 30);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}
@end

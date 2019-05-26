#import "RLSSelectedAllVC.h"
#import "RLSAllSelectedView.h"
#import "RLSDSCollectionViewIndex.h"
#import "RLSBIfenSelectedSaishiModel.h"
#import "RLSSelectedCCell.h"
#define CollectionCellSelectedAllVC @"CollectionCellSelectedAllVC"
#define CollectionHeaderSelectedAllVC @"CollectionHeaderSelectedAllVC"
#define cellTabelViewIndex @"cellTabelViewIndex"
#define cellCollectionHeight (29)
#define cellCollectionWidth ((Width - 25 - 20 - 30)/3)
@interface RLSSelectedAllVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AllSelectedViewDelegate,DSCollectionViewIndexDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RLSAllSelectedView *allselectedV;
@property (nonatomic, strong) NSArray *arrViewIndex;
@property (nonatomic, strong) RLSDSCollectionViewIndex *ViewIndex;
@property (nonatomic, assign) BOOL allBtnIsSelected;
@property (nonatomic, strong) UILabel *flotageLabel;
@property (nonatomic, strong) NSMutableArray<FilterData *> *dataList;

@end
@implementation RLSSelectedAllVC

#pragma mark - Load Data

- (void)loadData {
    [RLSLodingAnimateView showLodingView];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.filterParameters) forKey:@"filter"];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.timeline) forKey:@"timeline"];
    [parameter setValue:@"sclass" forKey:@"tab"];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.sub) forKey:@"sub"];
    [parameter setValue:PARAM_IS_NIL_ERROR(self.date) forKey:@"date"];
//    NSString *path = [NSString stringWithFormat:@"http://120.55.30.173:8809%@",url_bifen_filterAll];
     NSString *path = [NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_bifen_filterAll];
    
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:path Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal[@"data"];
            FilterModel *model = [FilterModel yy_modelWithDictionary:dic];
            if (model.hot_items.count > 0) {
                FilterData *hotModel = [[FilterData alloc]init];
                hotModel.dataList = model.hot_items;
                hotModel.title = @"热门赛事";
                [self.dataList addObject:hotModel];
            }
            
            if (model.other_items.count > 0) {
                FilterData *allModel = [[FilterData alloc]init];
                allModel.dataList = model.other_items;
                allModel.title = @"其它赛事";
                [self.dataList addObject:allModel];
            }
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
        FilterData *model = self.dataList[i];
        for (NSInteger j = 0 ; j < model.dataList.count; j ++) {
            RLSBIfenSelectedSaishiModel *bifenmodel = model.dataList[j];
            if (!bifenmodel.isSelected) {
                isAllSelected = false;
                break;
            }
        }
    }
    _allselectedV.btnAll.selected = isAllSelected;
    
    BOOL isAllNotSelected = true;
    for (NSInteger i = 0; i < self.dataList.count; i ++) {
        FilterData *model = self.dataList[i];
        for (NSInteger j = 0 ; j < model.dataList.count; j ++) {
            RLSBIfenSelectedSaishiModel *bifenmodel = model.dataList[j];
            if (bifenmodel.isSelected) {
                isAllNotSelected = false;
                break;
            }
        }
    }
    
    
    _allselectedV.btnNotAll.selected = isAllNotSelected;
    if (isAllNotSelected) {
        _allselectedV.btnConfirm.selected = true; // 置灰
        _allselectedV.btnConfirm.userInteractionEnabled = false;
    }
}

#pragma mark - Lazy Load

- (NSMutableArray *)dataList {
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;;
}

#pragma mark - ************  以下高人所写  ************

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _arrViewIndex = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    [self.view addSubview:self.allselectedV];
    self.allselectedV.btnAll.selected = _allBtnIsSelected;
    [self.view addSubview:self.collectionView];
    
//    [self.view addSubview:self.ViewIndex];
//    [self.view addSubview:self.flotageLabel];
    
    [self loadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UILabel *)flotageLabel
{
    if (!_flotageLabel) {
        _flotageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        _flotageLabel.center = CGPointMake(Width/2, (Height - 64 - _allselectedV.height)/2);
        _flotageLabel.backgroundColor = [UIColor blackColor];
        _flotageLabel.hidden = YES;
        [_flotageLabel.layer  setCornerRadius:32];
        _flotageLabel.layer.masksToBounds = YES;
        _flotageLabel.textAlignment = NSTextAlignmentCenter;
        _flotageLabel.textColor = [UIColor whiteColor];
    }
    return _flotageLabel;
}

- (RLSAllSelectedView *)allselectedV
{
    if (!_allselectedV) {
        _allselectedV = [[RLSAllSelectedView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 44)];
        _allselectedV.delegate = self;
    }
    return _allselectedV;
}
- (void)didSelectedAtBtnIndex:(NSInteger)index whtherSelected:(BOOL)selected {
     if (index == 0) {
        [self.dataList enumerateObjectsUsingBlock:^(FilterData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.dataList enumerateObjectsUsingBlock:^(RLSBIfenSelectedSaishiModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isSelected = true;
            }];
        }];
        [self.collectionView reloadData];
    }else if (index == 1) {
        [self.dataList enumerateObjectsUsingBlock:^(FilterData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj.dataList enumerateObjectsUsingBlock:^(RLSBIfenSelectedSaishiModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.isSelected = false;
            }];
        }];
        [self.collectionView reloadData];
    }else if (index == 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(confirmSelectedAllWithData:)]) {
            if (_allselectedV.btnAll.selected && [self.timeline isEqualToString:@"live"]) {
                [_delegate confirmSelectedAllWithData:nil];
            } else {
                NSMutableArray *arrSend = [NSMutableArray array];
                [self.dataList enumerateObjectsUsingBlock:^(FilterData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj.dataList enumerateObjectsUsingBlock:^(RLSBIfenSelectedSaishiModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (obj.isSelected) {
                            [arrSend addObject:obj];
                        }
                    }];
                }];
                 [_delegate confirmSelectedAllWithData:arrSend];
            }
        }
    }
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(Width, 24);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[RLSSelectedCCell class] forCellWithReuseIdentifier:CollectionCellSelectedAllVC];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHeaderSelectedAllVC];
    }
    return _collectionView;
}
#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataList.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    FilterData *model = self.dataList[section];
    return model.dataList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RLSSelectedCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellSelectedAllVC forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    else{
    }
    FilterData *dataModel = self.dataList[indexPath.section];
    RLSBIfenSelectedSaishiModel *model = [dataModel.dataList objectAtIndex:indexPath.row];
    cell.cellSize = CGSizeMake(cellCollectionWidth, cellCollectionHeight);
    cell.model = model;
    cell.selected = model.isSelected;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    FilterData *dataModel = self.dataList[indexPath.section];
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionHeaderSelectedAllVC forIndexPath:indexPath];
    headerView.backgroundColor = colorTableViewBackgroundColor;
    [headerView removeAllSubViews];
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 24)];
    labTitle.textColor = color33;
    labTitle.font = font12;
    labTitle.text = dataModel.title;
    [headerView addSubview:labTitle];
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;{
    FilterData *dataModel = self.dataList[indexPath.section];
    RLSBIfenSelectedSaishiModel *model = [dataModel.dataList objectAtIndex:indexPath.row];
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
- (RLSDSCollectionViewIndex *)ViewIndex
{
    if (!_ViewIndex) {
        _ViewIndex = [[RLSDSCollectionViewIndex alloc] initWithFrame:CGRectMake(Width - 30, APPDELEGATE.customTabbar.height_myNavigationBar + 44, 30, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height)];
        _ViewIndex.titleIndexes = _arrViewIndex;
        _ViewIndex.isFrameLayer = NO;
        _ViewIndex.collectionDelegate = self;
    }
    return _ViewIndex;
}

-(void)collectionViewIndex:(RLSDSCollectionViewIndex *)collectionViewIndex didselectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
    _flotageLabel.text = title;
//    if ([_arrSectionData containsObject:title]) {
//        NSInteger sectionIndex = [_arrSectionData indexOfObject:title];
//        NSIndexPath *tableIndexPath = [NSIndexPath indexPathForItem:0 inSection:sectionIndex];
//        [self.collectionView scrollToItemAtIndexPath:tableIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
//    }
}

- (void)collectionViewIndexTouchesBegan:(RLSDSCollectionViewIndex *)collectionViewIndex
{
    _flotageLabel.alpha = 1;
    _flotageLabel.hidden = NO;
}
- (void)collectionViewIndexTouchesEnd:(RLSDSCollectionViewIndex *)collectionViewIndex
{
    void (^animation)() = ^{
        _flotageLabel.alpha = 0;
    };
    [UIView animateWithDuration:0.4 animations:animation completion:^(BOOL finished) {
        _flotageLabel.hidden = YES;
    }];
}
@end

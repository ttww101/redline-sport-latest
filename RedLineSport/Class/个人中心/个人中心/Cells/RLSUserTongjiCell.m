#import "RLSUserTongjiCell.h"
#import "RLSUserTongjiCollectioncell.h"
#define cellUserTongjiCollection @"RLSUserTongjiCollectioncell"
@interface RLSUserTongjiCell()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *mainView; 
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *arrViewItems;
@property (nonatomic, strong) NSMutableArray *arrViewItemTitles;
@end
@implementation RLSUserTongjiCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupMainView];
    }
    return self;
}
- (void)setModel:(RLSUserTongjiAllModel *)model
{
    _model = model;
    [_mainView reloadData];
}
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    _flowLayout.itemSize = CGSizeMake(Width, 285);
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, Width, 285) collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[RLSUserTongjiCollectioncell class] forCellWithReuseIdentifier:cellUserTongjiCollection];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self.contentView addSubview:mainView];
    _mainView = mainView;
    UILabel *lab_title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 70, 40)];
    if (self.Number==3) {
        lab_title.text = @"竞猜统计图";
    }else{
        lab_title.text = @"推荐统计图";
    }
    lab_title.font = font12;
    lab_title.textColor = color66;
    [self.contentView addSubview:lab_title];
    UIView *viewRight = [[UIView alloc] initWithFrame:CGRectMake(Width - 15 - 80, 0, 80, 40)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tomoreTuijian)];
    [viewRight addGestureRecognizer:tap];
    viewRight.userInteractionEnabled = YES;
    [self.contentView addSubview:viewRight];
    UIImageView *imageRight = [[UIImageView alloc] initWithFrame:CGRectMake(80 - 8 , 0, 8, 8)];
    imageRight.center = CGPointMake(imageRight.center.x, viewRight.height/2);
    imageRight.image = [UIImage imageNamed:@"userMoreTuijian"];
    [viewRight addSubview:imageRight];
    UILabel *labRight = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80 -18, 40)];
    labRight.text = @"查看更多";
    labRight.textAlignment= NSTextAlignmentRight;
    labRight.font = font12;
    labRight.textColor = color66;
    [viewRight addSubview:labRight];
    UIView *viewbottom = [[UIView alloc] initWithFrame:CGRectMake(0, 375 - 50, Width, 50)];
    [self.contentView addSubview:viewbottom];
    UIView *viewTap1 = [[UIView alloc] initWithFrame:CGRectMake(Width/2 - 15 - 33 - 30 - 15, 0, 60, 50)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selected1)];
    [viewTap1 addGestureRecognizer:tap1];
    [viewbottom addSubview:viewTap1];
    UIView *viewTap2 = [[UIView alloc] initWithFrame:CGRectMake(Width/2 - 15 - 15, 0, 60, 50)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selected2)];
    [viewTap2 addGestureRecognizer:tap2];
    [viewbottom addSubview:viewTap2];
    UIView *viewTap3 = [[UIView alloc] initWithFrame:CGRectMake(Width/2 + 15 + 33 - 15, 0, 60, 50)];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selected3)];
    [viewTap3 addGestureRecognizer:tap3];
    [viewbottom addSubview:viewTap3];
    _arrViewItems = [NSMutableArray array];
    _arrViewItemTitles = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        UIView *viewPage = [[UIView alloc] init];
        viewPage.backgroundColor = colorEE;
        viewPage.userInteractionEnabled = NO;
        UILabel *labPage = [[UILabel alloc] init];
        switch (i) {
            case 0:
            {
                viewPage.frame = CGRectMake(Width/2 - 15 - 33 - 30, 13, 30, 5);
                labPage.text = @"近7天";
            }
                break;
            case 1:
            {
                viewPage.frame = CGRectMake(Width/2 - 15, 13, 30, 5);
                labPage.text = @"近30天";
            }
                break;
            case 2:
            {
                viewPage.frame = CGRectMake(Width/2 + 15 + 33, 13, 30, 5);
                labPage.text = @"全部";
            }
                break;
            default:
                break;
        }
        viewPage.layer.cornerRadius = 2.5;
        viewPage.layer.masksToBounds = YES;
        labPage.frame = CGRectMake(0, viewPage.bottom, 40, 20);
        labPage.center = CGPointMake(viewPage.center.x, labPage.center.y);
        labPage.textAlignment = NSTextAlignmentCenter;
        labPage.font = font10;
        labPage.textColor = color99;
        [viewbottom addSubview:viewPage];
        [viewbottom addSubview:labPage];
        [_arrViewItems addObject:viewPage];
        [_arrViewItemTitles addObject:labPage];
    }
    [self updatePageControlWithIndex:0];
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 374, Width, 0.5)];
    viewLine.backgroundColor = colorCellLine;
    [self.contentView addSubview:viewLine];
}
- (void)tomoreTuijian
{
    if (_delegate && [_delegate respondsToSelector:@selector(didToTongjiVC)]) {
        [_delegate didToTongjiVC];
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RLSUserTongjiCollectioncell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellUserTongjiCollection forIndexPath:indexPath];
    if (_model) {
        switch (indexPath.item) {
            case 0:
                cell.model = _model.week;
                break;
            case 1:
                cell.model = _model.month;
                break;
            case 2:
                cell.model = _model.all;
                break;
            default:
                break;
        }
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = [self currentIndex];
    NSLog(@"%d",itemIndex);
    [self updatePageControlWithIndex:itemIndex];
}
- (void)updatePageControlWithIndex:(int)index
{
    for (int i = 0; i<_arrViewItems.count; i++) {
        UIView *viewP = [_arrViewItems objectAtIndex:i];
        UILabel *labP = [_arrViewItemTitles objectAtIndex:i];
        if (index ==i) {
            viewP.backgroundColor = redcolor;
            labP.textColor = redcolor;
        }else{
            viewP.backgroundColor = colorEE;
            labP.textColor = color33;
        }
    }
}
- (int)currentIndex
{
    if (_mainView.width == 0 || _mainView.width == 0) {
        return 0;
    }
    int index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (_mainView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
    } else {
        index = (_mainView.contentOffset.y + _flowLayout.itemSize.height * 0.5) / _flowLayout.itemSize.height;
    }
    return MAX(0, index);
}
- (void)selected1
{
    [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
- (void)selected2
{
    [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
- (void)selected3
{
    [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
@end

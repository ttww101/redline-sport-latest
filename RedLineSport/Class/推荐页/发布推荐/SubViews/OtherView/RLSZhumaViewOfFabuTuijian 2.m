#import "RLSZhumaViewOfFabuTuijian.h"
@interface RLSZhumaViewOfFabuTuijian()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UILabel *labPrice;
@property (nonatomic, strong) UIButton *btnPrices;
@property (nonatomic, strong) UILabel *labNoteCode;
@property (nonatomic, strong) UIButton *btnWin;
@property (nonatomic, strong) UIButton *btnPing;
@property (nonatomic, strong) UIButton *btnLose;
@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, strong) UIButton *priceBtns;
@property (nonatomic, strong) NSMutableArray *priceBtnsArr;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *btnConfirm;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UILabel *price;

@end
@implementation RLSZhumaViewOfFabuTuijian


#pragma mark - Config UI

- (void)configUI {
    [self addSubview:self.line];
    [self addSubview:self.basicView];
}


#pragma mark - Lazy Load

- (UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, ONE_PX_LINE)];
        _line.backgroundColor = UIColorHex(eeeeee);
    }
    return _line;
}

- (UIView *)line1 {
    if (_line1 == nil) {
        _line1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.price.bottom + 5, self.width, ONE_PX_LINE)];
        _line1.backgroundColor = UIColorHex(eeeeee);
    }
    return _line1;
}

- (UIView *)line2 {
    if (_line2 == nil) {
        _line2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.labNoteCode.bottom + 5, self.width, ONE_PX_LINE)];
        _line2.backgroundColor = UIColorHex(eeeeee);
    }
    return _line2;
}

- (UILabel *)price {
    if (_price == nil) {
        _price = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 30, 30)];
        _price.text = @"价格";
        _price.textColor = UIColorHex(#323232);
        _price.textAlignment = NSTextAlignmentLeft;
        _price.font = font13;
    }
    return _price;
}

#pragma mark - ************  以下高人所写  ************

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)setPriceList:(NSArray *)priceList
{
    _priceList = priceList;
    [self setUpPriceBtns];
}
- (void)setUpPriceBtns {
    CGFloat btnwidth = 45;
    for (int i = 0 ; i < _priceList.count; i++) {
        RLSPriceListModel *mode = [_priceList objectAtIndex:i];
        UIButton *btnPrices = [UIButton buttonWithType:UIButtonTypeCustom];
        btnPrices.frame = CGRectMake(50 + btnwidth*i , self.labPrice.bottom + 15,btnwidth, 27);
        btnPrices.tag = i;
        [btnPrices setTitle:mode.desc forState:UIControlStateNormal];
        btnPrices.titleLabel.font = font13;
        btnPrices.tag = i;
        [btnPrices setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btnPrices setTitleColor:color27 forState:UIControlStateNormal];
        [btnPrices setBackgroundImage:[UIImage imageNamed:@"publish_price_selected"] forState:UIControlStateSelected];
        [btnPrices setBackgroundImage:[UIImage imageNamed:@"publish_price"] forState:UIControlStateNormal];
        if (i == 0) {
            btnPrices.selected = true;
        }
        btnPrices.imageView.contentMode = UIViewContentModeScaleAspectFill;
//        btnPrices.layer.borderWidth = 0.6;
//        btnPrices.layer.cornerRadius = 3;
        [btnPrices addTarget:self action:@selector(priceBtnsClick:) forControlEvents:UIControlEventTouchUpInside];
//        btnPrices.layer.masksToBounds = YES;
        [_basicView addSubview:btnPrices];
        [self.priceBtnsArr addObject:btnPrices];
    }
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, self.height)];
        _btnWidth = (Width- 30)/4;
        [_basicView addSubview:self.price];
        [_basicView addSubview:self.line1];
        [_basicView addSubview:self.labNoteCode];
        [_basicView addSubview:self.btnWin];
        [_basicView addSubview:self.btnPing];
        [_basicView addSubview:self.btnLose];
         [_basicView addSubview:self.line2];
        [_basicView addSubview:self.btnConfirm];
        [_btnWin setTitle:@"均注" forState:UIControlStateNormal];
        [_btnPing setTitle:@"2倍" forState:UIControlStateNormal];
        [_btnLose setTitle:@"4倍" forState:UIControlStateNormal];
        [_btnConfirm setTitle:@"确认发布" forState:UIControlStateNormal];
    }
    return _basicView;
}
- (NSMutableArray *)priceBtnsArr {
    if (!_priceBtnsArr) {
        _priceBtnsArr = [NSMutableArray array];
    }
    return _priceBtnsArr;
}
- (UILabel *)labNoteCode
{
    if (!_labNoteCode) {
        _labNoteCode = [[UILabel alloc] initWithFrame:CGRectMake(15, self.line1.bottom + 5, 30, 30)];
        _labNoteCode.text = @"注码";
        _labNoteCode.font = font13;
        _labNoteCode.textColor = UIColorHex(#323232);
    }
    return _labNoteCode;
}
- (UIButton *)btnWin
{
    if (!_btnWin) {
        _btnWin = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWin.frame = CGRectMake(50, _labNoteCode.top, 45, 27);
        _btnWin.titleLabel.font = font13;
        [_btnWin setTitleColor:color27 forState:UIControlStateNormal];
        [_btnWin setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnWin setBackgroundImage:[UIImage imageNamed:@"publish_price_selected"] forState:UIControlStateSelected];
        [_btnWin setBackgroundImage:[UIImage imageNamed:@"publish_price"] forState:UIControlStateNormal];
        _btnWin.selected = YES;
        _btnWin.tag = 1;
        [_btnWin addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnWin;
}
- (UIButton *)btnPing
{
    if (!_btnPing) {
        _btnPing = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPing.frame = CGRectMake(self.btnWin.right, self.btnWin.top, 45, 27);
        _btnPing.titleLabel.font = font13;
        [_btnPing setTitleColor:color27 forState:UIControlStateNormal];
        [_btnPing setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _btnPing.tag = 2;
        [_btnPing addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
        [_btnPing setBackgroundImage:[UIImage imageNamed:@"publish_price_selected"] forState:UIControlStateSelected];
        [_btnPing setBackgroundImage:[UIImage imageNamed:@"publish_price"] forState:UIControlStateNormal];
    }
    return _btnPing;
}
- (UIButton *)btnLose
{
    if (!_btnLose) {
        _btnLose = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLose.frame =CGRectMake(self.btnPing.right, self.btnWin.top, 45, 27);
        _btnLose.titleLabel.font = font13;
        [_btnLose setTitleColor:color27 forState:UIControlStateNormal];
        [_btnLose setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnLose setBackgroundImage:[UIImage imageNamed:@"publish_price_selected"] forState:UIControlStateSelected];
        [_btnLose setBackgroundImage:[UIImage imageNamed:@"publish_price"] forState:UIControlStateNormal];
        _btnLose.tag = 3;
        [_btnLose addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLose;
}
- (UIButton *)btnConfirm {
    if (!_btnConfirm) {
        _btnConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnConfirm.frame = CGRectMake(15, self.line2.bottom + 15, Width - 30 , 32);
        _btnConfirm.titleLabel.font = font13;
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.tag = 4;
        [_btnConfirm addTarget:self action:@selector(choiceType:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = UIColorHex(#1D50A1);
        _btnConfirm.layer.cornerRadius = 2;
        _btnConfirm.layer.masksToBounds = YES;
    }
    return _btnConfirm;
}
- (void)priceBtnsClick:(UIButton *)sender {
    for(int i = 0;i < self.priceBtnsArr.count;i++)
    {
        UIButton *btn = self.priceBtnsArr[i];
        [btn setTitleColor:color27 forState:UIControlStateNormal];
        btn.layer.borderColor  = grayColor2.CGColor;
        btn.selected = NO;
    }
    UIButton *btn = sender;
    btn.layer.borderColor = redcolor.CGColor;
    btn.selected = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedPriceViewWithModel:)]) {
        [_delegate didselectedPriceViewWithModel:[_priceList objectAtIndex:sender.tag]];
    }
}
- (void)choiceType:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            _btnWin.selected = YES;
            _btnPing.selected = NO;
            _btnLose.selected = NO;
        }
            break;
        case 2:
        {
            _btnWin.selected = NO;
            _btnPing.selected = YES;
            _btnLose.selected = NO;
        }
            break;
        case 3:
        {
            _btnWin.selected = NO;
            _btnPing.selected = NO;
            _btnLose.selected = YES;
        }
            break;
        default:
            break;
    }
    _btnWin.layer.borderColor = _btnWin.selected? redcolor.CGColor : grayColor2.CGColor;
    _btnPing.layer.borderColor = _btnPing.selected? redcolor.CGColor : grayColor2.CGColor;
    _btnLose.layer.borderColor = _btnLose.selected? redcolor.CGColor : grayColor2.CGColor;
    if (_delegate && [_delegate respondsToSelector:@selector(didselectedZhumaAtIndex:)]) {
        [_delegate didselectedZhumaAtIndex:btn.tag];
    }
}
@end

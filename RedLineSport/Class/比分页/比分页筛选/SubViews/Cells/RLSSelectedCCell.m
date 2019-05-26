#import "RLSSelectedCCell.h"
@interface RLSSelectedCCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *labCount;

@end
@implementation RLSSelectedCCell
- (void)setCellSize:(CGSize)cellSize
{
    _cellSize = cellSize;
    self.backgroundView = self.bgView;
    _bgView.frame = CGRectMake(0, 0, _cellSize.width, _cellSize.height);
    _labTitle.frame = CGRectMake(5, 0, _cellSize.width - 10, _cellSize.height);
    _labCount.frame = CGRectMake(5, 0, _cellSize.width - 10, _cellSize.height);
    
}
- (void)setModel:(RLSBIfenSelectedSaishiModel *)model
{
    _model = model;
    NSString *title;
    if (_cellSize.width < ((Width - 30 - 10)/2)) {
        if (isOniPhone4 || isOniPhone5) {
            if (model.name.length>3) {
                title = [model.name substringToIndex:3];
            }else{
                title = model.name;
            }
        }else{
            title = model.name;
        }
    }else{
        title = model.name;
    }
    if (model.isSelected) {
        self.bgView.layer.borderColor = UIColorHex(#FF8E00).CGColor;
        _labTitle.textColor = UIColorHex(#FF8E00);
        _labCount.textColor = UIColorHex(#FF8E00);
    }else{
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.bgView.layer.borderColor = UIColorHex(#E2E2E2).CGColor;
        _labTitle.textColor = UIColorHex(#A6A3A3);
        _labCount.textColor = UIColorHex(#A6A3A3);
    }
    _labTitle.text = title;
    _labCount.text = [NSString stringWithFormat:@"%ld场",(long)_model.count];
    
}
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView  = [[UIView alloc] init];
        _bgView.frame = CGRectMake(0, 0, _cellSize.width, _cellSize.height);
        _bgView.layer.borderWidth = 0.7;
        _bgView.layer.cornerRadius = 3;
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView addSubview:self.labTitle];
        [_bgView addSubview:self.labCount];
    }
    return _bgView;
}

- (UILabel *)labTitle
{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc] init];
        _labTitle.textColor = color33;
        _labTitle.font = font12;
    }
    return _labTitle;
}
- (UILabel *)labCount
{
    if (!_labCount) {
        _labCount = [[UILabel alloc] init];
        _labCount.textColor = color99;
        _labCount.font = font12;
        _labCount.textAlignment = NSTextAlignmentRight;
    }
    return _labCount;
}
@end

#define SPACE 3
#import "RLSTabbarButton.h"
#import "ArchiveFile.h"
@interface RLSTabbarButton ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic , strong) UIImage *normalImage;
@property (nonatomic , strong) UIImage *selectedImage;
@end
static CGFloat const defultImageSize = 25;
static CGFloat const selectImageSzie = 50;
@implementation RLSTabbarButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageView =[[UIImageView alloc]init];
        _iconImageView.frame = CGRectMake((self.width - defultImageSize) / 2, 0, defultImageSize, defultImageSize);
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 15)];
        self.textLabel.bottom = self.height;
        [self.textLabel setTextAlignment:NSTextAlignmentCenter];
        self.textLabel.font=[UIFont systemFontOfSize:10];
        [self addSubview:_iconImageView];
        [self addSubview:self.textLabel];
        _iconImageView.bottom = self.textLabel.top - 3;
    }
    return self;
}
#pragma mark - System Method
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        _iconImageView.image= _selectedImage;
        self.textLabel.textColor= [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1.0];
    }
    else
    {
        _iconImageView.image = _normalImage;
        self.textLabel.textColor     = [UIColor darkGrayColor];
    }
    [self reloadImageViewSize:selected];
}
- (void)reloadImageViewSize:(BOOL)select {
    NSMutableArray *activityArray = [ArchiveFile getDataWithPath:Activity_Path];
    for (NSDictionary *dic in activityArray) {
        if (dic[@"main"]) {
        } else {
        }
    }
}
- (void)setTabbarImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)titleStr
{
    _normalImage = image;
    _selectedImage = selectedImage;
    _iconImageView.image= image;
    self.textLabel.text=titleStr;
}
- (NSMutableAttributedString *)mutableAttributedStringWithText:(NSString *)tt textSize:(float)ts color:(UIColor *)cl
{
    NSMutableAttributedString *strAttribude = [[NSMutableAttributedString alloc] initWithString:tt];
    [strAttribude addAttribute:NSForegroundColorAttributeName value:cl range:NSMakeRange(0, tt.length)];
    [strAttribude addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(0, tt.length)];
    return strAttribude;
}
@end

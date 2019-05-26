#import <UIKit/UIKit.h>
@protocol SuccessfulViewDelegate <NSObject>
-(void)backView;
@end
@interface RLSSuccessfulView : UIView
@property (nonatomic, strong)UIImageView *img;
@property (nonatomic, retain)NSString *imgStr;
@property (nonatomic, strong)UILabel *labSucc;
@property (nonatomic, strong)UILabel *labContent;
@property (nonatomic, assign)NSInteger type;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)UILabel *labContentTwo;
@property (nonatomic, assign)id<SuccessfulViewDelegate> delegate;
@end

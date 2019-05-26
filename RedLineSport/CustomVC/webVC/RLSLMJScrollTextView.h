#import <UIKit/UIKit.h>
typedef enum {
    LMJTextScrollContinuous,     
    LMJTextScrollIntermittent,   
    LMJTextScrollFromOutside,    
    LMJTextScrollWandering       
}LMJTextScrollMode;
typedef enum {
    LMJTextScrollMoveLeft,
    LMJTextScrollMoveRight
}LMJTextScrollMoveDirection;
@interface RLSLMJScrollTextView : UIView
-(id)initWithFrame:(CGRect)frame textScrollModel:(LMJTextScrollMode)scrollModel direction:(LMJTextScrollMoveDirection)moveDirection;
-(void)startScrollWithText:(NSString * )text textColor:(UIColor *)color font:(UIFont *)font;
-(void)setMoveSpeed:(CGFloat)speed;
@end

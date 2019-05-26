#import <UIKit/UIKit.h>
#import "RLSCommentChildModel.h"
@protocol CommentDetailViewDelegate <NSObject>
@optional
- (void)didTouchCommentDetailViewWithUserId:(RLSCommentChildModel*)userId commentTag:(CGFloat)commentTag;
- (void)touchChildCommentViewWithIdid:(NSInteger)Idid;
@end
@interface RLSCommentDetailView : UIView
@property (nonatomic, strong) RLSCommentChildModel *model;
@property (nonatomic, weak) id<CommentDetailViewDelegate> delegate;
- (void)hideHudView;
@end

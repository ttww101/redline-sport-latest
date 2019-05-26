#import <UIKit/UIKit.h>
@class RLSCommentsView;
@protocol CommentsViewDelegate <NSObject>
- (void)commentViewDidSelectCommnetList:(RLSCommentsView *)commentView;
- (void)commentViewDidSelectReply:(RLSCommentsView *)commentView;
- (void)commentViewDidSelectShare:(RLSCommentsView *)commentView;
@end
@interface RLSCommentsView : UIView
@property (nonatomic , copy) NSString *newsID;
@property (nonatomic , copy) NSString *module;
- (void)loadData;
@property (nonatomic, weak) id <CommentsViewDelegate> delegate;
@end

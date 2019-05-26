#import "RLSRongYongGroupChatingVC.h"
@interface RLSRongYongGroupChatingVC ()
@end
@implementation RLSRongYongGroupChatingVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDisplayConversationTypes:
     [NSArray arrayWithObjects:
      @(ConversationType_DISCUSSION),
      @(ConversationType_GROUP), nil]];
}
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = @"想显示的会话标题";
    [self.navigationController pushViewController:conversationVC animated:YES];
}
- (void)willDisplayConversationTableCell:(RCConversationCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.headerImageViewBackgroundView.backgroundColor = redcolor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

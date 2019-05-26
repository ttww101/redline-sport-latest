#import "RLSRongyongChatingVC.h"
#import "RLSRongYongGroupChatingVC.h"
#import "RLSRongyunChatVC.h"
@interface RLSRongyongChatingVC ()
@end
@implementation RLSRongyongChatingVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_CHATROOM),@(ConversationType_APPSERVICE),                                          @(ConversationType_SYSTEM),@(ConversationType_DISCUSSION),@(ConversationType_GROUP)]];
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),@(ConversationType_GROUP)]];
}
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    if (model.conversationType == ConversationType_DISCUSSION || model.conversationType == ConversationType_GROUP) {
        RLSRongYongGroupChatingVC *chatVC = [[RLSRongYongGroupChatingVC alloc] init];
        [APPDELEGATE.customTabbar pushToViewController:chatVC animated:YES];
    }else{
        RLSRongyunChatVC *conversationVC = [[RLSRongyunChatVC alloc]init];
        conversationVC.conversationType = model.conversationType;
        conversationVC.targetId = model.targetId;
        conversationVC.title = @"想显示的会话标题";
        [APPDELEGATE.customTabbar pushToViewController:conversationVC animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

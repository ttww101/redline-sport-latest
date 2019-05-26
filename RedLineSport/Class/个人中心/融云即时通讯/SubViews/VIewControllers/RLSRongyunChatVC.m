#import "RLSRongyunChatVC.h"
#import <RongIMKit/RCImagePreviewController.h>
@interface RLSRongyunChatVC ()
@end
@implementation RLSRongyunChatVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_chatFrame.size.height>0) {
        [self.conversationMessageCollectionView setFrame:_chatFrame];
    }
    NSUInteger finalRow = MAX(0, [self.conversationMessageCollectionView numberOfItemsInSection:0] - 1);
    if (0 == finalRow) {
        return;
    }
    NSIndexPath *finalIndexPath =
    [NSIndexPath indexPathForItem:finalRow inSection:0];
    [self.conversationMessageCollectionView
     scrollToItemAtIndexPath:finalIndexPath
     atScrollPosition:UICollectionViewScrollPositionBottom
     animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.chatSessionInputBarControl.pluginBoardView removeAllItems];
    self.chatSessionInputBarControl.additionalButton.hidden = YES;
    self.title = @"聊天室";
    self.view.backgroundColor = [UIColor whiteColor];
    self.conversationMessageCollectionView.backgroundColor = [UIColor whiteColor];
    [self setNavBtn];
}
- (void)setNavBtn
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNormalImage:[UIImage imageNamed:@"back"] HighImage:[UIImage imageNamed:@""] target:self action:@selector(leftBarButtonItem)];
}
- (void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)willDisplayConversationTableCell:(RCMessageBaseCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

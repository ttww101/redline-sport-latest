#import <UIKit/UIKit.h>
@class RLSDSCollectionViewIndex;
@protocol DSCollectionViewIndexDelegate <NSObject>
-(void)collectionViewIndex:(RLSDSCollectionViewIndex *)collectionViewIndex didselectionAtIndex:(NSInteger)index withTitle:(NSString *)title;
- (void)collectionViewIndexTouchesBegan:(RLSDSCollectionViewIndex *)collectionViewIndex;
- (void)collectionViewIndexTouchesEnd:(RLSDSCollectionViewIndex *)collectionViewIndex;
@end
@interface RLSDSCollectionViewIndex : UIView
@property(nonatomic, assign)BOOL isFrameLayer;
@property(nonatomic, strong)NSArray *titleIndexes;
@property(nonatomic, weak)id<DSCollectionViewIndexDelegate>collectionDelegate;
@end

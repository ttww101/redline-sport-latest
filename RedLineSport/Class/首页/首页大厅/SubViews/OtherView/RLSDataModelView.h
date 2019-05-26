#import <UIKit/UIKit.h>
@protocol DataModelViewDelegate<NSObject>
@optional
- (void)didSelectedDataModelViewIndex:(NSInteger)index;
@end
@interface RLSDataModelView : UIView
@property (nonatomic, weak) id<DataModelViewDelegate> delegate;
@end

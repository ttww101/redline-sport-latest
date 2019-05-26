//
//  RLSZLViewModelViewController.h
//  DictPublishAssistant
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef	INTERFACE_VIEWMODEL
#define INTERFACE_VIEWMODEL( __class ) \
@property (strong, nonatomic) __class* viewModel;

#undef	IMPLEMENTATION_VIEWMODEL
#define IMPLEMENTATION_VIEWMODEL( __class ) \
- (void)setupViewModel \
{ \
    self.viewModel = [[__class alloc] init]; \
} \

@interface RLSZLViewModelViewController : UIViewController

@end

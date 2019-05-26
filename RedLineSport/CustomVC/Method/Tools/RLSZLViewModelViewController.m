//
//  RLSZLViewModelViewController.m
//  DictPublishAssistant
//
//  Created by Marjoice on 7/19/17.
//  Copyright © 2017 zhuliang. All rights reserved.
//

#import "RLSZLViewModelViewController.h"
#import "RLSNSObject+Perform.h"

@interface RLSZLViewModelViewController (PRIVATE)

@end

@implementation RLSZLViewModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SEL viewModelSel = NSSelectorFromString(@"setupViewModel");
    if([self respondsToSelector:viewModelSel]) {
        [self performSelectorAlongChain:viewModelSel];
    }
}



@end

//
//  ASRootViewController.h
//  Djembe
//
//  Created by Adam Suskin on 11/1/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDrumViewController.h"

@interface ASRootViewController : UIViewController <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (assign, nonatomic) NSUInteger activeIndex;
@property (strong, nonatomic) NSArray *drumViewControllers;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;

@end

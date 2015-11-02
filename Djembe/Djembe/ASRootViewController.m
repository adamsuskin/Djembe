//
//  ASRootViewController.m
//  Djembe
//
//  Created by Adam Suskin on 11/1/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import "ASRootViewController.h"

@interface ASRootViewController ()

@end

@implementation ASRootViewController
@synthesize pageViewController = _pageViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:[[self view] bounds]];
    [backgroundView setContentMode:UIViewContentModeTopLeft];
    [backgroundView setImage:[UIImage imageNamed:@"dirt.jpg"]];
    [[self view] addSubview:backgroundView];
    
    //Set initial options
    [self setPageViewController:[[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal options:nil]];
    [[self pageViewController] setDataSource:self];
    [[self pageViewController] setDelegate:self];
    //Should occupy whole space of current view controller
    [[[self pageViewController] view] setFrame:[[self view] bounds]];
    
    //Take care of drum view controllers
    ASDrumViewController *djembeController = [[ASDrumViewController alloc] initWithID:0 Drum:@"Djembe"];
    //color rgb(26, 188, 156)
    [[djembeController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *djunController = [[ASDrumViewController alloc] initWithID:1 Drum:@"Djun Djun"];
    //color rgb(155, 89, 182)
    [[djunController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *tumbaController = [[ASDrumViewController alloc] initWithID:2 Drum:@"Tumbador"];
    //color rgb(231, 76, 60)
    [[tumbaController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *ashikoController = [[ASDrumViewController alloc] initWithID:3 Drum:@"Ashiko"];
    //color rgb(52, 152, 219)
    [[ashikoController view] setBackgroundColor:[UIColor clearColor]];
    
    [self setDrumViewControllers:[NSArray arrayWithObjects:djembeController, djunController, tumbaController, ashikoController, nil]];
    [[self pageViewController] setViewControllers:[NSArray arrayWithObject:[[self drumViewControllers] objectAtIndex:0]]
                                        direction:UIPageViewControllerNavigationDirectionForward
                                         animated:YES
                                       completion:nil];
    
    
    //Add to current view controller
    [self addChildViewController:[self pageViewController]];
    [[self view] addSubview:[[self pageViewController] view]];
    [[self pageViewController] didMoveToParentViewController:self];
     
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [(ASDrumViewController *)viewController index];
    
    return (currentIndex == 0 ? nil : [[self drumViewControllers] objectAtIndex:currentIndex-1]);
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentIndex = [(ASDrumViewController *)viewController index];
    
    return (currentIndex == [[self drumViewControllers] count]-1 ? nil : [[self drumViewControllers] objectAtIndex:currentIndex+1]);
}

@end

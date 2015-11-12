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
    [[[self pageViewController] view] setMultipleTouchEnabled:YES];
    
    //Take care of drum view controllers
    ASDrumViewController *djembeController = [[ASDrumViewController alloc] initWithID:0 Drum:@"Djembe"];
    [djembeController setBassSoundFile:@"DjembeBass.wav"];
    [djembeController setEdgeSoundFile:@"DjembeEdge.wav"];
    [[djembeController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *djunController = [[ASDrumViewController alloc] initWithID:1 Drum:@"Djun Djun"];
    [djunController setBassSoundFile:@"Djun Djun.wav"];
    [djunController setEdgeSoundFile:@"Djun Djun.wav"];
    [[djunController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *tumbaController = [[ASDrumViewController alloc] initWithID:2 Drum:@"Tumbador"];
    [tumbaController setBassSoundFile:@"TumbaBass.wav"];
    [tumbaController setEdgeSoundFile:@"TumbaEdge.wav"];
    [[tumbaController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *ashikoController = [[ASDrumViewController alloc] initWithID:3 Drum:@"Ashiko"];
    [ashikoController setBassSoundFile:@"AshikoBass.wav"];
    [ashikoController setEdgeSoundFile:@"AshikoEdge.wav"];
    [[ashikoController view] setBackgroundColor:[UIColor clearColor]];
    
    [self setActiveIndex:0];
    [self setDrumViewControllers:[NSArray arrayWithObjects:djembeController, djunController, tumbaController, ashikoController, nil]];
    [[self pageViewController] setViewControllers:[NSArray arrayWithObject:[[self drumViewControllers] objectAtIndex:0]]
                                        direction:UIPageViewControllerNavigationDirectionForward
                                         animated:YES
                                       completion:nil];
    
    
    //Add to current view controller
    [self addChildViewController:[self pageViewController]];
    [[self view] addSubview:[[self pageViewController] view]];
    [[self pageViewController] didMoveToParentViewController:self];
    
    [(ASDrumViewController *)[[[self pageViewController] viewControllers] objectAtIndex:0] animateTitle];
     
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

- (void)pageViewController:(UIPageViewController *)pageViewController
        didFinishAnimating:(BOOL)finished
   previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers
       transitionCompleted:(BOOL)completed {
    
    if(completed) {
        [(ASDrumViewController *)[[pageViewController viewControllers] objectAtIndex:0] animateTitle];
    }
    
}

@end

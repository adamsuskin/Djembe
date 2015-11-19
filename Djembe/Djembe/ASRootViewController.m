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
    ASDrumViewController *djunController = [[ASDrumViewController alloc] initWithID:0 Drum:@"Djun Djun"];
    [djunController setBassSoundFile:@"Djun Djun.wav"];
    [djunController setEdgeSoundFile:@"Djun Djun.wav"];
    [[djunController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *djembeController = [[ASDrumViewController alloc] initWithID:1 Drum:@"Djembe"];
    [djembeController setBassSoundFile:@"DjembeBass.wav"];
    [djembeController setEdgeSoundFile:@"DjembeEdge.wav"];
    [[djembeController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *tumbaController = [[ASDrumViewController alloc] initWithID:2 Drum:@"Tumbador"];
    [tumbaController setBassSoundFile:@"TumbaBass.wav"];
    [tumbaController setEdgeSoundFile:@"TumbaEdge.wav"];
    [[tumbaController view] setBackgroundColor:[UIColor clearColor]];
    
    ASDrumViewController *ashikoController = [[ASDrumViewController alloc] initWithID:3 Drum:@"Ashiko"];
    [ashikoController setBassSoundFile:@"AshikoBass.wav"];
    [ashikoController setEdgeSoundFile:@"AshikoEdge.wav"];
    [[ashikoController view] setBackgroundColor:[UIColor clearColor]];
    
    [self setActiveIndex:0];
    [self setDrumViewControllers:[NSArray arrayWithObjects:djunController, djembeController, tumbaController, ashikoController, nil]];
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

-(void)viewWillAppear:(BOOL)animated {
    [[self view] bringSubviewToFront:[self infoButton]];
    [[self view] bringSubviewToFront:[self recordButton]];
    [[[self infoButton] layer] setOpacity:0];
    [[[self infoButton] layer] setTransform:CATransform3DMakeTranslation(0, 10, 0)];
    [[[self recordButton] layer] setOpacity:0];
    [[[self recordButton] layer] setTransform:CATransform3DMakeTranslation(0, 10, 0)];
}

-(void)viewDidAppear:(BOOL)animated {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome!"
                                                                   message:@"Make sure to turn off vibrate and turn up the volume!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Sounds good!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [UIView beginAnimations:@"opacity" context:nil];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        
        [[[self infoButton] layer] setOpacity:1.0];
        [[[self infoButton] layer] setTransform:CATransform3DIdentity];
        [[[self recordButton] layer] setOpacity:1.0];
        [[[self recordButton] layer] setTransform:CATransform3DIdentity];
        
        [UIView commitAnimations];
    }];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
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
        [[self getActiveController] animateTitle];
    }
    
}

- (ASDrumViewController *)getActiveController {
    return (ASDrumViewController *)[[[self pageViewController] viewControllers] objectAtIndex:0];
}

- (IBAction)infoButtonTapped:(id)sender {
    
    ASDrumViewController *activeController = [self getActiveController];
    [activeController presentViewController:activeController.infoController
                       animated:YES
                     completion:^{
                     }];
}

- (IBAction)recordButtonTapped:(id)sender {
    if([[ASSoundManager sharedManager] isRecording]) {
        [[ASSoundManager sharedManager] setIsRecording:NO];
        [[self recordButton] setImage:[UIImage imageNamed:@"Record Button.png"] forState:UIControlStateNormal];
    }
    else {
        [[ASSoundManager sharedManager] setIsRecording:YES];
        [[self recordButton] setImage:[UIImage imageNamed:@"Record Button Green.png"] forState:UIControlStateNormal];
    }
}

@end

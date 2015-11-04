//
//  ASDrumViewController.m
//  Djembe
//
//  Created by Adam Suskin on 11/1/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import "ASDrumViewController.h"

@interface ASDrumViewController ()

@end

@implementation ASDrumViewController

-(id)initWithID:(NSUInteger)idf Drum:(NSString *)drum {
    self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ASDrumViewController"];
    if (self) {
        [self setIndex:idf];
        [self setDrum:drum];
        
        [self setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [[self titleLabel] setText:[[self drum] uppercaseString]];
    [[self titleLabel] setMinimumScaleFactor:0.5];
    [[self titleLabel] setAdjustsFontSizeToFitWidth:YES];
    [[[self titleView] layer] setOpacity:0.0];
    
    [[self drumBackground] setImage:[UIImage imageNamed:[self drum]]];
    
    [self setInfoController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ASInfoViewController"]];
    [[self infoController] setModalPresentationStyle:UIModalPresentationOverCurrentContext];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint location = [[[event allTouches] anyObject] locationInView:[self view]];
    
    float tapWidth = 30;
    ASDrumTapView *drumTapView = [[ASDrumTapView alloc] initWithFrame:CGRectMake(location.x - (tapWidth / 2), location.y - (tapWidth / 2), tapWidth, tapWidth)];
    [drumTapView setBackgroundColor:[UIColor clearColor]];
    [drumTapView setNeedsDisplay];
    [[self view] addSubview:drumTapView];
        
    float animDuration = 0.75;
    CGRect frame = [drumTapView frame];
    
    [UIView animateKeyframesWithDuration:animDuration
                                   delay:0.0
                                 options:0
                              animations:^{
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:animDuration
                                                                animations:^{
                                                                    [drumTapView setFrame:CGRectInset(frame, -frame.size.width, -frame.size.height)];
                                                                }];
                                  [UIView addKeyframeWithRelativeStartTime:0
                                                          relativeDuration:3*animDuration/5
                                                                animations:^{
                                                                    [[drumTapView layer] setOpacity:0.0];
                                                                }];
                              }
                              completion:^(BOOL finished) {
                                  [drumTapView removeFromSuperview];
                              }];
}

-(void)animateTitle {
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [[[self titleView] layer] setOpacity:1.0];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                               delay:0.2
                                             options:0
                                          animations:^{
                                              [[[self titleView] layer] setOpacity:0.0];
                                          }
                                          completion:nil];
                     }];
}

- (IBAction)infoButtonTapped:(id)sender {
    
    [self presentViewController:[self infoController]
                       animated:YES
                     completion:nil];
    
}

@end

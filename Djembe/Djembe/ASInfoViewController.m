//
//  ASInfoViewController.m
//  Djembe
//
//  Created by Adam Suskin on 11/3/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import "ASInfoViewController.h"

@interface ASInfoViewController ()

@end

@implementation ASInfoViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (IBAction)closeButtonTapped:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self textView] setText:[self text]];
    [[self textView] setScrollEnabled:YES];
}

-(void)viewDidLoad {
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [[self textView] scrollRangeToVisible:NSMakeRange(0, 1)];
}

@end

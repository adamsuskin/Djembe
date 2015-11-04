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

@end

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self titleLabel] setText:[NSString stringWithFormat:@"View controller %d", (int)[self index]]];
}

@end

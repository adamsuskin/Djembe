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
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [[self titleLabel] setText:[self drum]];
    [[self drumBackground] setImage:[UIImage imageNamed:[self drum]]];
}

@end

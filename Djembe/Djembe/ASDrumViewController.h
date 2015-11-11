//
//  ASDrumViewController.h
//  Djembe
//
//  Created by Adam Suskin on 11/1/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDrumTapView.h"
#import "ASInfoViewController.h"
#import "ASSoundManager.h"

@interface ASDrumViewController : UIViewController

@property (assign, nonatomic) NSUInteger index;
@property (assign, nonatomic) NSString *drum;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UIImageView *drumBackground;

@property (strong, nonatomic) IBOutlet ASInfoViewController *infoController;

-(id)initWithID:(NSUInteger)idf Drum:(NSString *)drum;

-(void)animateTitle;

@end

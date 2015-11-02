//
//  ASDrumViewController.h
//  Djembe
//
//  Created by Adam Suskin on 11/1/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASDrumViewController : UIViewController

@property (assign, nonatomic) NSUInteger index;
@property (assign, nonatomic) NSString *drum;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *drumBackground;

-(id)initWithID:(NSUInteger)idf Drum:(NSString *)drum;

@end

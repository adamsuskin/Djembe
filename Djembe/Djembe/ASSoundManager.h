//
//  ASSoundManager.h
//  Djembe
//
//  Created by Adam Suskin on 11/10/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@interface ASSoundManager : NSObject

@property (strong, nonatomic) NSMutableDictionary *soundDictionary;

+(id)sharedManager;

-(void)playSoundNamed:(NSString *)soundFilename ofType:(NSString *)type;

@end

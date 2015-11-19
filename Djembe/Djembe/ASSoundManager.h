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
@property (assign, nonatomic) BOOL isRecording;

@property (assign, nonatomic) float loopTime;

@property (strong, nonatomic) NSMutableArray *timers;

+(id)sharedManager;

-(void)loopPlay:(id)timer;

-(BOOL)createSoundNamed:(NSString *)soundFilename ofType:(NSString *)type;
-(void)playSoundNamed:(NSString *)soundFilename ofType:(NSString *)type;

@end

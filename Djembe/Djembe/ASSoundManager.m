//
//  ASSoundManager.m
//  Djembe
//
//  Created by Adam Suskin on 11/10/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import "ASSoundManager.h"

@implementation ASSoundManager

+(id)sharedManager {
    static ASSoundManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

-(id)init {
    self = [super init];
    if (self) {
        [self setSoundDictionary:[[NSMutableDictionary alloc] initWithCapacity:9]];
        [self setIsRecording:NO];
        [self setTimers:[[NSMutableArray alloc] init]];
        [self setLoopTime:4.0];
    }
    return self;
}

-(void)dealloc {
    [self cleanUpSounds];
    [self invalidateTimers];
}

-(void)undoLastTimer {
    if([[self timers] count] > 0) {
        [(NSTimer *)[[self timers] lastObject] invalidate];
        [[self timers] removeLastObject];
    }
}

-(void)invalidateTimers {
    for (NSTimer *timer in [self timers]) {
        [timer invalidate];
    }
    [[self timers] removeAllObjects];
}

-(BOOL)isLooping {
    return [[self timers] count] > 0;
}

-(void)cleanUpSounds {
    NSEnumerator *keyEnumerator = [[self soundDictionary] keyEnumerator];
    
    NSString *key = [keyEnumerator nextObject];
    
    while(key) {
        AudioServicesDisposeSystemSoundID([self getSoundID:key]);
        key = [keyEnumerator nextObject];
    }
}

-(SystemSoundID)getSoundID:(NSString *)soundFilename {
    return [(NSNumber *)[[self soundDictionary] objectForKey:soundFilename] unsignedIntValue];
}

-(BOOL)createSoundNamed:(NSString *)soundFilename ofType:(NSString *)type {
    NSURL *pathURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:soundFilename ofType:type]];
    
    SystemSoundID tmpSoundID, realSoundID;
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)pathURL, &tmpSoundID);
    
    if(error == kAudioServicesNoError) {
        realSoundID = tmpSoundID;
        [[self soundDictionary] setObject:[NSNumber numberWithUnsignedInt:realSoundID] forKey:soundFilename];
        
        return YES;
    }
    
    return NO;
}

-(void)playSoundNamed:(NSString *)soundFilename ofType:(NSString *)type {
    if(![[self soundDictionary] objectForKey:soundFilename])
        [self createSoundNamed:soundFilename ofType:type];
    
    AudioServicesPlaySystemSound([self getSoundID:soundFilename]);
}

- (void)loopPlay:(id)timer {
    [self playSoundNamed:[(NSDictionary *)[(NSTimer *)timer userInfo] objectForKey:@"soundfile"] ofType:nil];
}

@end

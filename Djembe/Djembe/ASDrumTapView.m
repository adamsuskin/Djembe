//
//  ASDrumTapView.m
//  Djembe
//
//  Created by Adam Suskin on 11/2/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

#import "ASDrumTapView.h"

@implementation ASDrumTapView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateWithEllipseInRect(CGRectInset(rect, 2, 2), NULL);
    CGPathAddEllipseInRect(path, NULL, CGRectInset(rect, 4, 4));
    
    [[UIColor clearColor] setFill];
    //rgb(52, 73, 94)
    [[UIColor colorWithRed:52.f/255.f green:73.f/255.f blue:94.f/255.f alpha:1] setStroke];
    
    CGContextAddPath(context, path);
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGPathRelease(path);
}

@end

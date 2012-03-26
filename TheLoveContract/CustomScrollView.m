//
//  CustomScrollView.m
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/23/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "CustomScrollView.h"


@implementation CustomScrollView
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"CustomScrollView touched began!");
    
    UITouch *touch = [[event allTouches] anyObject];
    NSLog(@"TouchVIEW IS A %@",touch.view);
    CGPoint location = [touch locationInView:touch.view];
    
    UIView *sub = [[UIView alloc]init];
    sub = [[self subviews] objectAtIndex:0] ;

    for (int i = 1; i < [[sub subviews] count]; i++ ) {
        UIView *aView = [[sub subviews] objectAtIndex:i];
        
        if (CGRectContainsPoint([aView frame], [touch locationInView:sub])) {
            aView.center = location;
        }
    }
    
    //[sub release];
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
    NSLog(@"CustomScrollView touched!");
    
    //UITouch *touch = [[event allTouches] anyObject];

}

@end

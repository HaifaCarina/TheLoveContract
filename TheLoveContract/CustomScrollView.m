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
    
    CGPoint location = [touch locationInView:touch.view];
    UIView *sub = [[UIView alloc]init];
    sub = [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:1];
    sub.backgroundColor = [UIColor blueColor];
    sub.center = location;
    NSLog(@"SUBVIEW IS A %@",sub);
    /*//CGPoint location = [[touches anyObject] locationInView : imageScrollView];
    CGPoint location = [touch locationInView:touch.view];
    UIView *object = touch.view;
    NSLog(@"%@",touch.view);
    
    //isKindOfClass:[UIRotationGestureRecognizer class]
    //contentView.center = location;
    */
    
}
-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
	if (!self.dragging) {
		[self.nextResponder touchesEnded: touches withEvent:event]; 
	}		
    
	[super touchesEnded: touches withEvent: event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
    NSLog(@"CustomScrollView touched!");
    
    UITouch *touch = [[event allTouches] anyObject];

}

@end

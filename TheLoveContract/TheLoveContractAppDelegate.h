//
//  TheLoveContractAppDelegate.h
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/12/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//
/*
 TO DO:
 - Movable element
 
 FIX:
 - rotate + zoom = SGBRT error
 - back button loses the image
 - Fix scrollview internal components and customization logic
 
 */
#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface TheLoveContractAppDelegate : NSObject <UIApplicationDelegate> {
    RootViewController *viewController;
    UINavigationController *navController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;
@property (nonatomic, retain) UINavigationController *navController;

@end

//
//  PhotoEditViewController.h
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/19/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalData.h"
#import <QuartzCore/QuartzCore.h>
#import "StickersViewController.h"
#import "CustomScrollView.h"

@interface PhotoEditViewController : UIViewController <UIScrollViewDelegate>{
    UIImageView *imageView;
    int angle;
    UIImage *image;
    //UIScrollView *imageScrollView;
    CustomScrollView *imageScrollView;
    float maximumScale;
    UIRotationGestureRecognizer *rotationRecognizer;
    float scrollViewScale;
    UIButton *zoomButton;
    UIButton *rotateButton;
    UIView *contentView;
}

@end

//
//  RootViewController.h
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/12/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameViewController.h"

@interface RootViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate> {
    UIImagePickerController *imgPicker;
    UIImageView *image;
    UIImage *currentImage;
}

@property (nonatomic, retain) UIImagePickerController *imgPicker;

@end

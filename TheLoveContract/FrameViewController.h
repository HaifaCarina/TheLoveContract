//
//  FrameViewController.h
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/14/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SHKItem.h"
#import "SHKActionSheet.h"
#import "PhotoEditViewController.h"
#import "GlobalData.h"
@interface FrameViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate, UIScrollViewDelegate>{
    
    UIImagePickerController *imgPicker;
    int tag;
    int currentPhotoTag;
    UIImageView *photoView1;
    UIImageView *photoView2;
    UIView *contentView1;
    UIView *contentView2;
    UIImageView *templateView;
    UIScrollView *scrollview1;
    UIScrollView *scrollview2;
    CGRect scrollviewRect1;
    CGRect scrollviewRect2;
    
}

@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic) int tag;
@property (nonatomic) int currentPhotoTag;

- (id) initWithTag:(int)tagNumber;

@end

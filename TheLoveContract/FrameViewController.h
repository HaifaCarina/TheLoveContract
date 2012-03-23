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
    UIImageView *image;
    UIImage *currentImage;
    int tag;
    int currentPhotoTag;
    UIImage *photo1;
    UIImage *photo2;
    UIImageView *photo1View;
    UIImageView *photo2View;
    UIView *contentView1;
    UIView *contentView2;
    
    UIImageView *resultingView;
    UIScrollView *scrollview1;
    UIScrollView *scrollview2;
    CGRect visibleRect;
    float photoScale1;
    float photoScale2;
    CGRect scrollviewRect1;
    CGRect scrollviewRect2;
    
}

@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (nonatomic, retain) UIImage *photo1;
@property (nonatomic, retain) UIImage *photo2;
@property (nonatomic) int tag;
@property (nonatomic) int currentPhotoTag;
@property (nonatomic) float photoScale1;

- (id) initWithTag:(int)tagNumber;

@end

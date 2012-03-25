//
//  StickersViewController.m
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/21/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "StickersViewController.h"


@implementation StickersViewController

- (void) handleLongPress: (UILongPressGestureRecognizer *) recognizer {
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void) singleTapGestureCaptured: (UITapGestureRecognizer *) recognizer {
    NSLog(@"%d",[recognizer view].tag);
    
    PhotoEditViewController *aController = [[PhotoEditViewController alloc]init];
    
    switch ([recognizer view].tag) {
        case 1:
        {
            [GlobalData sharedGlobalData].sticker = sticker1;
            break;
        }
        case 2: 
        {
            [GlobalData sharedGlobalData].sticker = sticker2;
            break;
        }
        case 3: 
        {
            [GlobalData sharedGlobalData].sticker = sticker3;
            break;
        }
        case 4: 
        {
            [GlobalData sharedGlobalData].sticker = sticker4;
            break;
        }
         
    }
    [aController release];
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void) loadView {
    [super loadView];
    
    
        
    sticker1 = [UIImage imageNamed:@"spongebob.png"];
    UIImageView *sticker1View = [[UIImageView alloc]initWithImage:sticker1];
    sticker1View.frame = CGRectMake(0, 0, 90, 90);
    sticker1View.tag = 1;
    sticker1View.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [sticker1View addGestureRecognizer:singleTap1]; 
    [singleTap1 release];
    
    sticker2 = [UIImage imageNamed:@"bunny.png"];
    UIImageView *sticker2View = [[UIImageView alloc]initWithImage:sticker2];
    sticker2View.frame = CGRectMake(0, 100, 90, 90);
    sticker2View.tag = 2;
    sticker2View.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [sticker2View addGestureRecognizer:singleTap2]; 
    [singleTap2 release];
    
    sticker3 = [UIImage imageNamed:@"heart.png"];
    UIImageView *sticker3View = [[UIImageView alloc]initWithImage:sticker3];
    sticker3View.frame = CGRectMake(0, 200, 90, 90);
    sticker3View.tag = 3;
    sticker3View.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [sticker3View addGestureRecognizer:singleTap3]; 
    [singleTap3 release];
    
    sticker4 = [UIImage imageNamed:@"star.png"];
    UIImageView *sticker4View = [[UIImageView alloc]initWithImage:sticker4];
    sticker4View.frame = CGRectMake(0, 300, 90, 90);
    sticker4View.tag = 4;
    sticker4View.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [sticker4View addGestureRecognizer:singleTap4]; 
    [singleTap4 release];
    
    UIScrollView *imageScrollView = [[UIScrollView alloc]initWithFrame: self.view.frame];
    imageScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 800);
    imageScrollView.scrollEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = YES;
    imageScrollView.showsVerticalScrollIndicator = YES;
    imageScrollView.backgroundColor = [UIColor blueColor];
    imageScrollView.userInteractionEnabled = YES;
    imageScrollView.tag = 100;
    
    
    [imageScrollView addSubview:sticker1View];
    [imageScrollView addSubview:sticker2View];
    [imageScrollView addSubview:sticker3View];
    [imageScrollView addSubview:sticker4View];
    
    [sticker1View release];
    [sticker2View release];
    [sticker3View release];
    [sticker4View release];
    
    [self.view addSubview:imageScrollView];
    [imageScrollView release];
    
    
    UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPressRecognizer];
    [longPressRecognizer release];
}

- (void) dealloc {
    [super dealloc];
}

@end

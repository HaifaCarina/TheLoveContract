//
//  GlobalData.h
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/20/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GlobalData : NSObject {
    UIImage *currentPhoto;
    UIScrollView *currentScrollView;
    
}

@property (nonatomic, retain) UIImage *currentPhoto;
@property (nonatomic, retain) UIScrollView *currentScrollView;
+ (GlobalData*)sharedGlobalData;

@end

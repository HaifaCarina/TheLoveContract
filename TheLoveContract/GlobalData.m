//
//  GlobalData.m
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/20/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "GlobalData.h"


@implementation GlobalData
@synthesize currentPhoto,currentPhotoView, currentScrollView, currentPhotoTag, fromEffectsTag, sticker,photo1, photo2;

static GlobalData *sharedGlobalData = nil;
+ (GlobalData*)sharedGlobalData {
    if (sharedGlobalData == nil) {
        sharedGlobalData = [[super allocWithZone:NULL] init];
        
        // initialize your variables here
        sharedGlobalData.currentPhoto = nil;
        sharedGlobalData.currentPhotoView = nil;
        sharedGlobalData.currentScrollView = [[UIScrollView alloc]init];
        sharedGlobalData.sticker = nil;
        sharedGlobalData.currentPhotoTag = 0;
        sharedGlobalData.fromEffectsTag = 0;
        sharedGlobalData.photo1 = nil;
        sharedGlobalData.photo2 = nil;
    
		
    }
    return sharedGlobalData;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self)
    {
        if (sharedGlobalData == nil)
        {
            sharedGlobalData = [super allocWithZone:zone];
            return sharedGlobalData;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax; //denotes an object that cannot be released
}

- (id)autorelease {
    return self;
}

@end

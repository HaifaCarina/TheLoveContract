//
//  PhotoEditViewController.m
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/19/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "PhotoEditViewController.h"

@implementation PhotoEditViewController


- (UIImage *) blackAndWhiteEffect: (UIImage *)originalImage {
    
    //UIImage *originalImage = [UIImage imageNamed:@"frame.png"]; // this image we get from UIImagePickerController
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    
    
    CGContextRef context = CGBitmapContextCreate(nil, originalImage.size.width, originalImage.size.height, 8, originalImage.size.width, colorSapce, kCGImageAlphaNone);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, originalImage.size.width, originalImage.size.height), [originalImage CGImage]);
    
    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);
    
    UIImage *resultImage = [UIImage imageWithCGImage:bwImage]; // This is result B/W image.
    CGImageRelease(bwImage);
    
    return resultImage;
}
- (UIImage *) sepiaEffect: (UIImage *)originalImage {
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:originalImage];
    
    UIGraphicsBeginImageContext(CGSizeMake(imgView.image.size.width,imgView.image.size.height));  
	
	CGRect imageRect = CGRectMake(0, 0, imgView.image.size.width, imgView.image.size.height);
	[imgView.image drawInRect:imageRect]; 
	[[UIImage imageNamed:@"sepia.png"] drawInRect:imageRect blendMode:kCGBlendModeScreen alpha:0.5];  
	
	UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();  
	UIGraphicsEndImageContext();
    
    [imgView release];
    return resultImage;
    
}

- (UIImage *) blueEffect: (UIImage *)originalImage {
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:originalImage];
    
    UIGraphicsBeginImageContext(CGSizeMake(imgView.image.size.width,imgView.image.size.height));  
	
	CGRect imageRect = CGRectMake(0, 0, imgView.image.size.width, imgView.image.size.height);
	[imgView.image drawInRect:imageRect]; 
	[[UIImage imageNamed:@"blue.png"] drawInRect:imageRect blendMode:kCGBlendModeScreen alpha:0.9];  
	
	UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();  
	UIGraphicsEndImageContext();
    
    [imgView release];
    return resultImage;
    
}
- (void) selectEffects: (UIButton *) button {
    NSLog(@"Select effects");
    /*
     imageScrollView.transform = CGAffineTransformIdentity;
     imageScrollView.contentOffset = CGPointZero;
     imageScrollView.contentSize = imageScrollView.frame.size;
     
     [photo1View removeFromSuperview];
     //imageView = [[TapDetectingImageView alloc] initWithImage:newImage];
     
     [imageScrollView addSubview: photo1View];
     */
    //[[[imageScrollView subviews] objectAtIndex:0] removeFromSuperview];
    [imageView removeFromSuperview];
    switch (button.tag)
    {
        case 1:
        {
            imageView.image = [self blackAndWhiteEffect: image];
            //imageView.image = [self blackAndWhiteEffect: [[[imageScrollView subviews] objectAtIndex:0] image]];
            //imageView.image = image;//[[[imageScrollView subviews] objectAtIndex:0] image];
            break;
        }
        case 2:
        {
            imageView.image = [self sepiaEffect: image];
            break;
        }
        case 3:
        {
            imageView.image = [self blueEffect: image];
            break;
        }
        case 4:
        {
            button.layer.borderWidth = 2;
            button.layer.borderColor = [UIColor blackColor].CGColor;
            maximumScale = imageScrollView.maximumZoomScale;
            imageScrollView.maximumZoomScale = imageScrollView.minimumZoomScale;
            imageScrollView.scrollEnabled = NO;
            rotationRecognizer.enabled = YES;
            
            zoomButton.layer.borderWidth = 0;
            NSLog(@"rotate");
            break;
        }
        case 5:
        {
            button.layer.borderWidth = 2;
            button.layer.borderColor = [UIColor blackColor].CGColor;
            imageScrollView.maximumZoomScale = maximumScale;
            imageScrollView.scrollEnabled = YES;
            rotationRecognizer.enabled = NO;
            rotateButton.layer.borderWidth = 0;
            NSLog(@"zoom");
            break;
        }
        case 6:
        {
            button.layer.borderWidth = 2;
            button.layer.borderColor = [UIColor blackColor].CGColor;
            //maximumScale = imageScrollView.maximumZoomScale;
            //imageScrollView.maximumZoomScale = imageScrollView.minimumZoomScale;
            imageScrollView.scrollEnabled = NO;
            rotationRecognizer.enabled = NO;
            
            zoomButton.layer.borderWidth = 0;
            rotateButton.layer.borderWidth = 0;
            
            StickersViewController *aController = [[StickersViewController alloc]init];
            //[self.navigationController pushViewController:aController animated:YES];
            aController.modalPresentationStyle  = UIModalPresentationPageSheet;
            aController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:aController animated:YES];
            NSLog(@"stick");
            break;
        }
    }
    
    //[imageScrollView addSubview:imageView];
    [contentView addSubview:imageView];
}

- (void) handleTap: (id) sender {
    NSLog(@"TAP TAP");
}

- (void) handleRotate: (UIRotationGestureRecognizer *)recognizer {
    
    
    float rotation = angle + -recognizer.rotation;		
	
    NSLog(@"BEFORE IMAGE VIEW SIZE %f,%f,%f,%f", imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    //imageView.transform = CGAffineTransformMakeRotation(-rotation);
	//CGSizeApplyAffineTransform(CGSizeMake(imageView.frame.size.width, imageView.frame.size.height), contentView.transform);
    
    //contentView.transform = CGAffineTransformMakeRotation(-rotation); 
    
	contentView.transform = (CGAffineTransform) CGAffineTransformRotate (contentView.transform, -rotation);
	
    //contentView.transform = (CGAffineTransform) CGAffineTransformRotate (contentView.transform, -rotation);
	// once the user has finsihed the rotate, save the new angle
    
    NSLog(@"Rotation: %f", rotation);
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		angle = rotation;
        NSLog(@"AFTER IMAGE VIEW SIZE %f,%f,%f,%f", imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
        NSLog(@"SCROLLVIEW CONTENT SIZE %f - %f", imageScrollView.contentSize.width, imageScrollView.contentSize.height);
        
        NSLog(@"handleRotateIMAGE VIEW SIZE %f - %f", imageView.frame.size.width, imageView.frame.size.height);
        NSLog(@"handleRotate SCROLLVIEW CONTENT SIZE %f - %f", imageScrollView.contentSize.width, imageScrollView.contentSize.height);
        NSLog(@"handleRotate SCROLLVIEW ZOOM MAX MIN %f - %f", imageScrollView.maximumZoomScale, imageScrollView.minimumZoomScale);
        
        
	}
    
    //NSLog(@"HANDLE ROTATE %f", rotation);
    
}
- (void) handleLongPress: (UILongPressGestureRecognizer *) recognizer {
    [[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void) doneAction {
    NSLog(@"done action pressed");
    /*
     [GlobalData sharedGlobalData].currentScrollView = imageScrollView;
     NSLog(@"HEADACHE %@",[[[GlobalData sharedGlobalData].currentScrollView subviews] objectAtIndex:0]);
     NSMutableArray *allControllers = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
     NSLog(@"%@",[allControllers objectAtIndex:[allControllers count] - 2]);
     //[[allControllers objectAtIndex:[allControllers count] - 2] viewWillAppear:YES];
     [allControllers release];
     */
    
    /*
     [imageScrollView setZoomScale:(tmpScrollView.zoomScale / scrollViewScale) animated:YES];
     [imageScrollView setContentOffset:CGPointMake(tmpScrollView.contentOffset.x* scrollViewScale, tmpScrollView.contentOffset.y* scrollViewScale)];
     imageView.frame = CGRectMake(0, 0, image.size.width / scrollViewScale, image.size.height/ scrollViewScale);
     
     */
    /*
    NSLog(@"BEFORE DONE IMAGE VIEW SIZE %f,%f,%f,%f", imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    NSLog(@"BEFORE DONE SCROLLVIEW CONTENT SIZE %f - %f", imageScrollView.contentSize.width, imageScrollView.contentSize.height);
    NSLog(@"BEFORE SCROLLVIEW OFFSET %f - %f", imageScrollView.contentOffset.x, imageScrollView.contentOffset.y);
    NSLog(@"BEFORE SCROLLVIEW ZOOMSCALE %f ", imageScrollView.zoomScale);
    
    imageScrollView.frame = [GlobalData sharedGlobalData].currentScrollView.frame;
    //imageScrollView.contentSize = [GlobalData sharedGlobalData].currentScrollView.frame.size;
    [imageScrollView setZoomScale:(imageScrollView.zoomScale * scrollViewScale) animated:YES];
    [imageScrollView setContentOffset:CGPointMake(imageScrollView.contentOffset.x/ scrollViewScale, imageScrollView.contentOffset.y/ scrollViewScale)];
    
    //imageView.frame = CGRectMake(0, 0, image.size.width * scrollViewScale, image.size.height* scrollViewScale);
    float x = (imageScrollView.zoomScale * scrollViewScale);
    NSLog(@"2 DIFFERENCE ZOOMSCALE %f - %f", x, imageScrollView.zoomScale);
    
    NSLog(@"AFTER DONE IMAGE VIEW SIZE %f,%f,%f,%f", imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    NSLog(@"AFTER DONE SCROLLVIEW CONTENT SIZE %f - %f", imageScrollView.contentSize.width, imageScrollView.contentSize.height);
    NSLog(@"AFTER SCROLLVIEW OFFSET %f - %f", imageScrollView.contentOffset.x, imageScrollView.contentOffset.y);
    NSLog(@"AFTER SCROLLVIEW ZOOMSCALE %f ", imageScrollView.zoomScale);
    
    */
    
/*    UIGraphicsBeginImageContext(contentView.bounds.size);
    [contentView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *resultImageView = [[UIImageView alloc]initWithImage:resultImage];
    resultImageView.frame = CGRectMake(0, 0, resultImage.size.width, resultImage.size.height);
    
    [contentView removeFromSuperview];
    [imageScrollView addSubview:resultImageView];
    
    */
    
    [GlobalData sharedGlobalData].fromEffectsTag = 1;
    imageScrollView.layer.borderWidth = 0;
    imageScrollView.maximumZoomScale = maximumScale;
    imageScrollView.scrollEnabled = YES;
    [GlobalData sharedGlobalData].currentScrollView = imageScrollView;
    [self.navigationController popViewControllerAnimated:YES];
    //[[self parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void) addSticker:(UIImage *)img {
    NSLog(@"AddSticker%f",img.size.width);
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    imgView.frame = CGRectMake(0, 0, 50, 50);
    //[imageView removeFromSuperview];
    //[contentView addSubview:imageView];
    [contentView addSubview:imgView];
    [imageView removeFromSuperview];
    [contentView addSubview:imageView];
    [contentView sendSubviewToBack:imageView];
    //[contentView removeFromSuperview];
    //[imageScrollView addSubview:contentView];
    //[imageScrollView addSubview:imgView];
    //[self.view  addSubview:imgView];
    [imgView release];
    
}

#pragma mark -
#pragma mark LifeCycle

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    if([GlobalData sharedGlobalData].sticker != nil) {
        NSLog(@"add sticker add sticker add sticker");
        
        [self addSticker:[GlobalData sharedGlobalData].sticker];
        [GlobalData sharedGlobalData].sticker = nil;
    }
}

- (void) loadView {
    [super loadView];
   
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Done"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(doneAction)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
        
     rotationRecognizer = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotate:)];
     [self.view addGestureRecognizer:rotationRecognizer];
      rotationRecognizer.enabled = NO;
     [rotationRecognizer release];
    
    
    UIButton *bwButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[bwButton addTarget:self  action:@selector(selectEffects:) forControlEvents:UIControlEventTouchDown];
	[bwButton setTitle:@"B&W" forState:UIControlStateNormal];
    bwButton.frame = CGRectMake(0, 10, 50,50);
    bwButton.tag = 1;
    
    UIButton *sepiaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[sepiaButton addTarget:self  action:@selector(selectEffects:) forControlEvents:UIControlEventTouchDown];
	[sepiaButton setTitle:@"Sepia" forState:UIControlStateNormal];
    sepiaButton.frame = CGRectMake(60, 10, 50,50);
    sepiaButton.tag = 2;
    
    UIButton *blueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[blueButton addTarget:self  action:@selector(selectEffects:) forControlEvents:UIControlEventTouchDown];
	[blueButton setTitle:@"Blue" forState:UIControlStateNormal];
    blueButton.frame = CGRectMake(120, 10, 50,50);
	blueButton.tag = 3;
    
    rotateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[rotateButton addTarget:self  action:@selector(selectEffects:) forControlEvents:UIControlEventTouchDown];
	[rotateButton setTitle:@"Rotate" forState:UIControlStateNormal];
    rotateButton.frame = CGRectMake(180, 10, 50,50);
	rotateButton.tag = 4;
    
    zoomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[zoomButton addTarget:self  action:@selector(selectEffects:) forControlEvents:UIControlEventTouchDown];
	[zoomButton setTitle:@"Zoom" forState:UIControlStateNormal];
    zoomButton.frame = CGRectMake(240, 10, 50,50);
	zoomButton.tag = 5;
    zoomButton.layer.borderWidth = 2;
    zoomButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    UIButton *stickerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[stickerButton addTarget:self  action:@selector(selectEffects:) forControlEvents:UIControlEventTouchDown];
	[stickerButton setTitle:@"Stick" forState:UIControlStateNormal];
    stickerButton.frame = CGRectMake(300, 10, 50,50);
	stickerButton.tag = 6;
    
    
    UIScrollView *effectsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 340, 320, 80)];
    effectsScrollView.backgroundColor = [UIColor redColor];
    effectsScrollView.contentSize = CGSizeMake(500, 80);
    effectsScrollView.showsHorizontalScrollIndicator = YES;
    
    [effectsScrollView addSubview:bwButton];
    [effectsScrollView addSubview:sepiaButton];
    [effectsScrollView addSubview:blueButton];
    [effectsScrollView addSubview:rotateButton];
    [effectsScrollView addSubview:zoomButton];
    [effectsScrollView addSubview:stickerButton];
    
    /*UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
     [effectsScrollView addGestureRecognizer:tapRecognizer];
     [tapRecognizer release];
     */
    [self.view addSubview:effectsScrollView];
    [effectsScrollView release];
    
    //imageView.frame = CGRectMake(5, 5, 100, 180);
    NSLog(@"PHOTO Zoom scale %f", [GlobalData sharedGlobalData].currentScrollView.zoomScale);
    
    
    UIScrollView *tmpScrollView = [GlobalData sharedGlobalData].currentScrollView;
    
    //imageScrollView = [[UIScrollView alloc]initWithFrame: CGRectMake(0, 0, tmpScrollView.frame.size.width, tmpScrollView.frame.size.height)];
    imageScrollView = [[CustomScrollView alloc]initWithFrame: CGRectMake(0, 0, tmpScrollView.frame.size.width, tmpScrollView.frame.size.height)];
    imageScrollView.scrollEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = YES;
    imageScrollView.showsVerticalScrollIndicator = YES;
    imageScrollView.delegate = self;
    imageScrollView.maximumZoomScale = tmpScrollView.maximumZoomScale;//50;
    imageScrollView.minimumZoomScale = tmpScrollView.minimumZoomScale;//.5;
    imageScrollView.layer.borderWidth = 2;
    imageScrollView.layer.borderColor = [UIColor blackColor].CGColor;
    
    // START ORIGINAL CODE
    // SET ZOOM SCALE AND OFFSETS
    [imageScrollView setZoomScale:tmpScrollView.zoomScale animated:YES];
    [imageScrollView setContentOffset:CGPointMake(tmpScrollView.contentOffset.x , tmpScrollView.contentOffset.y)];
    
    [imageScrollView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-CGRectGetMidY([effectsScrollView bounds])-20)];
    
    
    // BACk to original code			
    //image = [GlobalData sharedGlobalData].currentPhoto; //[UIImage imageNamed:@"image.png"];
    //imageView =  [GlobalData sharedGlobalData].currentPhotoView;//[[UIImageView alloc]initWithImage:image]; //[[imageScrollView subviews] objectAtIndex:0];//
    imageView =  [GlobalData sharedGlobalData].currentPhotoView;
    image = [[GlobalData sharedGlobalData].currentPhotoView image];
    imageView.frame = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
    //image = [[[[[tmpScrollView subviews] objectAtIndex:0] subviews ]objectAtIndex:0]image];
    //imageView = [[[[tmpScrollView subviews] objectAtIndex:0] subviews ]objectAtIndex:0];
    
    imageScrollView.contentSize = imageView.frame.size;
    //[imageScrollView addSubview:imageView];
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, imageScrollView.contentSize.width, imageScrollView.contentSize.height)];
    //contentView.backgroundColor = [UIColor blueColor];
    [contentView addSubview:imageView];
    [contentView sendSubviewToBack:imageView];
    [imageScrollView addSubview:contentView];
    [self.view  addSubview:imageScrollView];
    
    
    // END ORIGINAL CODE
     
    
    
    /*
     * I'm trying to resize the image. Doesn't work. Two days wasted. Sucks.
     */
    /*
    float height = self.view.frame.size.height-effectsScrollView.frame.size.height-50;
    float width = (tmpScrollView.frame.size.width/tmpScrollView.frame.size.height) * height;
    scrollViewScale = tmpScrollView.frame.size.width/tmpScrollView.frame.size.height;
    
    
    // Set the scrollview with the calculated dimension
    imageScrollView.frame = CGRectMake(0, 0, width, height);
    [imageScrollView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-CGRectGetMidY([effectsScrollView bounds])-20)];
    
    image = [GlobalData sharedGlobalData].currentPhoto; 
    imageView =  [[UIImageView alloc]initWithImage:image]; 
    imageView.frame = CGRectMake(0, 0, image.size.width / scrollViewScale, image.size.height/ scrollViewScale);
    imageScrollView.contentSize = imageView.frame.size;
    
    [imageScrollView addSubview:imageView];
    
    [imageScrollView setContentOffset:CGPointMake(-tmpScrollView.contentOffset.x * scrollViewScale, -tmpScrollView.contentOffset.y* scrollViewScale)];
    
    [imageScrollView setZoomScale:(tmpScrollView.zoomScale / scrollViewScale) animated:YES];
    
    UIImageView *tmpImageView = [[tmpScrollView subviews] objectAtIndex:0];
    //NSLog(@"SCROLL VIEW SCALE %f", scrollViewScale);
    NSLog(@"TMP IMAGE VIEW SIZE %f,%f,%f,%f", tmpImageView.frame.origin.x, tmpImageView.frame.origin.y, tmpImageView.frame.size.width, tmpImageView.frame.size.height);
    NSLog(@"TMP SCROLLVIEW CONTENT SIZE %f - %f", tmpScrollView.contentSize.width, tmpScrollView.contentSize.height);
    NSLog(@"TMP SCROLLVIEW OFFSET %f - %f", tmpScrollView.contentOffset.x, tmpScrollView.contentOffset.y);
    NSLog(@"TMP SCROLLVIEW ZOOMSCALE %f ", tmpScrollView.zoomScale);
    
    NSLog(@"CURRENT IMAGE VIEW SIZE %f,%f,%f,%f", imageView.frame.origin.x, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    NSLog(@"CURRENT SCROLLVIEW CONTENT SIZE %f - %f", imageScrollView.contentSize.width, imageScrollView.contentSize.height);
    NSLog(@"CURRENT SCROLLVIEW OFFSET %f - %f", imageScrollView.contentOffset.x, imageScrollView.contentOffset.y);
    NSLog(@"CURRENT SCROLLVIEW ZOOMSCALE %f ", imageScrollView.zoomScale);
    
    [self.view  addSubview:imageScrollView];
    */
    
    /*
     imageScrollView = [GlobalData sharedGlobalData].currentScrollView;
     imageScrollView.layer.borderWidth = 2;
     imageScrollView.layer.borderColor = [UIColor blackColor].CGColor;
     imageScrollView.clipsToBounds = YES;
     imageScrollView.frame = CGRectMake(0, 0, imageScrollView.frame.size.width, imageScrollView.frame.size.height);
     [imageScrollView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-CGRectGetMidY([effectsScrollView bounds])-20)];
     [self.view  addSubview:imageScrollView];
     */
    
    //NSLog(@"%@",[[[GlobalData sharedGlobalData].currentScrollView subviews]objectAtIndex:0] );
    //imageView = [[imageScrollView subviews] objectAtIndex:0];
    
    
    UILongPressGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPressRecognizer];
    [longPressRecognizer release];
    
    
}
#pragma mark -
#pragma mark UIScrollView Delegate
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    NSLog(@"it is zoooooooooming");
    //return imageView;

    return contentView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)zoomedScrollView withView:(UIView *)view atScale:(float)scale
{
    
    NSLog(@"scrollViewDidEndZooming VIEW SIZE %f - %f", view.frame.size.width, view.frame.size.height);
    NSLog(@"scrollViewDidEndZoomingIMAGE VIEW SIZE %f - %f", imageView.frame.size.width, imageView.frame.size.height);
    NSLog(@"scrollViewDidEndZooming SCROLLVIEW CONTENT SIZE %f - %f", imageScrollView.contentSize.width, imageScrollView.contentSize.height);
    NSLog(@"scrollViewDidEndZooming SCROLLVIEW ZOOM MAX MIN %f - %f", imageScrollView.maximumZoomScale, imageScrollView.minimumZoomScale);
    
    imageScrollView.contentSize = view.frame.size;
    //imageView.frame = view.frame;
    contentView.frame = view.frame;
    /*
    CGSize nowSize = view.frame.size;
    
    if (nowSize.height >= imageScrollView.frame.size.height)
        imageScrollView.contentInset = UIEdgeInsetsZero;
    else {
        CGFloat delta = imageScrollView.frame.size.height/2 - view.frame.size.height/2;
        imageScrollView.contentInset = UIEdgeInsetsMake(delta, 0, delta, 0);
    }
    */
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if (![gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]] && ![otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        NSLog(@"Recognize both");
        return YES;
    }
    return NO;
}
/*
 -(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     
     UITouch *touch = [[event allTouches] anyObject];
     
     CGPoint location = [touch locationInView:touch.view];
     imageView.center = location;
 
 }
 
 
 -(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
     [self touchesBegan:touches withEvent:event];
     NSLog(@"touched!");
 
     UITouch *touch = [[event allTouches] anyObject];
     if ([touch view] == imageView) {
         NSLog(@"IT IS image!");
     }
 }
 
*/

/*
 
 //NO WORKING
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
 // get touch event
 UITouch *touch = [[event allTouches] anyObject];
 CGPoint touchLocation = [touch locationInView:touch.view];
 
 if ([touch view] == imageView) {
 // move the image view
 imageView.center = touchLocation;
 } 
 else if ([touch view] == image2) {
 // move the image view
 image2.center = touchLocation;
 }
 }*/

- (void) dealloc {
    [super dealloc];
}
@end

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
    [[[imageScrollView subviews] objectAtIndex:0] removeFromSuperview];
    
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
            NSLog(@"rotate");
            break;
        }
    }
    
    [imageScrollView addSubview:imageView];
}

- (void) handleTap: (id) sender {
    NSLog(@"TAP TAP");
}
- (void) handleRotate: (UIRotationGestureRecognizer *)recognizer {
    
    
    float rotation = angle + -recognizer.rotation;	
	//imageScrollView.transform = CGAffineTransformMakeRotation(-rotation);
    imageView = [[imageScrollView subviews] objectAtIndex:0];
    imageView.transform = CGAffineTransformMakeRotation(-rotation);
	
	// once the user has finsihed the rotate, save the new angle
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		angle = rotation;
	}
    
    NSLog(@"HANDLE ROTATE %f", rotation);
    
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
    
    [GlobalData sharedGlobalData].fromEffectsTag = 1;
    
    imageScrollView.layer.borderWidth = 0;
    [GlobalData sharedGlobalData].currentScrollView = imageScrollView;
    
    [self.navigationController popViewControllerAnimated:YES];
    //[[self parentViewController] dismissModalViewControllerAnimated:YES];
}
- (void) loadView {
    [super loadView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Done"                                            
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(doneAction)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    /*    
     UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotate:)];
     [self.view addGestureRecognizer:rotationRecognizer];
     [rotationRecognizer release];
     */
    
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
    
    UIButton *rotateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[rotateButton addTarget:self  action:@selector(selectEffects:) forControlEvents:UIControlEventTouchDown];
	[rotateButton setTitle:@"Rotate" forState:UIControlStateNormal];
    rotateButton.frame = CGRectMake(180, 10, 50,50);
	rotateButton.tag = 4;
    
    UIScrollView *effectsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 340, 320, 80)];
    effectsScrollView.backgroundColor = [UIColor redColor];
    effectsScrollView.contentSize = CGSizeMake(800, 80);
    effectsScrollView.showsHorizontalScrollIndicator = YES;
    
    [effectsScrollView addSubview:bwButton];
    [effectsScrollView addSubview:sepiaButton];
    [effectsScrollView addSubview:blueButton];
    [effectsScrollView addSubview:rotateButton];
    
    /*UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
     [effectsScrollView addGestureRecognizer:tapRecognizer];
     [tapRecognizer release];
     */
    [self.view addSubview:effectsScrollView];
    
    
    //imageView.frame = CGRectMake(5, 5, 100, 180);
    NSLog(@"PHOTO Zoom scale %f", [GlobalData sharedGlobalData].currentScrollView.zoomScale);
    UIScrollView *tmpScrollView = [GlobalData sharedGlobalData].currentScrollView;
    
    imageScrollView = [[UIScrollView alloc]initWithFrame: CGRectMake(0, 0, tmpScrollView.frame.size.width, tmpScrollView.frame.size.height)];
    imageScrollView.scrollEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = YES;
    imageScrollView.showsVerticalScrollIndicator = YES;
    imageScrollView.delegate = self;
    imageScrollView.maximumZoomScale = tmpScrollView.maximumZoomScale;//50;
    imageScrollView.minimumZoomScale = tmpScrollView.minimumZoomScale;//.5;
    imageScrollView.layer.borderWidth = 2;
    imageScrollView.layer.borderColor = [UIColor blackColor].CGColor;
    
    // SET ZOOM SCALE AND OFFSETS
    [imageScrollView setZoomScale:tmpScrollView.zoomScale animated:YES];
    [imageScrollView setContentOffset:CGPointMake(tmpScrollView.contentOffset.x , tmpScrollView.contentOffset.y)];
    
    [imageScrollView setCenter:CGPointMake(CGRectGetMidX([self.view bounds]), CGRectGetMidY([self.view bounds])-CGRectGetMidY([effectsScrollView bounds])-20)];//
    
    image = [GlobalData sharedGlobalData].currentPhoto; //[UIImage imageNamed:@"image.png"];
    imageView =  [[UIImageView alloc]initWithImage:image]; //[[imageScrollView subviews] objectAtIndex:0];//
    
    image = [[[tmpScrollView subviews] objectAtIndex:0] image];
    imageView = [[tmpScrollView subviews] objectAtIndex:0];
    
    imageScrollView.contentSize = imageView.frame.size;
    [imageScrollView addSubview:imageView];
    
    
    [self.view  addSubview:imageScrollView];
    
    
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
    return imageView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)zoomedScrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"it is zoooooooooming");
    /*
     photoScale1 = scale;
     visibleRect.origin = scrollview1.contentOffset;
     visibleRect.size = scrollview1.bounds.size;
     NSLog(@"%f ", scale);
     float theScale = 1.0 / scale;
     visibleRect.origin.x *= theScale;
     visibleRect.origin.y *= theScale;
     visibleRect.size.width *= theScale;
     visibleRect.size.height *= theScale;
     */
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

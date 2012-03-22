//
//  FrameViewController.m
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/14/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "FrameViewController.h"


@implementation FrameViewController
@synthesize imgPicker, tag, currentPhotoTag, photo1, photo2, photoScale1;

#pragma mark -
#pragma mark Custom Methods

- (void) captureMethod: (id) button {
	
    
	NSLog(@"button is pressed");
    UIButton *theButton = (UIButton *)button;
    NSLog(@"%d", theButton.tag);
    currentPhotoTag = theButton.tag;
    switch (theButton.tag) {
        case 1:
            NSLog(@"Photo 1");
            /*FrameViewController *aController = [[FrameViewController alloc] init];
            [self.navigationController pushViewController:aController animated:YES];
            [aController release];
            */
            break;
        case 2:
            NSLog(@"Photo 2");
            /*FrameViewController *bController = [[FrameViewController alloc] initWithTag: 2];
            [self.navigationController pushViewController:bController animated:YES];
            [bController release];
            */
            break;
        default:
            break;
    }
    [self presentModalViewController:imgPicker animated:YES];
}

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
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:originalImage];
    
    UIGraphicsBeginImageContext(CGSizeMake(imageView.image.size.width,imageView.image.size.height));  
	
	CGRect imageRect = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
	[imageView.image drawInRect:imageRect]; 
	[[UIImage imageNamed:@"sepia.png"] drawInRect:imageRect blendMode:kCGBlendModeScreen alpha:0.5];  
	
	UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();  
	UIGraphicsEndImageContext();
    
    return resultImage;
    
}

- (UIImage *) blueEffect: (UIImage *)originalImage {
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:originalImage];
    
    UIGraphicsBeginImageContext(CGSizeMake(imageView.image.size.width,imageView.image.size.height));  
	
	CGRect imageRect = CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height);
	[imageView.image drawInRect:imageRect]; 
	[[UIImage imageNamed:@"blue.png"] drawInRect:imageRect blendMode:kCGBlendModeScreen alpha:0.9];  
	
	UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();  
	UIGraphicsEndImageContext();
    
    return resultImage;
    
}

- (void) photoSelect: (id)sender {
    
    NSLog(@"%@", sender);
    
}

- (void) singleTapGestureCaptured : (id) sender {
    
    self.currentPhotoTag = [(UIGestureRecognizer *)sender view].tag;
    
    UIActionSheet *photoOptions = [[UIActionSheet alloc] initWithTitle:@"Photo"
                                                              delegate:self cancelButtonTitle:@"Cancel"
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"From Library",@"From Camera",@"Effects",nil,nil];
    photoOptions.tag = 2;
	
	// use the same style as the nav bar
	photoOptions.actionSheetStyle = self.navigationController.navigationBar.barStyle;
	[photoOptions showInView:self.view];
	[photoOptions release];
    
    
    /*NSLog(@"Gesture tag %d",self.currentPhotoTag);
    
    switch (self.currentPhotoTag) {
        case 1:
            NSLog(@"photo1");
            break;
        case 2:
            NSLog(@"photo2");
            break;
            
        default:
            break;
    }
    [self presentModalViewController:imgPicker animated:YES];
    */
    
}
- (UIImage *)resizeFrameImage:(UIImage *)img  {
    
    /*UIGraphicsBeginImageContext(CGSizeMake(300,300));
    [img drawInRect:CGRectMake(0, 0, 300, 300)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    
    
    return newImage;
     */
    return img;
}
- (UIImage *)scaleImage:(UIImage *)img scale: (float)scale {
    
    UIGraphicsBeginImageContext(CGSizeMake(img.size.width*scale,img.size.height*scale));
     [img drawInRect:CGRectMake(0, 0, img.size.width*scale,img.size.height*scale)];
     UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
     UIGraphicsEndImageContext();
     
     return newImage;
    
}
- (void) share {
    NSLog(@"Share");
    
    CGSize pageSize1 = scrollview1.frame.size;
    UIGraphicsBeginImageContext(pageSize1);
    CGContextRef resizedContext1 = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext1, -scrollview1.contentOffset.x, -scrollview1.contentOffset.y);
    [scrollview1.layer renderInContext:resizedContext1];
    UIImage *p1 = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"GENERATED IMAGE W-H %3.0f, %3.0f", p1.size.width,p1.size.height);
    UIGraphicsEndImageContext();
    
    photo1View.frame = CGRectMake(0, 0, p1.size.width, p1.size.height);
    photo1View.image = p1;
    
    CGSize pageSize2 = scrollview2.bounds.size;
    UIGraphicsBeginImageContext(pageSize2);
    CGContextRef resizedContext2 = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(resizedContext2, -scrollview2.contentOffset.x, -scrollview2.contentOffset.y);
    [scrollview2.layer renderInContext:resizedContext2];
    UIImage *p2 = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"GENERATED IMAGE W-H %3.0f, %3.0f", p2.size.width,p2.size.height);
    UIGraphicsEndImageContext();
    
    photo2View.frame = CGRectMake(0, 0, p2.size.width, p2.size.height);
    photo2View.image = p2;


    UIImageView *finalBackground = [[UIImageView alloc]initWithImage:resultingView.image];
    finalBackground.frame = CGRectMake(0, 0, resultingView.frame.size.width, resultingView.frame.size.height);
    //[self.view addSubview:finalBackground];
    
    UIImageView *finalPhoto1 = [[UIImageView alloc]initWithImage:photo1View.image];
    finalPhoto1.frame = CGRectMake(scrollview1.frame.origin.x -10,scrollview1.frame.origin.y-60, scrollview1.frame.size.width, scrollview1.frame.size.height);
    //[self.view addSubview:finalPhoto1];
    
    UIImageView *finalPhoto2 = [[UIImageView alloc]initWithImage:photo2View.image];
    finalPhoto2.frame = CGRectMake(scrollview2.frame.origin.x -10,scrollview2.frame.origin.y-60, scrollview2.frame.size.width, scrollview2.frame.size.height);
    //[self.view addSubview:finalPhoto2];
    

    
    UIGraphicsBeginImageContext(finalBackground.frame.size);  
    
    CGRect rect = CGRectMake(0, 0, finalBackground.frame.size.width, finalBackground.frame.size.height);
    [finalBackground.image drawInRect:rect];
    
    CGRect rectPhoto1 = CGRectMake(finalPhoto1.frame.origin.x,finalPhoto1.frame.origin.y, finalPhoto1.frame.size.width,finalPhoto1.frame.size.height);
    [finalPhoto1.image drawInRect:rectPhoto1];  
    
    CGRect rectPhoto2 = CGRectMake(finalPhoto2.frame.origin.x,finalPhoto2.frame.origin.y, finalPhoto2.frame.size.width,finalPhoto2.frame.size.height );
    [finalPhoto2.image drawInRect:rectPhoto2];  
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();  
    UIGraphicsEndImageContext(); 
    
    resultingView.image = nil;
    photo1View.image = nil;
    photo2View.image = nil;
    
    resultingView.image = resultingImage;
    
    UIImageWriteToSavedPhotosAlbum(resultingImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    //SHKItem *item = [SHKItem image:resultingImage title:@"Our Love Contract"];
	//SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
	//[actionSheet showFromToolbar:self.navigationController.toolbar];
}
- (void) image:(UIImage*)image didFinishSavingWithError:(NSError *)error contextInfo:(NSDictionary*)info{
    
}


#pragma mark -
#pragma mark LifeCycle

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    NSLog(@"viewwillappear %d",currentPhotoTag);
    
    //[self.view addSubview:[GlobalData sharedGlobalData].currentScrollView];
    /*if (currentPhotoTag == 1) {
        NSLog(@"show scrollview 1");
        scrollview1 = [GlobalData sharedGlobalData].currentScrollView;
        scrollview1.frame = scrollviewRect1;
        scrollview1.tag = 1;
     
        
        [self.view addSubview:scrollview1];
        
        
    } else if (currentPhotoTag == 2){
        NSLog(@"show scrollview 2");
        scrollview2 = [GlobalData sharedGlobalData].currentScrollView;
        scrollview2.frame = scrollviewRect2;
        scrollview2.tag = 2;
        [self.view addSubview:scrollview2];
    }
    */
    
    if ([GlobalData sharedGlobalData].fromEffectsTag == 1) {
        switch (currentPhotoTag) {
            case 1: {
                NSLog(@"show scrollview 1");
                
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: ) ];
                scrollview1 = [GlobalData sharedGlobalData].currentScrollView;
                scrollview1.frame = scrollviewRect1;
                scrollview1.tag = 1;
                [scrollview1 addGestureRecognizer:singleTap]; 
                scrollview1.delegate = self;
                scrollview1.maximumZoomScale = [GlobalData sharedGlobalData].currentScrollView.maximumZoomScale;
                scrollview1.minimumZoomScale = [GlobalData sharedGlobalData].currentScrollView.minimumZoomScale;
                [self.view addSubview:scrollview1];
                [singleTap release];
                
                break;
            }  
            case 2:
                NSLog(@"show scrollview 2");
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: ) ];
                scrollview2 = [GlobalData sharedGlobalData].currentScrollView;
                scrollview2.frame = scrollviewRect1;
                scrollview2.tag = 1;
                [scrollview2 addGestureRecognizer:singleTap]; 
                scrollview2.delegate = self;
                scrollview2.maximumZoomScale = [GlobalData sharedGlobalData].currentScrollView.maximumZoomScale;
                scrollview2.minimumZoomScale = [GlobalData sharedGlobalData].currentScrollView.minimumZoomScale;
                [self.view addSubview:scrollview2];
                [singleTap release];
                
                break;
        }
        [GlobalData sharedGlobalData].fromEffectsTag = 0;
    }
    
    
}

- (id) initWithTag:(int)tagNumber {
    if (self == [super init]) {
        self.tag = tagNumber;
    }
    return(self);
}

-(id) init {
    return [self initWithTag:1];
}

- (void) loadView {
    [super loadView];
    
    self.title = @"Customize";
    NSLog(@"call from frame tag %d",self.tag);
    
    
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[shareButton addTarget:self  action:@selector(share) forControlEvents:UIControlEventTouchDown];
	[shareButton setTitle:@"Share" forState:UIControlStateNormal];
    shareButton.frame = CGRectMake(130.0, 370.0, 80.0,40.0);
    shareButton.tag = 3;
	[self.view addSubview:shareButton];
    
    photo1 = [[UIImage alloc]init];
    photo2 = [[UIImage alloc]init];
    
    photo1 = [UIImage imageNamed:@"1.jpg"];
    photo2 = [UIImage imageNamed:@"patrickstar.png"];
    
    
    NSString *path;
    switch (self.tag) {
        case 1:
            path = @"4.jpg";
            break;
        case 2:
            path = @"2.jpeg";
            break;
            
        default:
            break;
    }
    UIImage *imagetmp = [UIImage imageNamed:path];
    imagetmp = [self resizeFrameImage:imagetmp];
    resultingView = [[UIImageView alloc]initWithImage:imagetmp];
    resultingView.frame = CGRectMake(10, 60, 300, 300);
    [self.view addSubview:resultingView];
    
    
    
    switch (self.tag) {
        case 1: 
            scrollviewRect1 = CGRectMake(40, 120, 100, 180);
            scrollviewRect2 = CGRectMake(190, 120, 100, 180);
            break;
        case 2:
            scrollviewRect1 = CGRectMake(35, 165, 85, 160);
            scrollviewRect2 = CGRectMake(200, 100, 85, 160);
            break;
            
        default:
            break;
    }
    
    photo1View = [[UIImageView alloc]initWithImage:photo1];
    photo1View.frame = CGRectMake(0, 0, photo1.size.width, photo1.size.height);
    
    photo2View = [[UIImageView alloc]initWithImage:photo2];
    photo2View.frame = CGRectMake(0, 0, photo2.size.width, photo2.size.height);
    
    scrollview1 = [[UIScrollView alloc]initWithFrame: scrollviewRect1];
    //scrollview1.backgroundColor = [UIColor blueColor];
    scrollview1.scrollEnabled = YES;
    scrollview1.showsHorizontalScrollIndicator = YES;
    scrollview1.showsVerticalScrollIndicator = YES;
    scrollview1.delegate = self;
    scrollview1.maximumZoomScale = 50;
    scrollview1.minimumZoomScale = .5;
    scrollview1.tag = 1;
    
    [scrollview1 addSubview:photo1View];
    scrollview1.contentSize = photo1View.frame.size;
    
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: ) ];
    [scrollview1 addGestureRecognizer:singleTap1]; 
    
    
    [self.view addSubview:scrollview1];
    
    scrollview2 = [[UIScrollView alloc]initWithFrame: scrollviewRect2];
    //scrollview2.backgroundColor = [UIColor blueColor];
    scrollview2.scrollEnabled = YES;
    scrollview2.showsHorizontalScrollIndicator = YES;
    scrollview2.showsVerticalScrollIndicator = YES;
    scrollview2.delegate = self;
    scrollview2.maximumZoomScale = 50;
    scrollview2.minimumZoomScale = .5;
    scrollview2.tag = 2;
    
    [scrollview2 addSubview:photo2View];
    scrollview2.contentSize = photo2View.frame.size;
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured: )];
    [scrollview2 addGestureRecognizer:singleTap2]; 
    [self.view addSubview:scrollview2];
    
    imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.allowsEditing = YES;
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;	
    
    image = [[UIImageView alloc] initWithFrame:CGRectMake(60, 40, 200, 200)];
	[self.view addSubview:image];
    
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	
    NSLog(@"image picker %d",self.currentPhotoTag);
    switch (self.currentPhotoTag) {
        case 1: {
            photo1 = img;
            photo1View.image = img;
            
            //NSLog(@"%@",[[scrollview1 subviews] objectAtIndex:0]);
            
            /*scrollview1.transform = CGAffineTransformIdentity;
            scrollview1.contentOffset = CGPointZero;
            scrollview1.contentSize = scrollview1.frame.size;
            
            [photo1View removeFromSuperview];
            //imageView = [[TapDetectingImageView alloc] initWithImage:newImage];
            
            [scrollview1 addSubview: photo1View];
            */
            break;
        }
        case 2:
            photo2 = img;
            photo2View.image = img;
            break;
            
        default:
            break;
    }
    
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    NSLog(@"%d",modalView.tag);
    // Action Sheet for Effects was triggered
    switch (buttonIndex)
    {
        case 0:
        {
            NSLog(@"Get From Library");
            imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:imgPicker animated:YES];
            break;
        }
        case 1:
        {
            NSLog(@"Camera");
            imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentModalViewController:imgPicker animated:YES];
            break;
        }
        case 2:
        {
            NSLog(@"Effects");
            
            if (currentPhotoTag == 1) {
                [GlobalData sharedGlobalData].currentPhoto = photo1;
                [GlobalData sharedGlobalData].currentScrollView = scrollview1;
                [GlobalData sharedGlobalData].currentPhotoTag = 1;
                
            } else {
                [GlobalData sharedGlobalData].currentPhoto = photo2;
                [GlobalData sharedGlobalData].currentScrollView = scrollview2;
                [GlobalData sharedGlobalData].currentPhotoTag = 2;
            }
            
            
            PhotoEditViewController *aController = [[PhotoEditViewController alloc]init];
            [self.navigationController pushViewController:aController animated:YES];
            //aController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            //[self presentModalViewController:aController animated:YES];
            
            break;
        }
    }
}
#pragma mark -
#pragma mark UIScrollView Delegate
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)aScrollView {
    switch (aScrollView.tag) {
        case 1:
            return photo1View;//[[scrollview1 subviews] objectAtIndex:0];//
            break;
        case 2:
            return photo2View; //[[scrollview2 subviews] objectAtIndex:0];//
            break;
    } 
    return nil;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)zoomedScrollView withView:(UIView *)view atScale:(float)scale
{
	photoScale1 = scale;
    visibleRect.origin = scrollview1.contentOffset;
    visibleRect.size = scrollview1.bounds.size;
    NSLog(@"%f ", scale);
    float theScale = 1.0 / scale;
    visibleRect.origin.x *= theScale;
    visibleRect.origin.y *= theScale;
    visibleRect.size.width *= theScale;
    visibleRect.size.height *= theScale;
}

-(void)dealloc {
    [super dealloc];
}

@end

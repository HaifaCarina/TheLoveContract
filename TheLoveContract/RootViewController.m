//
//  RootViewController.m
//  TheLoveContract
//
//  Created by Haifa Carina Baluyos on 3/12/12.
//  Copyright 2012 NMG Resources, Inc. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController
@synthesize imgPicker;

#pragma mark -
#pragma mark Custom Methods
- (void) styleAction {
    
    UIActionSheet *styleAlert = [[UIActionSheet alloc] initWithTitle:@"Choose a UIBarStyle:"
                                                            delegate:self cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:	@"Black & White",
                                 @"Sepia",
                                 @"Blue",
                                 nil,
                                 nil];
	
	// use the same style as the nav bar
	styleAlert.actionSheetStyle = self.navigationController.navigationBar.barStyle;
	
	[styleAlert showInView:self.view];
	[styleAlert release];
}

- (void) captureMethod: (id) button {
	
	NSLog(@"button is pressed");
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

- (void) templateSelect: (id)sender {
    
    UIButton *theButton = (UIButton *)sender;
    NSLog(@"%d", theButton.tag);
    
    switch (theButton.tag) {
        case 1:
            NSLog(@"first tempalte");
            FrameViewController *aController = [[FrameViewController alloc] init];
            [self.navigationController pushViewController:aController animated:YES];
            [aController release];
            break;
        case 2:
            NSLog(@"first tempalte");
            FrameViewController *bController = [[FrameViewController alloc] initWithTag: 2];
            [self.navigationController pushViewController:bController animated:YES];
            [bController release];
            break;
        default:
            break;
    }
    
    
}

#pragma mark -
#pragma mark LifeCycle
- (void) loadView {
    [super loadView];
    
    self.title = @"Love Contract";
    
    UIBarButtonItem *styleButton = [[UIBarButtonItem alloc] 
                                    initWithTitle:@"Style"                                            
                                    style:UIBarButtonItemStyleBordered 
                                    target:self 
                                    action:@selector(styleAction)];
    //self.navigationItem.leftBarButtonItem = styleButton;
    [styleButton release];
    
    UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] 
                                    initWithTitle:@"Image"                                            
                                    style:UIBarButtonItemStyleBordered 
                                    target:self 
                                    action:@selector(captureMethod:)];
    //self.navigationItem.rightBarButtonItem = imageButton;
    [imageButton release];
    
    
    UIButton *template1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[template1 addTarget:self  action:@selector(templateSelect:) forControlEvents:UIControlEventTouchDown];
	//[template1 setTitle:@"Route" forState:UIControlStateNormal];
    [template1 setImage:[UIImage imageNamed:@"4.jpg"] forState:UIControlStateNormal];
	template1.frame = CGRectMake(20.0, 20.0, 120.0,120.0);
    template1.tag = 1;
	[self.view addSubview:template1];
    
    UIButton *template2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[template2 addTarget:self  action:@selector(templateSelect:) forControlEvents:UIControlEventTouchDown];
	//[template2 setTitle:@"Route" forState:UIControlStateNormal];
    [template2 setImage:[UIImage imageNamed:@"2.jpeg"] forState:UIControlStateNormal];
	template2.frame = CGRectMake(160.0, 20.0, 120.0,120.0);
    template2.tag =2;
	[self.view addSubview:template2];
    
    //self.view.backgroundColor = [[UIColor purpleColor] initWithPatternImage:[UIImage imageNamed:@"frame.jpg"]];
    
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
	image.image = img;	
    currentImage = img;
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // Change the navigation bar style, also make the status bar match with it
	switch (buttonIndex)
	{
		case 0:
		{
			image.image = [self blackAndWhiteEffect: currentImage];
			break;
		}
		case 1:
		{
			image.image = [self sepiaEffect: currentImage];
			break;
		}
		case 2:
		{
			image.image = [self blueEffect: currentImage];
			break;
		}
	}
}

-(void)dealloc {
    [super dealloc];
}

@end

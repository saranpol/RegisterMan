//
//  ImageUtil.m
//  Molome
//
//  Created by Apple on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"


@implementation ImageUtil



CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180.0;};
+(UIImage *)imageRotatedByDegrees:(UIImage*)img degrees:(CGFloat)degrees 
{   
	// calculate the size of the rotated view's containing box for our drawing space
	UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,img.size.width, img.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
	[rotatedViewBox release];
	
	
	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2.0, rotatedSize.height/2.0);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
	
	// Now, draw the rotated/scaled image into the context
	//CGContextScaleCTM(bitmap, 1.0, -1.0);
	//CGContextDrawImage(bitmap, CGRectMake(-img.size.width / 2.0, -img.size.height / 2.0, img.size.width, img.size.height), [img CGImage]);
	[img drawAtPoint:CGPointMake(-img.size.width / 2.0, -img.size.height / 2.0)];
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
	
}





+(UIImage *)resizeImage:(UIImage *)image scaledToSize:(CGSize)newSize scaleFactor:(CGFloat)scaleFactor ox:(float)ox oy:(float)oy{
	//http://stackoverflow.com/questions/603907/uiimage-resize-then-crop    
	
	CGSize imageSize = image.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = newSize.width;
	CGFloat targetHeight = newSize.height;
	//CGFloat scaleFactor = [MolomeAppDelegate core]->mViewEdit->mScrollView.zoomScale;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	CGFloat widthFactor;
	if(height > width)
		widthFactor = targetWidth / width;
	else
		widthFactor = targetHeight / height;
	//CGFloat heightFactor = targetHeight / height;
	//71 = x
	//320 = 600
	
	scaledWidth  = width * widthFactor * scaleFactor;
	scaledHeight = height * widthFactor * scaleFactor;
	
	/*
	 if(height > width){
	 thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5 -(MAGIC_MARGIN_TOP * 600.0/320.0);
	 thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
	 }else{
	 thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5 ;
	 thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5 -(MAGIC_MARGIN_TOP * 600.0/320.0);
	 }
	 */
	
	//float ox = [MolomeAppDelegate core]->mViewEdit->mScrollView.contentOffset.x * IMAGE_UPLOAD_W/320.0;
	//float oy = [MolomeAppDelegate core]->mViewEdit->mScrollView.contentOffset.y * IMAGE_UPLOAD_W/320.0;
	//printf("ox %f scale %f\n",ox,scaleFactor);
	//printf("oy %f scale %f\n",oy,scaleFactor);
	thumbnailPoint.y = -oy;
	thumbnailPoint.x = -ox;
	//printf("x y %f %f\n",thumbnailPoint.x,thumbnailPoint.y);
	
	UIGraphicsBeginImageContext(newSize);
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[image drawInRect:thumbnailRect];
	
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}





@end

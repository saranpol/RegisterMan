//
//  ImageUtil.h
//  Molome
//
//  Created by Apple on 8/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageUtil : NSObject {

}

+(UIImage *)imageRotatedByDegrees:(UIImage*)img degrees:(CGFloat)degrees;
+(UIImage *)resizeImage:(UIImage *)image scaledToSize:(CGSize)newSize scaleFactor:(CGFloat)scaleFactor ox:(float)ox oy:(float)oy;
@end

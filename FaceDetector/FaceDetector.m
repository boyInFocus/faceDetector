/*!
 * @file    FaceDetector.m
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 *
 */

#import "FaceDetector.h"


@implementation FaceDetector

- (BOOL)faceDidDetectOn:(NSImage *)img
{
    BOOL isDetected = YES;
    self.breageView = [[NSView alloc] init];
    CIImage *faceImage = [CIImage imageWithCGImage:[self nsImageToCGImageRef:img]];
    CIContext * context = [CIContext contextWithOptions:nil];
    NSDictionary * param = [NSDictionary dictionaryWithObject:CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector * faceDetector = [CIDetector detectorOfType:CIDetectorTypeFace context:context options:param];
    NSArray * detectResult = [faceDetector featuresInImage:faceImage];
    if(detectResult.count == 0)
    {
        isDetected = NO;
        return isDetected;
    }
    for (CIFeature *feature in detectResult)
    {
        //将image沿y轴对称
        CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, -1);
        //将image往上移动
        CGFloat imageH = faceImage.extent.size.height;
        transform = CGAffineTransformTranslate(transform, 0, -imageH);
        //在image上画出方框
        CGRect feaRect = feature.bounds;
        //调整后的坐标
        CGRect newFeaRect = CGRectApplyAffineTransform(feaRect, transform);
        //调整imageView的frame
        CGFloat imageViewW = 480;
        CGFloat imageViewH = 360;
        CGFloat imageW = faceImage.extent.size.width;
        //显示
        CGFloat scale = MIN(imageViewH / imageH, imageViewW / imageW);
        //缩放
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
        
        //修正
        newFeaRect = CGRectApplyAffineTransform(newFeaRect, scaleTransform);
        newFeaRect.origin.x += (imageViewW - imageW * scale ) / 2;
        newFeaRect.origin.y += (imageViewH - imageH * scale ) / 2;
        NSLog(@"xxx:%f",newFeaRect.origin.x);
        
        //绘画
        NSView *breageView = [[NSView alloc] initWithFrame:newFeaRect];
        breageView.layer.borderColor = [NSColor redColor].CGColor;
        breageView.layer.borderWidth = 2;
        [self.breageView addSubview:breageView];
    }
    
    return isDetected;
}

- (CGImageRef)nsImageToCGImageRef:(NSImage *)img;

{
    NSData * imageData = [img TIFFRepresentation];
    CGImageRef imageRef;

    CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)imageData,  NULL);
    imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    
    return imageRef;
    
}
@end

/*!
 * @file    FaceDetector.h
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 *
 */

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <AppKit/AppKit.h>

@interface FaceDetector : NSObject

- (BOOL)faceDidDetectOn:(NSImage *)img;

@property (assign) NSView *breageView;
@end

/*!
 * @file    PictureViewController.h
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 *
 */

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVCaptureOutput.h>
#import "MacCameraManager.h"
#import "FaceDetector.h"

@interface PictureViewController : NSViewController
{
    AVCaptureStillImageOutput *stillImageOutput;
    //MacCameraManager *cameraMgr;
    FaceDetector *faceDetect;
    BOOL isDetected;
    
}

@property(nonatomic, retain) IBOutlet NSView *vImagePreview;
@property(nonatomic, retain) IBOutlet NSImageView *vImage;
@property(nonatomic) NSInteger deviceIndex;
@property(retain) AVCaptureSession *session;
@property(retain) MacCameraManager *cameraMgr;
@end

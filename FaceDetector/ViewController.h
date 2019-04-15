/*!
 * @file    VieController.h
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 *
 */

#import <Cocoa/Cocoa.h>
#import "MacCameraManager.h"
#import "MacCamera.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>

@interface ViewController : NSViewController <NSComboBoxDelegate,NSComboBoxDataSource, AVCaptureVideoDataOutputSampleBufferDelegate, MacCameraManagerDelegate>
{
    MacCameraManager *cameraMng;
    MacCamera *camera;
    NSMutableArray *allList;
    NSMutableArray *allIdList;
    NSInteger selectedDeviceIndex;
    AVCaptureSession *session;
    AVCaptureVideoDataOutput *output;
    AVCaptureVideoPreviewLayer *previewLayer;
    int format;
}
@property (assign) IBOutlet NSView *vImagePreview;

@end


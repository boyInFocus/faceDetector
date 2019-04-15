/*!
 * @file    PictureViewController.m
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 *
 */

#import "PictureViewController.h"
#import "MacCameraManager.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AVFoundation/AVCaptureInput.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVCaptureVideoPreviewLayer.h>
#import <AVFoundation/AVCaptureSession.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <AVFoundation/AVVideoSettings.h>
#import <ImageIO/CGImageProperties.h>
#import <ImageIO/ImageIO.h>

@interface PictureViewController ()

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self getStillImageOnSession:(AVCaptureSession *)_session withCompletionHandler:^(AVCaptureStillImageOutput *imageOutput, NSError *error) {
        
        //get correct AVCaptureConnection
        AVCaptureConnection *videoConnection = nil;
        for (AVCaptureConnection *connection in imageOutput.connections)
        {
            for (AVCaptureInputPort *port in [connection inputPorts])
            {
                if ([[port mediaType] isEqual:AVMediaTypeVideo] )
                {
                    videoConnection = connection;
                    break;
                }
            }
            if (videoConnection)
            {
                break;
            }
        }
        faceDetect = [[FaceDetector alloc] init];
        
        [imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
         ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
         {
             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
             self.vImage.image = [[NSImage alloc] initWithData:imageData];
             isDetected = [faceDetect faceDidDetectOn:self.vImage.image];
             if(isDetected)
             NSLog(@"Pass");
             else
             NSLog(@"Fail");
             
             [self.vImage addSubview:faceDetect.breageView];
         }];
        
    }];
    
}

- (BOOL)getStillImageOnSession:(AVCaptureSession *)session withCompletionHandler:(void (^)(AVCaptureStillImageOutput *imageOutput, NSError *error))completionHandler
{
    NSError *error = nil;
    session.sessionPreset = AVCaptureSessionPresetMedium;
    
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [stillImageOutput setOutputSettings:outputSettings];
    
        if([session canAddOutput:stillImageOutput])
            [session addOutput:stillImageOutput];
        else
            return NO;
    
    
        [session startRunning];
    
        completionHandler(stillImageOutput, error);
        return YES;

    return NO;
}

@end

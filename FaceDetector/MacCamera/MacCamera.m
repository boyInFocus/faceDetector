/*!
 * @file    MacCamera.m
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 * Instance for controlling UVC camera
 */

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVCaptureOutput.h>
#import <ImageIO/ImageIO.h>
#import <AppKit/NSImage.h>
#import "MacCamera.h"
#import "UVCCameraControl.h"
#import "DLog.h"

@implementation MacCamera
{
    AVCaptureDevice *captureDevice;
}

- (id)initWithCaptureDevice:(AVCaptureDevice *)_captureDevice
{
    UInt32 vendorId;
    UInt32 productId;
    NSArray *idArray = [_captureDevice.modelID componentsSeparatedByString:@" "];
    NSString *str_vendorId = [idArray[2] componentsSeparatedByString:@"_"][1];
    NSString *str_productId = [idArray[3] componentsSeparatedByString:@"_"][1];
    if([str_vendorId hasPrefix:@"0x"])
    {
        NSScanner* scanner = [NSScanner scannerWithString:str_vendorId];
        [scanner scanHexInt:&vendorId];
    }
    else
    {
        vendorId = [str_vendorId intValue];
    }
    if([str_productId hasPrefix:@"0x"])
    {
        NSScanner* scanner = [NSScanner scannerWithString:str_productId];
        [scanner scanHexInt:&productId];
    }
    else
    {
        productId = [str_productId intValue];
    }

    if (self = [super initWithVendorID:(UInt32)vendorId productID:(UInt32)productId]) {
        captureDevice = [_captureDevice retain];
        _deviceName = [_captureDevice.localizedName copy];
        _deviceUniqueID = [_captureDevice.uniqueID copy];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [captureDevice release];
    [_deviceName release];
    [_deviceUniqueID release];
}


#pragma mark Set/Get the actual values for the camera
- (BOOL)getAutoExposure
{
    if (captureDevice.isConnected)
        return [super getAutoExposure];
    else
        return NO;
}

- (BOOL)setAutoExposure:(BOOL)enabled
{
    if (captureDevice.isConnected)
        return [super setAutoExposure:enabled];
    else
        return NO;
}

- (BOOL)setExposure:(float)value
{
    if (captureDevice.isConnected)
        return [super setExposure:value];
    else
        return NO;
}

- (float)getExposure
{
    if (captureDevice.isConnected)
        return [super getExposure];
    else
        return MC_INVALID;
}

- (BOOL)setGain:(float)value
{
    if (captureDevice.isConnected)
        return [super setGain:value];
    else
        return NO;
}

- (float)getGain
{
    if (captureDevice.isConnected)
        return [super getGain];
    else
        return MC_INVALID;
}

- (BOOL)setBrightness:(float)value
{
    if (captureDevice.isConnected)
        return [super setBrightness:value];
    else
        return NO;
}

- (float)getBrightness
{
    if (captureDevice.isConnected)
        return [super getBrightness];
    else
        return MC_INVALID;
}

- (BOOL)setContrast:(float)value
{
    if (captureDevice.isConnected)
        return [super setContrast:value];
    else
        return NO;
}

- (float)getContrast
{
    if (captureDevice.isConnected)
        return [super getContrast];
    else
        return MC_INVALID;
}

- (BOOL)setSaturation:(float)value
{
    if (captureDevice.isConnected)
        return [super setSaturation:value];
    else
        return NO;
}

- (float)getSaturation
{
    if (captureDevice.isConnected)
        return [super getSaturation];
    else
        return MC_INVALID;
}

- (BOOL)setSharpness:(float)value
{
    if (captureDevice.isConnected)
        return [super setSharpness:value];
    else
        return NO;
}

- (float)getSharpness
{
    if (captureDevice.isConnected)
        return [super getSharpness];
    else
        return MC_INVALID;
}

- (BOOL)setAutoWhiteBalance:(BOOL)enabled
{
    if (captureDevice.isConnected)
        return [super setAutoWhiteBalance:enabled];
    else
        return NO;
}

- (BOOL)getAutoWhiteBalance
{
    if (captureDevice.isConnected)
        return [super getAutoWhiteBalance];
    else
        return NO;
}

- (BOOL)setWhiteBalance:(float)value
{
    if (captureDevice.isConnected)
    {
        return [super setWhiteBalance:value];
    }
    else
    {
        return NO;
    }
}

- (float)getWhiteBalance
{
    if (captureDevice.isConnected)
    {
        return [super getWhiteBalance];
    }
    else
    {
        return MC_INVALID;
    }
        
}
/*
- (BOOL)setAutoFocus:(BOOL)enabled
{
    if (captureDevice.isConnected)
    {
        if ([captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus])
        {
            NSError *error;
            
            if([captureDevice lockForConfiguration:&error])
            {
                if(enabled)
                    [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
                else
                    [captureDevice setFocusMode:AVCaptureFocusModeLocked];
                
                [captureDevice unlockForConfiguration];
                return YES;
            }
            else
            {
                DLog(@"%@", error);
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

- (BOOL)getAutoFocus
{
    if (captureDevice.isConnected)
    {
        return captureDevice.focusMode;//
    }
    else
    {
        return NO;
    }
}
*/

- (BOOL)setAutoFocus:(BOOL)enabled {
    if (captureDevice.isConnected)
        return [super setAutoFocus:enabled];
    else
        return NO;
}

- (BOOL)getAutoFocus {
    if (captureDevice.isConnected)
        return [super getAutoFocus];
    else
        return NO;
}

- (BOOL)setAbsoluteFocus:(float)value {
    if (captureDevice.isConnected)
        return [super setAbsoluteFocus:value];
    else
        return NO;
}

- (float)getAbsoluteFocus {
    if (captureDevice.isConnected)
        return [super getAbsoluteFocus];
    else
        return MC_INVALID;
}


#pragma mark set the image preview on the UI

- (AVCaptureSession *)createCaptureSession
{
    //Capture Session
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //Input
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input)
    {
        DLog(@"ERROR: trying to open camera: %@", error);
    }
    if (![session canAddInput:input]) {
        return nil;
    }
    [session addInput:input];
    return [session autorelease];
}

@end

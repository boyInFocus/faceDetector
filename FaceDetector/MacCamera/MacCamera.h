/*!
 * @file    MacCamera.h
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 * Instance for controlling UVC camera
 */
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AppKit/NSView.h>
#import "UVCCameraControl.h"
#define MC_INVALID 0xffffffff

@interface MacCamera : UVCCameraControl
@property (nonatomic, readonly) NSString *deviceName;
@property (nonatomic, readonly) NSString *deviceUniqueID;

- (id)initWithCaptureDevice:(AVCaptureDevice *)_captureDevice;
- (AVCaptureSession *)createCaptureSession;

/*!
 @method getAutoExposure
 @abstract
 Get the AutoExposure value.
 @result
 YES if AutoExposure is set enabled, NO otherwise.
 */
- (BOOL)getAutoExposure;

/*!
 @method setAutoExposure:
 @abstract
 enable / disable the AutoExposure
 @param enabled
 YES to enable AutoExposure, No otherwise.
 @result
 YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setAutoExposure:(BOOL)enabled;

/*!
    @method setExposure:
    @abstract
    Set the Exposure value.
    @param value
    A float value between 0 and 1.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setExposure:(float)value;

/*!
    @method getExposure
    @abstract
    Get the Exposure value.
    @result
    returns a valid value between 0 and 1.
 */
- (float)getExposure;

/*!
    @method setGain:
    @abstract
    Set the Gain value.
    @param value
    A float value between 0 and 1.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setGain:(float)value;

/*!
    @method setBrightness:
    @abstract
    Set the brightness value.
    Brightness Value from -127 to 127. The default brightness value is 0.
    @param value
    A float value.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setBrightness:(float)value;

/*!
    @method getBrightness
    @abstract
    Get the brightness value.
    @result
    returns a valid value between -127 and 127.
 */
- (float)getBrightness;

/*!
    @method setContrast:
    @abstract
    Set the Contrast value.
    @param value
    A float value between 0 and 1.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setContrast:(float)value;

/*!
    @method getContrast
    @abstract
    Get the Contrast value.
    @result
    returns a valid value between 0 and 1.
 */
- (float)getContrast;

/*!
    @method setSaturation:
    @abstract
    Set the Saturation value.
    @param value
    A float value between 0 and 1.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setSaturation:(float)value;

/*!
    @method getSaturation
    @abstract
    Get the Saturation value.
    @result
    returns a valid value between 0 and 1.
 */
- (float)getSaturation;

/*!
    @method setSharpness:
    @abstract
    Set the Sharpness value.
    @param value
    A float value between 0 and 1.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setSharpness:(float)value;

/*!
    @method getSharpness
    @abstract
    Get the Sharpness value.
    @result
    returns a valid value between 0 and 1.
 */
- (float)getSharpness;

/*!
    @method setAutoWhiteBalance:
    @abstract
    enable / disable the AutoWhiteBalance
    @param enabled
    YES to enable AutoWhiteBalance, No otherwise.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setAutoWhiteBalance:(BOOL)enabled;

/*!
    @method getAutoWhiteBalance
    @abstract
    Get the AutoWhiteBalance value.
    @result
    YES if AutoWhiteBalance is set enabled, NO otherwise.
 */
- (BOOL)getAutoWhiteBalance;

/*!
    @method setWhiteBalance:
    @abstract
    Set the WhiteBalance value
    @param value
    A float value between 0 and 1.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setWhiteBalance:(float)value;

/*!
    @method getWhiteBalance
    @abstract
    Get the WhiteBalance value.
    @result
    returns a valid value between 0 and 1.
 */
- (float)getWhiteBalance;

/*!
    @method setAutoFocus:
    @abstract
    enable / disable the AutoFocus
    @param enabled
    YES to enable AutoFocus, No otherwise.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setAutoFocus:(BOOL)enabled;

/*!
 @method getAutoFocus
 @abstract
 Get the AutoFocus value.
 @result
 YES if AutoFocus is set enabled, NO otherwise.
 */
- (BOOL)getAutoFocus;

/*!
    @method setAbsoluteFocus:
    @abstract
    Set the AbsoluteFocus value
    @param value
    A float value between 0 and 1.
    @result
    YES if the value can be set successfully, NO otherwise.
 */
- (BOOL)setAbsoluteFocus:(float)value;

/*!
    @method getAbsoluteFocus
    @abstract
    Get the AbsoluteFocus value.
    @result
    returns a valid value between 0 and 1.
 */
- (float)getAbsoluteFocus;


@end

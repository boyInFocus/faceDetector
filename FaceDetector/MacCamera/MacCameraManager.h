/*!
 * @file    MacCameraManager.h
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 * Instance for manage MacCamera instances
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MacCamera.h"

@protocol MacCameraManagerDelegate <NSObject>
@optional
- (void)cameraDidRemoved:(MacCamera *)macCamera;
- (void)cameraDidConnected:(MacCamera *)macCamera;
@end
//class MacUVCCam;

@interface MacCameraManager : NSObject


/*!
 @property macCameraList
 @abstract
    macCameraList : A set of MacCamera instances
 */
@property (nonatomic, retain) NSArray *macCameraList;

@property (nonatomic, retain) id<MacCameraManagerDelegate> delegate;

+ (id)sharedInstance;
@end

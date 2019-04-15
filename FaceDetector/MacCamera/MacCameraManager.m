/*!
 * @file    MacCameraManager.m
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 * Instance for manage MacCamera instances
 */

#import "MacCameraManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVCaptureDevice.h>
#import "MacCamera.h"
#import "DLog.h"
@interface MacCameraManager ()

@end

static MacCameraManager *_sharedInstance;

@implementation MacCameraManager
@synthesize macCameraList = _macCameraList;

- (id)init
{
    return nil;
}

- (id)privateInit
{
    if(self = [super init])
    {
        NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        NSMutableArray *cameraList = [[NSMutableArray alloc] init];
        for (AVCaptureDevice *device in devices)
        {
            [cameraList addObject:[self createCameraWithCaptureDevice:device]];
        }
        _macCameraList = [cameraList retain];
        [cameraList release];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateCameraStatus:)
                                                     name:AVCaptureDeviceWasConnectedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateCameraStatus:)
                                                     name:AVCaptureDeviceWasDisconnectedNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
    [_macCameraList release];
}

- (void)updateCameraStatus:(NSNotification *)notification
{
    DLog(@"One device is connected or disconnected");
    AVCaptureDevice *device = (AVCaptureDevice *) notification.object;
    
    if([notification.name isEqualToString:AVCaptureDeviceWasDisconnectedNotification])
    {
        for(int i=0; i<[_macCameraList count]; i++)
        {
            if([device.uniqueID isEqualToString:[_macCameraList[i] deviceUniqueID]])
            {
                MacCamera *removedCamera = [_macCameraList[i] retain];
                [(NSMutableArray *)_macCameraList removeObjectAtIndex:i];
                if([self.delegate respondsToSelector:@selector(cameraDidRemoved:)])
                {
                    [self.delegate cameraDidRemoved:[removedCamera autorelease]];
                }
            }
        }
    }
    else if([notification.name isEqualToString:AVCaptureDeviceWasConnectedNotification])
    {
        MacCamera *newCamera = [self createCameraWithCaptureDevice:device];
        if(newCamera)
        {
            [(NSMutableArray *)_macCameraList addObject:newCamera];
            if([self.delegate respondsToSelector:@selector(cameraDidConnected:)])
            {
                [self.delegate cameraDidConnected:newCamera];
            }
        }
    }
}

- (MacCamera *)createCameraWithCaptureDevice:(AVCaptureDevice *)device
{
    if(![device hasMediaType:AVMediaTypeVideo])
    {
        return nil;
    }
    MacCamera *camera = [[MacCamera alloc] initWithCaptureDevice:device];
    return [camera autorelease];
}

+ (id)sharedInstance
{
    if (_sharedInstance == nil) {
        _sharedInstance = [[MacCameraManager alloc] privateInit];
    }
    return _sharedInstance;
}

@end

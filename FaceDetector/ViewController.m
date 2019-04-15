/*!
 * @file    VieController.m
 * @author  Justin Huang <justin.huang@alumni.ncu.edu.tw>
 * @version 1.0
 * @Created by Justin on 2017/1/11.
 * @section DESCRIPTION
 *
 */

#import "ViewController.h"
#import "PictureViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    selectedDeviceIndex = 0;
    cameraMng = [MacCameraManager sharedInstance];
    cameraMng.delegate = self;
    allList = [[NSMutableArray alloc]init];
    allIdList = [[NSMutableArray alloc]init];
    for(int i=0;i<cameraMng.macCameraList.count;i++)
    {
        [allList addObject:[cameraMng.macCameraList[i] deviceName]];
        [allIdList addObject:[cameraMng.macCameraList[i] deviceUniqueID]];
    }
    
    [self previewFromCameraIndex:selectedDeviceIndex];
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    [self performSelector:@selector(showSnapShot) withObject:nil afterDelay:2];
}

- (void)showSnapShot
{
    [self performSegueWithIdentifier:@"showSnapShot" sender:nil];
}

- (void)previewFromCameraIndex:(NSInteger)index
{
    camera = cameraMng.macCameraList[index];
    output = [[AVCaptureVideoDataOutput alloc] init];
    session = [camera createCaptureSession];
    [session addOutput:output];
    output.videoSettings =
    @{ (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
    previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [output setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [session startRunning];
    previewLayer.frame = self.vImagePreview.bounds;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CALayer *layer = [[CALayer alloc]init];
    [layer addSublayer:previewLayer];
    [self.vImagePreview setLayer:layer];
    [self.vImagePreview setWantsLayer:YES];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer
      fromConnection:(AVCaptureConnection *)connection
{
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef) CMSampleBufferGetImageBuffer(sampleBuffer);
    NSString *type = NSFileTypeForHFSTypeCode(CVPixelBufferGetPixelFormatType ( pixelBuffer ));
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender
{
    selectedDeviceIndex = 0;
    PictureViewController *viewController = segue.destinationController;
    viewController.deviceIndex = selectedDeviceIndex;
    viewController.cameraMgr = cameraMng;
    viewController.session = session;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end

//
//  CameraCustomViewController.m
//  XiaoLiuFisheries
//
//  Created by Livespro on 2016/10/24.
//  Copyright © 2016年 福中集团软件公司. All rights reserved.
//

#import "CameraCustomViewController.h"
#import "LLSimpleCamera.h"
#import "FingerWaveView.h"

@interface CameraCustomViewController ()
@property (strong, nonatomic) LLSimpleCamera *camera;
@property (strong, nonatomic) UILabel *errorLabel;
@property (strong, nonatomic) UIButton *snapButton;
@property (strong, nonatomic) UIButton *switchButton;
@property (strong, nonatomic) UIButton *flashButton;
@property (strong, nonatomic) UIButton *dismissButton;

@property (strong, nonatomic) UIImageView *cameraImageView;
@property (strong, nonatomic) UIButton *usedImageButton;
@property (strong, nonatomic) UIButton *reCameraTake;

@property (strong, nonatomic) UIImage *imageSto;
@property (strong, nonatomic) NSDictionary *dataSto;

@end

@implementation CameraCustomViewController

-(instancetype)initCameraData:(CameraPass)cameraPass;{
    if ([super init]) {
        
        _cameraPass=cameraPass;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    // ----- initialize camera -------- //
    
    // create camera vc
    self.camera = [[LLSimpleCamera alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                 position:LLCameraPositionRear
                                             videoEnabled:YES];
    
    self.camera.view.frame = self.view.bounds;
    
    // attach to a view controller
    [self.camera attachToViewController:self withFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    
    // read: http://stackoverflow.com/questions/5427656/ios-uiimagepickercontroller-result-image-orientation-after-upload
    // you probably will want to set this to YES, if you are going view the image outside iOS.
    self.camera.fixOrientationAfterCapture = NO;
    
    // take the required actions on a device change
    __weak typeof(self) weakSelf = self;
    [self.camera setOnDeviceChange:^(LLSimpleCamera *camera, AVCaptureDevice * device) {
        
        NSLog(@"Device changed.");
        
        // device changed, check if flash is available
        if([camera isFlashAvailable]) {
            weakSelf.flashButton.hidden = NO;
            
            if(camera.flash == LLCameraFlashOff) {
                weakSelf.flashButton.selected = NO;
            }
            else {
                weakSelf.flashButton.selected = YES;
            }
        }
//        else {
//            weakSelf.flashButton.hidden = YES;
//        }
    }];
    
    [self.camera setOnError:^(LLSimpleCamera *camera, NSError *error) {
        NSLog(@"Camera error: %@", error);
        
        if([error.domain isEqualToString:LLSimpleCameraErrorDomain]) {
            if(error.code == LLSimpleCameraErrorCodeCameraPermission ||
               error.code == LLSimpleCameraErrorCodeMicrophonePermission) {
                
                if(weakSelf.errorLabel) {
                    [weakSelf.errorLabel removeFromSuperview];
                }
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
                label.text = @"We need permission for the camera.\nPlease go to your settings.";
                label.numberOfLines = 2;
                label.lineBreakMode = NSLineBreakByWordWrapping;
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:13.0f];
                label.textColor = [UIColor whiteColor];
                label.textAlignment = NSTextAlignmentCenter;
                [label sizeToFit];
                label.center = CGPointMake(screenRect.size.width / 2.0f, screenRect.size.height / 2.0f);
                weakSelf.errorLabel = label;
                [weakSelf.view addSubview:weakSelf.errorLabel];
            }
        }
    }];
    
    // ----- camera buttons -------- //
    
    // snap button to capture image
    self.snapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.snapButton.frame = CGRectMake((screenRect.size.width - 70.0f)/2, screenRect.size.height -70.0f -15.0f, 70.0f, 70.0f);
    self.snapButton.clipsToBounds = YES;
    self.snapButton.layer.cornerRadius = 35.0f;
    self.snapButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.snapButton.layer.borderWidth = 2.0f;
    self.snapButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.snapButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.snapButton.layer.shouldRasterize = YES;
    [self.snapButton addTarget:self action:@selector(snapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.snapButton];
    
    // button to toggle flash
    self.flashButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.flashButton.frame = CGRectMake(5.0f, 5.0f, 68.0f, 68.0f);
    self.flashButton.tintColor = [UIColor whiteColor];
    [self.flashButton setImage:[UIImage imageNamed:@"flash-(auto)"] forState:UIControlStateNormal];
    self.flashButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    [self.flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flashButton];
    
    if([LLSimpleCamera isFrontCameraAvailable] && [LLSimpleCamera isRearCameraAvailable]) {
        // button to toggle camera positions
        self.switchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.switchButton.frame = CGRectMake(screenRect.size.width- 68.0f- 5.0f, screenRect.size.height- 68.0f- 15.0f, 68.0f, 68.0f);
        self.switchButton.tintColor = [UIColor whiteColor];
        [self.switchButton setImage:[UIImage imageNamed:@"switch-camera"] forState:UIControlStateNormal];
        self.switchButton.imageEdgeInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        [self.switchButton addTarget:self action:@selector(switchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.switchButton];
        
    }
    
    //button dismiss self
    self.dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.dismissButton.frame = CGRectMake(5.0f, screenRect.size.height- 68.0f- 10.0f, 68.0f, 68.0f);
    self.dismissButton.tintColor = [UIColor whiteColor];
    self.dismissButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0f];
    [self.dismissButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.dismissButton addTarget:self action:@selector(dismissButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dismissButton];
    
}

- (void)snapButtonPressed:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;
    
        // capture
        [self.camera capture:^(LLSimpleCamera *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
            if(!error) {
                
                weakSelf.imageSto=image;
                weakSelf.dataSto=metadata;
                
                weakSelf.cameraImageView.image=image;
                [weakSelf.view addSubview:weakSelf.cameraImageView];
                
            }
            else {
                NSLog(@"An error has occured: %@", error);
            }
        } exactSeenImage:YES];
        
}

- (void)dismissButtonPressed{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // start the camera
    [self.camera start];
}

/* camera button methods */

- (void)switchButtonPressed:(UIButton *)button
{
    [self.camera togglePosition];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)flashButtonPressed:(UIButton *)button
{
    if(self.camera.flash == LLCameraFlashOff) {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOn];
        if(done) {
            self.flashButton.selected = YES;
            self.flashButton.tintColor = [UIColor yellowColor];
        }
    }
    else {
        BOOL done = [self.camera updateFlashMode:LLCameraFlashOff];
        if(done) {
            self.flashButton.selected = NO;
            self.flashButton.tintColor = [UIColor whiteColor];
        }
    }
}

/* other lifecycle methods */

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    
//    self.camera.view.frame = self.view.bounds;
//    
//    self.snapButton.center = self.view.center;
//    self.snapButton.bottom = self.view.height - 15.0f;
//    
//    self.flashButton.top = 5.0f;
//    self.flashButton.left = 5.0f;
//    
//    self.dismissButton.left= 5.0f;
//    self.dismissButton.bottom = self.view.height - 15.0f;
//    
//    self.switchButton.right = self.view.width - 5.0f;
//    self.switchButton.bottom = self.view.height - 15.0f;
//
//}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(UIImageView *)cameraImageView{
    if (!_cameraImageView) {
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        _cameraImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
        _cameraImageView.contentMode = UIViewContentModeScaleAspectFit;
        _cameraImageView.backgroundColor = [UIColor blackColor];
        _cameraImageView.userInteractionEnabled=YES;
        
        //usedImage --- 使用照片
        _usedImageButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _usedImageButton.frame = CGRectMake(screenRect.size.width -68.0f -15.0f, screenRect.size.height -68.0f -10.0f, 68.0f, 68.0f);
        _usedImageButton.tintColor = [UIColor whiteColor];
        _usedImageButton.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0f];
        [_usedImageButton setTitle:@"使用照片" forState:UIControlStateNormal];
        [_usedImageButton addTarget:self action:@selector(usedImageButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_cameraImageView addSubview:_usedImageButton];
        
        //reTake --- 重拍
        _reCameraTake = [UIButton buttonWithType:UIButtonTypeSystem];
        _reCameraTake.frame = CGRectMake(5.0f, screenRect.size.height -68.0f -10.0f, 68.0f, 68.0f);
        _reCameraTake.tintColor = [UIColor whiteColor];
        _reCameraTake.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0f];
        [_reCameraTake setTitle:@"重拍" forState:UIControlStateNormal];
        [_reCameraTake addTarget:self action:@selector(reCmaeraTakeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_cameraImageView addSubview:_reCameraTake];
        
        //给图片加的点击动画效果手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [_cameraImageView addGestureRecognizer:tap];
        
    }
    return _cameraImageView;
}
//手势Action
- (void)onTap:(UITapGestureRecognizer*)sender {
    CGPoint center = [sender locationInView:sender.view];
    [FingerWaveView  showInView:_cameraImageView center:center];
}

-(void)usedImageButtonPressed{
    
    if (self.cameraPass) {
        self.cameraPass(_imageSto,_dataSto);
    }
    [_cameraImageView removeFromSuperview];
    [self dismissButtonPressed];
}

-(void)reCmaeraTakeButtonPressed{
  
    [_cameraImageView removeFromSuperview];
}

@end

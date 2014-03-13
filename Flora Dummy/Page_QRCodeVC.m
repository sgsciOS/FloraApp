//
//  Page_QRCodeVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 3/12/14.
//  Copyright (c) 2014 SGSC. All rights reserved.
//

#import "Page_QRCodeVC.h"
#import "Page_QR_DetailVC.h"

@interface Page_QRCodeVC ()

@end

@implementation Page_QRCodeVC
@synthesize reader, navCont, qrNav;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Create camera view for QR Code reading
    reader = [ZBarReaderViewController new];
    float H = self.view.frame.size.height-200;
    float W = H;
    reader.view.frame = CGRectMake((self.view.frame.size.width-W) / 2,
                                   (self.view.frame.size.height-H) / 2,
                                   W,
                                   H);
    NSLog(@"X: %f\tY: %f\tW: %f\tH: %f\n", reader.view.frame.origin.x, reader.view.frame.origin.y,
          reader.view.frame.size.width, reader.view.frame.size.height);
    
    reader.readerDelegate = self;
    
    [reader.scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
    [reader.scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:1];
    
    reader.readerView.zoom = 1.0;
    reader.showsCameraControls = NO;
    reader.showsZBarControls = NO;
    reader.wantsFullScreenLayout = NO;
    reader.title = @"QR Code Reader";
    
    
    //[self.view addSubview:reader.view];
    
    
    qrNav = [[UINavigationController alloc]initWithRootViewController:reader];
    qrNav.view.frame = reader.view.frame;
    //[navCont pushViewController:reader animated:YES];
    
    
    
    [self.view addSubview:qrNav.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateColors
{
    [super updateColors];
    
}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // vibrate to indicate detection
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
    ZBarSymbolSet *symbolSet = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    NSString *qrCode = nil;
    
    // get last QRCode in case where multiple are detected
    for (symbol in symbolSet)
    {
        qrCode = [NSString stringWithString:symbol.data];
    }
    
    NSLog(@"QR-Code: %@", qrCode);
    
    Page_QR_DetailVC *vc = [[Page_QR_DetailVC alloc]init];
    vc.textStr = qrCode;
    //vc.qrImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    [self.qrNav.view removeFromSuperview];
    self.qrNav = nil;
    [self.navCont pushViewController:vc animated:YES];
    
}


@end

//
//  Page_QRCodeVC.h
//  Flora Dummy
//
//  Created by Zach Nichols on 3/12/14.
//  Copyright (c) 2014 SGSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#import "ZBarSDK.h"

#import "FormattedVC.h"
#import "UIButton_Typical.h"

@interface Page_QRCodeVC : FormattedVC<ZBarReaderDelegate>
{
    
}

@property (nonatomic, retain) ZBarReaderViewController *reader;
@property (strong, nonatomic) UINavigationController *navCont;
@property (strong, nonatomic) UINavigationController *qrNav;

@end

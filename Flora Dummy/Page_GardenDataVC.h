//
//  Page_GardenDataVC.h
//  Flora Dummy
//
//  Created by Zach Nichols on 12/20/13.
//  Copyright (c) 2013 SGSC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PageVC.h"

@interface Page_GardenDataVC : PageVC<UIPopoverControllerDelegate>
{
    UIImage *gardenImage;
}

@property(nonatomic, retain) IBOutlet UIButton *endButton;

@property (nonatomic, strong) UIImageView *gardenImageView;

@property (nonatomic, strong) UIImage *gardenImage;

@property(nonatomic, retain) UIPopoverController *currentPopover;

@end
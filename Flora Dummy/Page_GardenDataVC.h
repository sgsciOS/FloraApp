//
//  Page_GardenDataVC.h
//  Flora Dummy
//
//  Created by Zach Nichols on 12/20/13.
//  Copyright (c) 2013 SGSC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FormattedVC.h"

@interface Page_GardenDataVC : FormattedVC<UIPopoverControllerDelegate, UIScrollViewDelegate>
{
    UIImage *gardenImage;
}

@property(nonatomic, retain) IBOutlet UIButton *endButton;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *gardenImageView;

@property(nonatomic, retain) NSArray *touchZones;

@property (nonatomic, strong) UIImage *gardenImage;

@property(nonatomic, retain) UIPopoverController *currentPopover;

@end
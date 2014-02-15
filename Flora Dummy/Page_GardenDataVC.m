//
//  Page_GardenDataVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 12/20/13.
//  Copyright (c) 2013 SGSC. All rights reserved.
//

#import "Page_GardenDataVC.h"

#import <QuartzCore/QuartzCore.h>

@interface Page_GardenDataVC ()
{        
    CGVector velocity;
    
    // These constants define the margins for the large garden view
    float MARGIN_GV_TOP;
    float MARGIN_GV_SIDE;
    float MARGIN_GV_BOTTOM;
    float GV_X;
    float GV_Y;
    float GV_WIDTH;
    float GV_HEIGHT;
}

@end

@implementation Page_GardenDataVC
@synthesize endButton, gardenImage, gardenImageView;
@synthesize currentPopover;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Double check to make sure orientation is correct.
    // iOS 7 introduced a bug where sometimes the VC
    // doesn't know which orientation it's supposed to be.
    // Thus, in landscape, it creates a landscape VC but
    // any reference to its frame will result in portrait
    // values.
    CGRect r = self.view.bounds;
    
    if (r.size.height > r.size.width)
    {
        float w = r.size.width;
        r.size.width = r.size.height;
        r.size.height = w;
    }
    
    self.view.bounds = r;
    
    // Define constants for spacing/sizing
    
    // These constants define the margins for the problem box,
    // the area where entire problem is viewed.
    MARGIN_GV_TOP = 20;
    MARGIN_GV_SIDE = 37;
    MARGIN_GV_BOTTOM = 20;
    GV_X = MARGIN_GV_SIDE;
    GV_Y = self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height + MARGIN_GV_TOP;
    GV_WIDTH = self.view.bounds.size.width - (2 * MARGIN_GV_SIDE);
    GV_HEIGHT = self.previousButton.frame.origin.y - GV_Y - MARGIN_GV_TOP - MARGIN_GV_BOTTOM;

    
    gardenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(GV_X,
                                                                    GV_Y,
                                                                    GV_WIDTH,
                                                                    GV_HEIGHT)];
    gardenImage = [UIImage imageNamed:@"Garden_Top.jpg"];
    gardenImageView.image = gardenImage;
    
    [self.view addSubview:gardenImageView];
    
    font = [[UIFont alloc]init];
    font = [UIFont fontWithName:@"Marker Felt" size:32.0];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)updateColors
{
    [super updateColors];

}

// Call this function within a "touch" method.
// This function will either close an already opened popover,
// or create a new one. These popovers will display information
// about the portion of the garden just pressed.
-(void)presentInformationPopoverAtRect: (CGRect)rect
{
    if ([self.currentPopover isPopoverVisible])
    {
        [self.currentPopover dismissPopoverAnimated:YES];
        
    }else
    {
        // Note: use specfic view controller later
        UIViewController *c = [UIViewController new];
        //c.delegate = self;
        
        self.currentPopover = [[UIPopoverController alloc] initWithContentViewController:c];
        [self.currentPopover presentPopoverFromRect:rect
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                           animated:YES];
    }
}


@end

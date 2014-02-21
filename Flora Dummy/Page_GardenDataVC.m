//
//  Page_GardenDataVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 12/20/13.
//  Copyright (c) 2013 SGSC. All rights reserved.
//

#import "Page_GardenDataVC.h"

#import <QuartzCore/QuartzCore.h>
#import "GardenDetailVC.h"

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
@synthesize endButton, gardenImage, scrollView, gardenImageView;
@synthesize currentPopover, touchZones;

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
    GV_Y = MARGIN_GV_TOP;
    GV_WIDTH = self.view.bounds.size.width - (2 * MARGIN_GV_SIDE);
    GV_HEIGHT = self.view.bounds.size.height - GV_Y - MARGIN_GV_TOP - MARGIN_GV_BOTTOM;
    
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(GV_X,
                                                                GV_Y,
                                                                GV_WIDTH,
                                                                GV_HEIGHT)];
    [scrollView setScrollEnabled:YES];
    [scrollView setBounces:YES];
    [self.view addSubview:scrollView];

    //[scrollView setContentSize: CGSizeMake(scrollView.frame.size.width + 1,
    //                                       scrollView.frame.size.height + 1)];
    
    self.scrollView.minimumZoomScale=1.0;
    self.scrollView.maximumZoomScale=3.0;
    //self.scrollView.contentSize=CGSizeMake(1280, 960);
    self.scrollView.delegate=self;
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [scrollView addGestureRecognizer:singleTapGestureRecognizer];
    
    gardenImage = [UIImage imageNamed:@"Garden_Top.jpg"];

    gardenImageView = [[UIImageView alloc] initWithFrame:CGRectMake((GV_WIDTH - gardenImage.size.width)/ 2.0,
                                                                    (GV_HEIGHT - gardenImage.size.height)/ 2.0,
                                                                    gardenImage.size.width,
                                                                    gardenImage.size.height)];
     gardenImageView.image = gardenImage;
    
    [scrollView addSubview:gardenImageView];
    
    
    
    
    // Touch zones
    // Places that will trigger UIPopover
    
    NSMutableDictionary *firstTouchDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    NSNumber *x = [NSNumber numberWithFloat:0.0];
    NSNumber *y = [NSNumber numberWithFloat:0.0];
    NSNumber *w = [NSNumber numberWithFloat:100.0];
    NSNumber *h = [NSNumber numberWithFloat:100.0];
    NSArray *bounds = [NSArray arrayWithObjects:x, y, w, h, nil];
    [firstTouchDict setObject:bounds forKey:@"Zone"];
    NSString *nameString = @"First Touch";
    [firstTouchDict setObject:nameString forKey:@"Name"];
    NSString *descriptionStr = @"This is the corner.";
    [firstTouchDict setObject:descriptionStr forKey:@"Description"];
    NSString *vcType = @"Normal";
    [firstTouchDict setObject:vcType forKey:@"VCType"];
    
    touchZones = [[NSArray alloc] initWithObjects:firstTouchDict, nil];
    
    
    
    
    
    
    font = [[UIFont alloc]init];
    font = [UIFont fontWithName:@"Marker Felt" size:32.0];

}

- (void)singleTap:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint = [gesture locationInView: gardenImageView];
    
    NSLog(@"Tap at (%.0f, %.0f)", touchPoint.x, touchPoint.y);
    
    for (NSDictionary *d in touchZones)
    {
        NSArray *bounds = (NSArray *)[d objectForKey:@"Zone"];
        float x = [(NSNumber *)[bounds objectAtIndex:0] floatValue];
        float y = [(NSNumber *)[bounds objectAtIndex:1] floatValue];
        float w = [(NSNumber *)[bounds objectAtIndex:2] floatValue];
        float h = [(NSNumber *)[bounds objectAtIndex:3] floatValue];
        
        if (((touchPoint.x >= x) && (touchPoint.x <= (x + w))) &&
            ((touchPoint.y >= y) && (touchPoint.y <= (y + h))))
        {
            NSLog(@"Touch Zone: %@", (NSString *)[d objectForKey:@"Name"]);

            [self presentInformationPopoverAtRect:CGRectMake(x, y, w, h) forInfoDict:d];
            
            return;
        }

    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return gardenImageView;
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
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
-(void)presentInformationPopoverAtRect: (CGRect)rect forInfoDict: (NSDictionary *)dict
{
    if ([self.currentPopover isPopoverVisible])
    {
        [self.currentPopover dismissPopoverAnimated:YES];
        
    }else
    {
        // Note: use specfic view controller later
        GardenDetailVC *gDVC = [[GardenDetailVC alloc] initWithNibName:@"GardenDetailVC" bundle:nil];
        gDVC.parent = self;
        gDVC.name = (NSString *)[dict objectForKey:@"Name"];
        gDVC.description = (NSString *)[dict objectForKey:@"Description"];

        
        self.currentPopover = [[UIPopoverController alloc] initWithContentViewController:gDVC];
        self.currentPopover.popoverContentSize = CGSizeMake(gDVC.view.frame.size.width, gDVC.view.frame.size.height);
        [self.currentPopover presentPopoverFromRect:rect
                                             inView:self.view
                           permittedArrowDirections:UIPopoverArrowDirectionAny
                                           animated:YES];
    }
}


@end

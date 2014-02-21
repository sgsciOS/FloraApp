//
//  GardenDetailVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 2/20/14.
//  Copyright (c) 2014 SGSC. All rights reserved.
//

#import "GardenDetailVC.h"

@interface GardenDetailVC ()

@end

@implementation GardenDetailVC
@synthesize name, description;
@synthesize nameLabel, descriptionTextView;
@synthesize font;
@synthesize parent;

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
    // Do any additional setup after loading the view from its nib.
    
    font = [[UIFont alloc]init];
    font = [UIFont fontWithName:@"Marker Felt" size:32.0];
    UIFont *subFont = [UIFont fontWithName:@"Marker Felt" size:24.0];

    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 410, 44)];
    nameLabel.font = font;
    nameLabel.text = name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:nameLabel];
    
    
    descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 72, 410, 258)];
    descriptionTextView.text = description;
    descriptionTextView.editable = NO;
    descriptionTextView.scrollEnabled = YES;
    descriptionTextView.font = subFont;
    
    [self.view addSubview:descriptionTextView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

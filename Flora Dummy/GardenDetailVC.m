//
//  GardenDetailVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 2/20/14.
//  Copyright (c) 2014 SGSC. All rights reserved.
//

#import "GardenDetailVC.h"

#import "UIButton_Typical.h"
#import "Page_ReadVC.h"
#import "PageManager.h"

@interface GardenDetailVC ()

@end

@implementation GardenDetailVC
@synthesize name, description;
@synthesize nameLabel, descriptionTextView, readMoreButton;
@synthesize font;
@synthesize parent;
@synthesize pageManager;

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
    
    
    descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 72, 410, 206)];
    descriptionTextView.text = description;
    descriptionTextView.editable = NO;
    descriptionTextView.scrollEnabled = YES;
    descriptionTextView.font = subFont;
    
    [self.view addSubview:descriptionTextView];
    
    
    readMoreButton = [[UIButton_Typical alloc] initWithFrame:CGRectMake(125, 286, 200, 44)];
    [readMoreButton addTarget:self action:@selector(readMore) forControlEvents:UIControlEventTouchUpInside];
    
    readMoreButton.titleLabel.font = font;
    readMoreButton.titleLabel.textColor = [UIColor whiteColor];
    readMoreButton.backgroundColor = [UIColor darkGrayColor];
    //[readMoreButton updateGradientForColors:@[(id)[UIColor redColor], (id)[UIColor lightGrayColor]]];
    [readMoreButton setTitle:@"Read More" forState:UIControlStateNormal];

    [self.view addSubview:readMoreButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)readMore
{
    /*Page_ReadVC *prVC = [[Page_ReadVC alloc] initWithParent:self];
    prVC.titleString = self.name;
    prVC.pageText = self.description;
    
    [self presentViewController:prVC animated:YES completion:nil];*/
    
    // Get the information for the activity selected
    NSMutableDictionary *activityDict = [[NSMutableDictionary alloc] init];;
    [activityDict setObject:@"Module" forKey:@"Name"];
    [activityDict setObject:@"Module_Reading" forKey:@"VCName"];
    [activityDict setObject:@"Reading" forKey:@"Symbol"];
    [activityDict setObject:[NSNumber numberWithBool:0] forKey:@"Completed"];
    [activityDict setObject:[NSDate date] forKey:@"Date"];
    
    NSMutableDictionary *page1 = [[NSMutableDictionary alloc] init];
    [page1 setObject:description forKey:@"PageText"];
    [page1 setObject:@"Page_IntroVC" forKey:@"PageVC"];
    
    [activityDict setObject:@[page1] forKey:@"PageArray"];
    
    // Create a PageManager for the activity and store it in THIS view controller.
    pageManager = [[PageManager alloc]initWithActivity: activityDict forParentViewController:self];

}

@end

//
//  Page_QR_DetailVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 3/12/14.
//  Copyright (c) 2014 SGSC. All rights reserved.
//

#import "Page_QR_DetailVC.h"

@interface Page_QR_DetailVC ()

@end

@implementation Page_QR_DetailVC
@synthesize textView, textStr;

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
	// Do any additional setup after loading the view.
    
    textView.frame = CGRectMake(100, 100, self.view.frame.size.width - 200, self.view.frame.size.height - 200);
    textView.text = textStr;

    
    [self.view addSubview:textView];
    
}

-(void)updateColors
{
    [super updateColors];
    
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

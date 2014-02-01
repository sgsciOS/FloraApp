//
//  Page_ReadVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 11/9/13.
//  Copyright (c) 2013 SGSC. All rights reserved.
//

#import "Page_ReadVC.h"

@interface Page_ReadVC ()
{
    
}

@end

@implementation Page_ReadVC
@synthesize dateLabel, otherLabel, nextButton, previousButton, summaryTextView, pageText;

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
    
    summaryTextView.text = pageText;
    
    pageControl.numberOfPages = pageCount.intValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)updateColors
{
    [super updateColors];
    
    [self outlineTextInTextView:summaryTextView];
    summaryTextView.textColor = primaryColor;
    summaryTextView.backgroundColor = secondaryColor;
    
}

@end

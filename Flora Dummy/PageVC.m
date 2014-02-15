//
//  PageVC.m
//  Flora Dummy
//
//  Created by Zach Nichols on 11/2/13.
//  Copyright (c) 2013 SGSC. All rights reserved.
//

#import "PageVC.h"

#import "PageManager.h"
#import "Page_IntroVC.h"

@interface PageVC ()
{    

}

@end

@implementation PageVC
@synthesize parentManager;
@synthesize titleString, dateString, pageNumber, pageCount, pageDictionary;
@synthesize pageControl;
@synthesize colorSchemeDictionary, primaryColor, secondaryColor, backgroundColor;
@synthesize font;
@synthesize nextButton, previousButton;
@synthesize dateLabel, otherLabel, titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithParent: (NSObject *)parent
{
    self = [super init];
    if (self)
    {
        // Save reference to parent.
        parentManager = (PageManager *)parent;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Initialize font
    font = [[UIFont alloc]init];
    font = [UIFont fontWithName:@"Marker Felt" size:32.0];

    UIFont *titleFont = [UIFont fontWithName:@"MarkerFelt-Wide" size:72.0];
    UIFont *subtitleFont = [UIFont fontWithName:@"MarkerFelt-Thin" size:36.0];

    primaryColor = [UIColor blackColor];
    secondaryColor = [UIColor clearColor];
    backgroundColor = [UIColor clearColor];

    // Initialize labels at top of page
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 122, 480, 44)];
    dateLabel.text = [NSString stringWithFormat:@"Date: %@", dateString];
    dateLabel.font = subtitleFont;
    [dateLabel setTextAlignment:NSTextAlignmentLeft];
    [self.view addSubview:dateLabel];
    
    otherLabel = [[UILabel alloc] initWithFrame:CGRectMake(524, 122, 480, 44)];
    otherLabel.text = [NSString stringWithFormat:@"Page: %i of %i", pageNumber.intValue, pageCount.intValue];
    otherLabel.font = subtitleFont;
    [otherLabel setTextAlignment:NSTextAlignmentRight];
    [self.view addSubview:otherLabel];

    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 20, 971, 94)];
    titleLabel.text = titleString;
    titleLabel.font = titleFont;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    
    // Update the dots at the bottom of the screen
    // to reflect what page we're on.
    [pageControl setCurrentPage: pageNumber.intValue - 1];
    
    // Add buttons as needed
    previousButton = [[UIButton alloc]
                      initWithFrame:CGRectMake(20, 675, 120, 44)];
    [previousButton addTarget:self action:@selector(goToPreviousPage) forControlEvents:UIControlEventTouchUpInside];

    nextButton = [[UIButton alloc]
                  initWithFrame:CGRectMake(871, 675, 120, 44)];
    [nextButton addTarget:self action:@selector(goToNextPage) forControlEvents:UIControlEventTouchUpInside];

    // For testing
    //[self outlineButton:nextButton];
    //[self outlineButton:previousButton];
    
    previousButton.titleLabel.font = font;
    nextButton.titleLabel.font = font;
    
    // If there are multiple pages
    if (pageCount.intValue > 0)
    {
        // CHeck if the page is first, last, or middle
        if(pageNumber.intValue == 1)
        {
            // First page
            //
            // Need a Next button and a Quit button
            [previousButton setTitle:@"Quit" forState:UIControlStateNormal];
            [nextButton setTitle:@"Next" forState:UIControlStateNormal];

            
        }else if(pageNumber.intValue == pageCount.intValue)
        {
            // Last page
            //
            // Need a Back button and an Finish button.
            [previousButton setTitle:@"Previous" forState:UIControlStateNormal];
            [nextButton setTitle:@"Finish" forState:UIControlStateNormal];

        }else
        {
            // Need a Back and a Next button
            [previousButton setTitle:@"Previous" forState:UIControlStateNormal];
            [nextButton setTitle:@"Next" forState:UIControlStateNormal];

            
        }
        
        [self.view addSubview:previousButton];
        [self.view addSubview:nextButton];
        
        
    }else
    {
        // Single page
        //
        // Only need finish button
        previousButton = nil;
        [nextButton setTitle:@"Finish" forState:UIControlStateNormal];
        
        [self.view addSubview:nextButton];

    }

}

-(void)viewWillAppear:(BOOL)animated
{
    // Update colors in case the user changed settings
    [self updateColors];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// End activity stops the activity and returns back to the
// subject screen
-(IBAction)endActivity
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Next page moves the activity to the next page,
// and sends signal to page manager to move forward.
-(IBAction)goToNextPage
{
    // If there's a page to go forward to,
    // let page manager go forward
    if (pageNumber.intValue + 1 <= pageCount.intValue)
    {
        [(PageManager *)parentManager goToNextViewController];
    }else
    {
        // End activity because there's nowhere to go
        [self endActivity];
    }
}

// Previous page moves the activity to the previous page,
// and sends signal to page manager to move back.
-(IBAction)goToPreviousPage
{
    // If there's a page to go back to,
    // let page manager go back
    if (pageNumber.intValue -1 > 0)
    {
        [(PageManager *)parentManager goToPreviousViewController];
    }else
    {
        // End activity because there's nowhere to go
        [self endActivity];
    }
}


# pragma mark
# pragma mark Color Stuff

// These functions are used to convert a hex number (in string format) to a UIColor.
// These functions are just to condense code.
- (UIColor *) colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    alpha = 1.0f;
    red   = [self colorComponentFrom: colorString start: 0 length: 2];
    green = [self colorComponentFrom: colorString start: 2 length: 2];
    blue  = [self colorComponentFrom: colorString start: 4 length: 2];
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

- (CGFloat) colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

// Updates colors in view
// Subclasses should call this method and then perform additional actions
-(void)updateColors
{
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // Get Colors
    primaryColor = [self colorWithHexString:[defaults objectForKey:@"primaryColor"]];
    secondaryColor = [self colorWithHexString:[defaults objectForKey:@"secondaryColor"]];
    backgroundColor = [self colorWithHexString:[defaults objectForKey:@"backgroundColor"]];
    
    // Override
    // Fix this later
    primaryColor =[UIColor whiteColor];
    secondaryColor = [self lighterColorForColor:backgroundColor];
    
    nextButton.backgroundColor = backgroundColor;
    [nextButton setTitleColor:primaryColor forState:UIControlStateNormal];
    previousButton.backgroundColor = backgroundColor;
    [previousButton setTitleColor:primaryColor forState:UIControlStateNormal];
    
    dateLabel.textColor = primaryColor;
    [self outlineTextInLabel:dateLabel];
    
    otherLabel.textColor = primaryColor;
    [self outlineTextInLabel:otherLabel];
    
    titleLabel.textColor = primaryColor;
    [self outlineTextInLabel:titleLabel];
    
    self.view.backgroundColor = backgroundColor;
}

// This function outlines the text in a label, meaning it gives
// the text a border. This presents a more "bubble" letter effect,
// which is more pleasant for elementary schoolers.
-(void)outlineTextInLabel: (UILabel *)label
{
    label.layer.shadowColor = [[UIColor blackColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.1f, 0.1f);
    label.layer.shadowOpacity = 1.0f;
    label.layer.shadowRadius = 1.0f;
    
    return;
}

// This function outlines the text in a text view, meaning it gives
// the text a border. This presents a more "bubble" letter effect,
// which is more pleasant for elementary schoolers.
//
// Note: this is a little more complicated than a label
-(void)outlineTextInTextView: (UITextView *)textView
{
    // Store the text real quick
    NSString *text = textView.text;
    
    // Format paragraphs
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 10.0;
    paragraphStyle.firstLineHeadIndent = 10.0;
    paragraphStyle.tailIndent = -10.0;
    
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: font,
                                      NSParagraphStyleAttributeName: paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attrsDictionary];
    
    
    // Change the color of the text
    textView.textColor = primaryColor;
    
    // Create a shadow on the texts
    textView.textInputView.layer.shadowColor = [[UIColor blackColor] CGColor];
    textView.textInputView.layer.shadowOffset = CGSizeMake(0.1f, 0.1f);
    textView.textInputView.layer.shadowOpacity = 1.0f;
    textView.textInputView.layer.shadowRadius = 1.0f;
    
    // Create a border around the text view
    float borderWidth = 2.0f;
    [textView.layer setBorderWidth:borderWidth];
    [textView.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    // Add some cushion so that the text isn't touching the border
    textView.contentInset = UIEdgeInsetsMake(10.0,0.0,10.0,0.0);
    
    return;
}

// This function outlines buttons with a border
-(void)outlineButton: (UIButton *)button
{
    float borderWidth = 4.0f;
    
    [self outlineTextInLabel:button.titleLabel];
    
    [[button layer] setBorderWidth:borderWidth];
    [[button layer] setBorderColor:[UIColor whiteColor].CGColor];
}

// THis function outlines views with a border
-(void)outlineView: (UIView *)view
{
    float borderWidth = 2.0f;
    
    [[view layer] setBorderWidth:borderWidth];
    [[view layer] setBorderColor:[UIColor whiteColor].CGColor];
}

// Creates a slightly lighter color for a given color
- (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.1, 1.0)
                               green:MIN(g + 0.1, 1.0)
                                blue:MIN(b + 0.1, 1.0)
                               alpha:a];
    return nil;
}

// Creates a slightly darker color for a given color
- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.1, 0.0)
                               green:MAX(g - 0.1, 0.0)
                                blue:MAX(b - 0.1, 0.0)
                               alpha:a];
    return nil;
}

@end

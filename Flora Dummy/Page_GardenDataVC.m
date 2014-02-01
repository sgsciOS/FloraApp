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
    UIColor *primaryColor;
    UIColor *secondaryColor;
    UIColor *backgroundColor;
    
    UIFont *font;
    
    CGVector velocity;
}
@end

@implementation Page_GardenDataVC
@synthesize endButton, gardenImage;

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
    
    gardenImage = [[UIImageView alloc] initWithFrame:CGRectMake(33, 72, 971, 602)];
    gardenImage.image = [UIImage imageNamed:@"woods.png"];
    [self.view addSubview:gardenImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self updateColors];
    
}

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

-(void)updateColors
{
    // Get the stored data before the view loads
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    primaryColor = [self colorWithHexString:[defaults objectForKey:@"primaryColor"]];
    secondaryColor = [self colorWithHexString:[defaults objectForKey:@"secondaryColor"]];
    backgroundColor = [self colorWithHexString:[defaults objectForKey:@"backgroundColor"]];
    
    primaryColor =[UIColor whiteColor];
    secondaryColor = [self lighterColorForColor:backgroundColor];
    
    endButton.backgroundColor = backgroundColor;
    [endButton setTitleColor:primaryColor forState:UIControlStateNormal];
    
    self.view.backgroundColor = backgroundColor;
}

-(void)outlineTextInLabel: (UILabel *)label
{
    label.layer.shadowColor = [[UIColor blackColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.1f, 0.1f);
    label.layer.shadowOpacity = 1.0f;
    label.layer.shadowRadius = 1.0f;
    
    return;
}

-(void)outlineTextInTextView: (UITextView *)textView
{
    NSString *text = textView.text;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.headIndent = 10.0;
    paragraphStyle.firstLineHeadIndent = 10.0;
    paragraphStyle.tailIndent = -10.0;
    
    NSDictionary *attrsDictionary = @{NSFontAttributeName: [UIFont fontWithName:@"Marker Felt" size:28.0], NSParagraphStyleAttributeName: paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attrsDictionary];
    textView.textColor = primaryColor;
    
    float borderWidth = 2.0f;
    
    textView.textInputView.layer.shadowColor = [[UIColor blackColor] CGColor];
    textView.textInputView.layer.shadowOffset = CGSizeMake(0.1f, 0.1f);
    textView.textInputView.layer.shadowOpacity = 1.0f;
    textView.textInputView.layer.shadowRadius = 1.0f;
    
    [textView.layer setBorderWidth:borderWidth];
    [textView.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    textView.contentInset = UIEdgeInsetsMake(10.0,0.0,10.0,0.0);
    
    return;
}

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

//
//  PageVC.h
//  Flora Dummy
//
//  Created by Zach Nichols on 11/2/13.
//  Copyright (c) 2013 SGSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageVC : UIViewController
{
    // Reference to parent page manager
    NSObject *parentManager; //do not call PageManager on this page--will create infinite loop
    
    // Title string holds title of page
    NSString *titleString;
    
    // Date string holds due date of assignment
    NSString *dateString;
    
    // Page number is the numeric number of the page, not the index
    NSNumber *pageNumber;
    
    // Page count represents how many pages are in this activity.
    NSNumber *pageCount;
    
    // Page dictionary keeps info about the specific page
    NSDictionary *pageDictionary;
    
    // Page Control allows us to see those dots at the bottom of the screen
    // representing pages.
    IBOutlet UIPageControl *pageControl;
    
    
    
    // Holds loaded data for colors, specifically HEX code
    NSDictionary *colorSchemeDictionary;
    
    // Stores UIColors for easy/quicker access
    UIColor *primaryColor;
    UIColor *secondaryColor;
    UIColor *backgroundColor;
    
    // Store font to be used
    UIFont *font;
}

@property(nonatomic, retain) NSObject *parentManager; //do not call PageManager on this page--will create infinite loop

@property(nonatomic, retain) NSString *titleString;
@property(nonatomic, retain) NSString *dateString;
@property(nonatomic, retain) NSNumber *pageNumber;
@property(nonatomic, retain) NSNumber *pageCount;
@property(nonatomic, retain) NSDictionary *pageDictionary;

@property(nonatomic, retain) NSDictionary *colorSchemeDictionary;
@property(nonatomic, retain) UIColor *primaryColor;
@property(nonatomic, retain) UIColor *secondaryColor;
@property(nonatomic, retain) UIColor *backgroundColor;
@property(nonatomic, retain) UIFont *font;

@property(nonatomic, retain) IBOutlet UIPageControl *pageControl;

// Buttons for navigation
@property(nonatomic, retain) UIButton *nextButton;
@property(nonatomic, retain) UIButton *previousButton;

// Labels for displaying information at top of page
@property(nonatomic, retain) UILabel *dateLabel;
@property(nonatomic, retain) UILabel *otherLabel; //assign meaning to this later
@property(nonatomic, retain) UILabel *titleLabel;

// Custom initialization lets us store reference
// to parent
-(id)initWithParent: (NSObject *)parent;

// End activity stops the activity and returns back to the
// subject screen
-(IBAction)endActivity;

// Next page moves the activity to the next page,
// and sends signal to page manager to move forward.
-(IBAction)goToNextPage;

// Previous page moves page to previous page,
// and sends signal to page manager to move back.
-(IBAction)goToPreviousPage;


// These functions are used to convert a hex number (in string format) to a UIColor.
// These functions are just to condense code.
- (UIColor *) colorWithHexString:(NSString *)hexString;

- (CGFloat) colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length;

// Updates colors in view
// Subclasses should call this method and then perform additional actions
-(void)updateColors;

// This function outlines the text in a label, meaning it gives
// the text a border. This presents a more "bubble" letter effect,
// which is more pleasant for elementary schoolers.
-(void)outlineTextInLabel: (UILabel *)label;

// This function outlines the text in a text view, meaning it gives
// the text a border. This presents a more "bubble" letter effect,
// which is more pleasant for elementary schoolers.
//
// Note: this is a little more complicated than a label
-(void)outlineTextInTextView: (UITextView *)textView;

// This function outlines buttons with a border
-(void)outlineButton: (UIButton *)button;

// THis function outlines views with a border
-(void)outlineView: (UIView *)view;

// Creates a slightly lighter color for a given color
- (UIColor *)lighterColorForColor:(UIColor *)c;

// Creates a slightly darker color for a given color
- (UIColor *)darkerColorForColor:(UIColor *)c;


@end

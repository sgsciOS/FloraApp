//
//  EquationFormatter.m
//  Flora Dummy
//
//  Created by Zach Nichols on 1/30/14.
//  Copyright (c) 2014 SGSC. All rights reserved.
//

#import "EquationFormatter.h"

@interface EquationFormatter ()
{
    NSArray *opsArray;
}
@end

@implementation EquationFormatter

-(NSArray *)returnBoxesForEquationString: (NSString *)eqStr
{
    opsArray = [NSArray arrayWithObjects:@"+", @"-", @"*", @"/", @"^", @"(", @")", nil];
    
    NSMutableArray *boxes = [[NSMutableArray alloc]init];
    
    NSArray *stringComponents = [eqStr componentsSeparatedByString:@"%"];
    
    for (NSString *component in stringComponents)
    {
        NSString *firstChar = [component substringWithRange:NSMakeRange(0,1)];

        // Test to see if there is a variable
        if ([firstChar isEqualToString:@"#"])
        {
            // This indicates a variable
            NSString *varStr = [component substringWithRange:NSMakeRange(1,component.length-1)];

            [boxes addObject:[self createTextBoxForString:varStr]];
            
            break;
        }
        
        // Test to see if there is an answer box requested
        if ([firstChar isEqualToString:@"?"])
        {
            NSString *answerStr = [component substringWithRange:NSMakeRange(1,component.length-1)];

            [boxes addObject:[self createAnswerBoxForAnswer:answerStr]];
            
            break;
        }
        
        // Test to see if the string is a number
        NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if ([component rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            // String consists only of the digits 0 through 9
            NSNumber *num = [NSNumber numberWithFloat:component.floatValue];
            
            [boxes addObject:[self createNumberTextBoxForNumber:num]];
            
            break;
        }
        
        // Test for characters
        for (NSString *opStr in opsArray)
        {
            if ([firstChar isEqualToString:opStr])
            {
                // We have an operator
                [boxes addObject:[self createOperatorBoxForOp:component]];
                
                break;
            }
        }

    }

    return boxes;
}

-(NSDictionary *)createOperatorBoxForOp: (NSString *)opStr;
{
    NSMutableDictionary *opBox = [[NSMutableDictionary alloc] init];
    
    return opBox;
}

-(NSDictionary *)createTextBoxForString: (NSString *)str;
{
    NSMutableDictionary *textBox = [[NSMutableDictionary alloc] init];
    
    return textBox;
}

-(NSDictionary *)createNumberTextBoxForNumber: (NSNumber *)num;
{
    NSMutableDictionary *textBox = [[NSMutableDictionary alloc] init];
    
    return textBox;
}

-(NSDictionary *)createAnswerBoxForAnswer: (NSString *)answerStr;
{
    NSMutableDictionary *ansBox = [[NSMutableDictionary alloc] init];
    
    return ansBox;
}

@end

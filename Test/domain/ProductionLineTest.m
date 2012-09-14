//
//  ProductionLineTest.m
//  ProductionLine
//
//  Created by Andy Marks on 09/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductionLineTest.h"

@implementation ProductionLineTest

- (void)testTestFramework
{
    NSString *string1 = @"test";
    NSString *string2 = @"test";
    STAssertEquals(string1, string2, @"FAILURE");

    NSUInteger uint_1 = 4;
    NSUInteger uint_2 = 4;
    STAssertEquals(uint_1, uint_2, @"FAILURE");
}

@end

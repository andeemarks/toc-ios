//
//  Station.h
//  ProductionLine
//
//  Created by Andrew Marks on 17/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject
{
    int number;
    int size;
    int score;
}

-(id) initWithId:(int) myNumber andSize:(int) mySize;

@end

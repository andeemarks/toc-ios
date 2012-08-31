//
//  ProductionLineRunMetrics.h
//  ProductionLine
//
//  Created by Andrew Marks on 28/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductionLine.h"

@interface ProductionLineRunMetrics : NSObject <NSURLConnectionDelegate>

-(id) initWithProductionLine:(ProductionLine *) line;

@property (strong) NSMutableData *response;
@property (strong) ProductionLine *line;

-(BOOL) saveWithError:(NSError **) theError;

@end

//
//  FlashMessageView.h
//  ProductionLine
//
//  Created by Andrew Marks on 31/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlashMessageView : UIAlertView

- (id)initWithMessage:(NSString *)message dismissAfter:(NSTimeInterval)interval;

@end

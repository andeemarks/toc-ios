//
// Created by amarks on 31/08/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Environment : NSObject

@property (strong, nonatomic) NSString *myApiURL;

+(id) sharedInstance;

@end
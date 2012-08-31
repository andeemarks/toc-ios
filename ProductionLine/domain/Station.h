#import <Foundation/Foundation.h>
#import "StationChangeMetrics.h"

@interface Station : NSObject

@property int number;
@property int size;
@property float score;
@property int dice;
@property (strong, nonatomic) StationChangeMetrics *changes;

-(id) initWithId:(int) myNumber;
-(id) initWithSize:(int) mySize;
-(void) increaseInventoryBy:(int) amountToIncrease;
-(int) selectInventoryToRemove;
-(BOOL) isEmpty;
-(NSString *) recentChanges;

@end

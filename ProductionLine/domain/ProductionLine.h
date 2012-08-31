#import <Foundation/Foundation.h>
#import "Station.h"

@class ProductionLineRunMetrics; // forward declaration to prevent circular dependency issue with imports

@interface ProductionLine : NSObject

@property int numberOfStations;
@property int inventory;
@property (nonatomic) NSMutableArray *stationData;
@property (strong, nonatomic) Station *partsBin;
@property (nonatomic) NSInteger cycleCount;
@property (strong, readonly) ProductionLineRunMetrics *metrics;

-(void) runOneCycle;
-(void) completeRun;
-(id) initWithNumberOfStations:(int) theNumberOfStations andInventory: (int) theInventory;
-(Station *) stationAtIndex: (int) index;
-(BOOL) isFinished;
-(int) completedInventory;
-(int) unprocessedInventory;
- (BOOL) hasUnprocessedInventory;
-(Station *) getSourceStationForStationId: (int)destinationStationId;
-(NSString *)toJSON;

@end

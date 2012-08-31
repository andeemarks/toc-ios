#import <Foundation/Foundation.h>
#import "ProductionLine.h"

@interface ProductionLineRunMetrics : NSObject <NSURLConnectionDelegate>

-(id) initWithProductionLine:(ProductionLine *) line;

typedef enum {
    kUndefined,
    kSuccess,
    kFail
} SaveStatus;

@property (strong) NSMutableData *response;
@property (strong) ProductionLine *line;
@property (nonatomic) SaveStatus saveSuccessful;

-(BOOL) saveWithError:(NSError **) theError;

+(BOOL) didSaveSuccessfully: (NSNumber *) keyValue ;

@end

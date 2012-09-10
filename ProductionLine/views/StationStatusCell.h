#import <UIKit/UIKit.h>

@class Station;

@interface StationStatusCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *size;
@property (strong, nonatomic) IBOutlet UILabel *score;
@property (strong, nonatomic) IBOutlet UILabel *changes;

- (void)updateFromStation:(Station *)station previousStation:(Station *)previousStation;

@end

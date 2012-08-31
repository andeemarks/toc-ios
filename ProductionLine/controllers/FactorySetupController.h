#import <UIKit/UIKit.h>

@interface FactorySetupController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate> {
}


@property (nonatomic) NSInteger inventorySize;
@property (nonatomic) NSInteger stationCount;

@end

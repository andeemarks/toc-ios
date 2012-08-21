//
//  ProductionLineFirstViewController.h
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactorySetupController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIAlertViewDelegate> {
    
    NSMutableArray *stationCountValues;    
    NSMutableArray *inventorySizeValues;    
}


@property (nonatomic) NSInteger inventorySize;
@property (nonatomic) NSInteger stationCount;

@end

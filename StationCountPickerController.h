//
//  StationCountPickerController.h
//  ProductionLine
//
//  Created by Andy Marks on 16/8/12.
//  Copyright (c) 2012 amarks@thoughtworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationCountPickerController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    IBOutlet UIPickerView *pickerView;
    NSMutableArray *values;
}

@end

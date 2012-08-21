//
//  ProductionLineSecondViewController.h
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"

@interface ProductionLineController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSInteger inventorySize;
@property (nonatomic) NSInteger stationCount;
@property (nonatomic) NSMutableArray *stationData;
@property (nonatomic) Station *partsBin;

- (void)retreiveSetup;
@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;
@property (weak, nonatomic) IBOutlet UITableView *stationTable;
- (IBAction)play:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *completedInventoryLabel;

@end

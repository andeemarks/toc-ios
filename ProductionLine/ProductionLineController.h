//
//  ProductionLineSecondViewController.h
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"
#import "ProductionLine.h"

@interface ProductionLineController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) ProductionLine *line;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;
@property (weak, nonatomic) IBOutlet UITableView *stationTable;
- (IBAction)play:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *completedInventoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleCountLabel;

@end

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
@property (weak, nonatomic) IBOutlet UIButton *fastForwardButton;

@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;
@property (weak, nonatomic) IBOutlet UITableView *stationTable;
@property (weak, nonatomic) IBOutlet UILabel *completedInventoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleCountLabel;

- (IBAction)play:(id)sender;
- (IBAction)fastForward:(id)sender;

@end

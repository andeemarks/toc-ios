//
//  ProductionLineSecondViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductionLineController.h"
#import "StationStatusCell.h"
#import "Station.h"
#import "ProductionLine.h"
#import <stdlib.h>

@implementation ProductionLineController

@synthesize completedInventoryLabel;
@synthesize cycleCountLabel;
@synthesize inventorySizeLabel;
@synthesize stationTable;

@synthesize line;
@synthesize playButton;
@synthesize fastForwardButton;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self retreiveSetup];
    
    [stationTable reloadData];
    [playButton setEnabled: TRUE];
    [fastForwardButton setEnabled: TRUE];
    cycleCountLabel.text = [NSString stringWithFormat: @"%i", [line cycleCount]];
    [self updateInventoryLabels];
    
}

- (void)viewDidUnload {
    [self setInventorySizeLabel:nil];
    [self setStationTable:nil];
    [self setCompletedInventoryLabel:nil];
    [self setPlayButton:nil];
    [self setCycleCountLabel:nil];
    [self setFastForwardButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait || 
            interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown );
}

#pragma mark Table Stuff

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [line numberOfStations];
}

- (UITableViewCell *) findCellForPath:(NSIndexPath *) indexPath {
    NSString *cellId = [NSString stringWithFormat:@"%d", [indexPath indexAtPosition:1] + 1];
    
    UITableViewCell *cell = [stationTable dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        //Load custom cell from NIB file
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StationStatusCell" owner:self options:NULL];
        cell = (StationStatusCell *) [nib objectAtIndex:0];
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cellForRowAtIndexPath");
    UITableViewCell *cell = [self findCellForPath: indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    int rowIndex = [indexPath indexAtPosition: 1];
    Station *station = [line stationAtIndex: rowIndex];
    Station *previousStation = [line getSourceStationForStationId: rowIndex];
                        
    [self updateCell: (StationStatusCell*) cell fromStation: station previousStation: previousStation];

    return cell;
}

- (void) updateCell:(StationStatusCell *) cell fromStation:(Station *) station previousStation: (Station *) previousStation {
    cell.number.text = [NSString stringWithFormat: @"%d", [station number]];
    cell.size.text =   [NSString stringWithFormat: @"%d", [station size]];
    cell.score.text =  [NSString stringWithFormat: @"%.1f", [station score]];
    cell.changes.text =[station recentChanges];
    
    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0, 20, 20)];
    imv.image = [UIImage imageNamed:[NSString stringWithFormat: @"Dice%d.png", [previousStation dice]]];
    [cell.contentView addSubview:imv];
}

#pragma mark Header Stuff

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] 
                          initWithFrame:CGRectMake(0,0,tableView.frame.size.width,20)];
    
    [self addStationLabelToView: headerView];
    [self addDiceLabelToView: headerView];
    [self addSizeLabelToView: headerView];
    [self addChangesLabelToView: headerView];
    [self addScoreLabelToView: headerView];
    
    return headerView;
}

- (void) addLabel: (NSString *) text toView: (UIView *)view startingAtXPos: (NSInteger) startXPos {
    UILabel *label = [[UILabel alloc] 
                      initWithFrame:CGRectMake(startXPos, 0, 200, view.frame.size.height)];
    
    label.text = text;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont fontWithName:@"Helvetica" size: 12.0]; 
    
    [view addSubview:label];
}

- (void) addStationLabelToView: (UIView *) headerView {
    [self addLabel: @"Station" toView: headerView startingAtXPos: 0];
}

- (void) addDiceLabelToView: (UIView *) headerView {
    [self addLabel: @"Roll" toView: headerView startingAtXPos: 80];
}

- (void) addSizeLabelToView: (UIView *) headerView {
    [self addLabel: @"Size" toView: headerView startingAtXPos: 130];
}

- (void) addScoreLabelToView: (UIView *) headerView {
    [self addLabel: @"Score" toView: headerView startingAtXPos: 230];
}

- (void) addChangesLabelToView: (UIView *) headerView {
    [self addLabel: @"Changes" toView: headerView startingAtXPos: 160];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  20.0;
}

#pragma mark App Logic

- (void)retreiveSetup {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    int stationCount = [prefs integerForKey:@"stationCount"];
    int inventorySize = [prefs integerForKey:@"inventorySize"];
    
    inventorySizeLabel.text = [NSString stringWithFormat: @"%i", inventorySize];
    
    line = [[ProductionLine alloc] initWithNumberOfStations: stationCount andInventory: inventorySize];

}

- (void)updateInventoryLabels {
    if (![line hasUnprocessedInventory]) {
        inventorySizeLabel.text = @"<empty>";
    } else {
        inventorySizeLabel.text = [NSString stringWithFormat: @"%i", [line unprocessedInventory]];
    }
    
    if ([line completedInventory] <= 0) {
        completedInventoryLabel.text = @"<empty>";
    } else {
        completedInventoryLabel.text = [NSString stringWithFormat: @"%i", [line completedInventory]];
    }
}


- (IBAction)play:(id)sender {
    [line runOneCycle];
    [stationTable reloadData];
    [self updateInventoryLabels];
    
    if ([line isFinished]) {
        [playButton setEnabled: FALSE];
        [fastForwardButton setEnabled: FALSE];
    }
    
    cycleCountLabel.text = [NSString stringWithFormat: @"%i", [line cycleCount]];
}

- (IBAction)fastForward:(id)sender {
    while (![line isFinished]) {
        [self play: sender];
    }
}

@end

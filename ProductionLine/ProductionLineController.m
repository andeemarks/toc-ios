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
#import <stdlib.h>

@implementation ProductionLineController
@synthesize completedInventoryLabel;
@synthesize inventorySizeLabel;
@synthesize stationTable;

@synthesize stationData;
@synthesize inventorySize;
@synthesize stationCount;
@synthesize partsBin;
@synthesize playButton;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self retreiveSetup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self retreiveSetup];
    [stationTable reloadData];
    
    [self initStationData];
}

- (void)initStationData {
    stationData = [[NSMutableArray alloc] initWithCapacity: stationCount];
    
    partsBin = [[Station alloc] initWithSize: inventorySize];
    for(int n = 1; n <= stationCount; n = n + 1) {
        [stationData addObject:[[Station alloc] initWithId:n]];
    }
}

- (void)viewDidUnload {
    [self setInventorySizeLabel:nil];
    [self setStationTable:nil];
    [self setCompletedInventoryLabel:nil];
    [self setPlayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self stationCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"cellForRowAtIndexPath");
    NSString *cellId = [NSString stringWithFormat:@"%d", [indexPath indexAtPosition:1] + 1];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        //Load custom cell from NIB file
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StationStatusCell" owner:self options:NULL];
        cell = (StationStatusCell *) [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    Station *station = [stationData objectAtIndex: [indexPath indexAtPosition: 1]];
                        
    [self updateCell: cell fromStation: station];

    return cell;
}

- (void) updateCell:(UITableViewCell *) cell fromStation:(Station *) station {
    ((StationStatusCell*) cell).number.text = [NSString stringWithFormat: @"%d", [station number]];
    ((StationStatusCell*) cell).size.text =   [NSString stringWithFormat: @"%d", [station size]];
    ((StationStatusCell*) cell).score.text =  [NSString stringWithFormat: @"%d", [station score]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,20)];
    
    [self addStationLabelToView: headerView];
    [self addSizeLabelToView: headerView];
    [self addScoreLabelToView: headerView];
    
    return headerView;
}

- (void) addLabel: (NSString *) text toView: (UIView *)view startingAtXPos: (NSInteger) startXPos {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startXPos, 0, 200, view.frame.size.height)];
    
    label.text = text;
    label.backgroundColor = [UIColor blueColor];
    label.textColor = [UIColor whiteColor];
    
    [view addSubview:label];
}

- (void) addStationLabelToView: (UIView *) headerView {
    [self addLabel: @"Station" toView: headerView startingAtXPos: 0];
}

- (void) addSizeLabelToView: (UIView *) headerView {
    [self addLabel: @"Size" toView: headerView startingAtXPos: 120];
}

- (void) addScoreLabelToView: (UIView *) headerView {
    [self addLabel: @"Score" toView: headerView startingAtXPos: 230];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  20.0;
}

- (void)retreiveSetup {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    stationCount = [prefs integerForKey:@"stationCount"];
    inventorySize = [prefs integerForKey:@"inventorySize"];
    
    inventorySizeLabel.text = [NSString stringWithFormat: @"%i", self.inventorySize];
}

- (void)updateInventoryLabels {
    if (partsBin.isEmpty) {
        inventorySizeLabel.text = @"<empty>";
    } else {
        inventorySizeLabel.text = [NSString stringWithFormat: @"%i", partsBin.size];
    }
    
    if (((Station *)stationData.lastObject).isEmpty) {
        completedInventoryLabel.text = @"<empty>";
    } else {
        completedInventoryLabel.text = [NSString stringWithFormat: @"%i", ((Station *)stationData.lastObject).size];
    }
}

- (BOOL)isFinished {
    return ((Station *)stationData.lastObject).size >= [self inventorySize];
}

- (IBAction)play:(id)sender {
    int diceRoll = arc4random_uniform(6) + 1;
    int amountToAdd = [partsBin reduceInventoryBy: diceRoll];
    
    for (Station *station in stationData) {
        [station increaseInventoryBy: amountToAdd];
        diceRoll = arc4random_uniform(6) + 1;
        if (station != [stationData lastObject]) {
            amountToAdd = [station reduceInventoryBy: diceRoll];
        }
    }
    [stationTable reloadData];
    [self updateInventoryLabels];
    
    if ([self isFinished]) {
        [self.playButton setEnabled: FALSE];
    }
}
@end

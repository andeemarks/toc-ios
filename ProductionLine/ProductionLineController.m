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

@interface ProductionLineController ()

- (void)retreiveSetup;
@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;
@property (weak, nonatomic) IBOutlet UITableView *stationTable;
- (IBAction)play:(id)sender;

@end

@implementation ProductionLineController
@synthesize inventorySizeLabel;
@synthesize stationTable;

@synthesize stationData;
@synthesize inventorySize;
@synthesize stationCount;
@synthesize partsBin;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self retreiveSetup];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self retreiveSetup];
    [stationTable reloadData];
    
    [self initStationData];
}

- (void)initStationData
{
    stationData = [[NSMutableArray alloc] initWithCapacity: stationCount];
    
    partsBin = [[Station alloc] initWithSize: inventorySize];
    for(int n = 1; n <= stationCount; n = n + 1) {
        [stationData addObject:[[Station alloc] initWithId:n]];
    }

}

- (void)viewDidUnload
{
    [self setInventorySizeLabel:nil];
    [self setStationTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Station";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self stationCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cellForRowAtIndexPath");
    NSString *cellId = [NSString stringWithFormat:@"%d", [indexPath indexAtPosition:1] + 1];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil)
    {
        //Load custom cell from NIB file
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StationStatusCell" owner:self options:NULL];
        cell = (StationStatusCell *) [nib objectAtIndex:0];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    Station *station = [stationData objectAtIndex: [indexPath indexAtPosition: 1]];
                        
    NSLog(@"%@", station.description);
    ((StationStatusCell*) cell).number.text = [NSString stringWithFormat: @"%d", [station number]];
    ((StationStatusCell*) cell).size.text = [NSString stringWithFormat: @"%d", [station size]];
    ((StationStatusCell*) cell).score.text = [NSString stringWithFormat: @"%d", [station score]];

    return cell;
    
//    NSString *cellId = [NSString stringWithFormat:@"%d", [indexPath indexAtPosition:1] + 1];
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier: cellId];
//    }
//    
//    UILabel *cellText = [cell textLabel];
//    cellText.text = [[stationData objectAtIndex: [indexPath indexAtPosition: 1]] description]; 
//    
//    return cell;
}

- (void)retreiveSetup 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.stationCount = [prefs integerForKey:@"stationCount"];
    self.inventorySize = [prefs integerForKey:@"inventorySize"];
    
    self.inventorySizeLabel.text = [NSString stringWithFormat: @"%i", self.inventorySize];
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
    self.inventorySizeLabel.text = [NSString stringWithFormat: @"%i", partsBin.size];
}
@end

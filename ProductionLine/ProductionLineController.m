//
//  ProductionLineSecondViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductionLineController.h"

@interface ProductionLineController ()

- (void)retreiveSetup;
@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *stationTable;

@end

@implementation ProductionLineController
@synthesize inventorySizeLabel;
@synthesize stationCountLabel;
@synthesize stationTable;


@synthesize inventorySize;
@synthesize stationCount;

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
}

- (void)viewDidUnload
{
    [self setInventorySizeLabel:nil];
    [self setStationCountLabel:nil];
    [self setStationTable:nil];
    [self setStationTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self stationCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = [NSString stringWithFormat:@"Station %d", [indexPath indexAtPosition:1] + 1];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier: cellId];
    }
    
    UILabel *cellText = [cell textLabel];
    cellText.text = cellId; 
    
    return cell;
}

- (void)retreiveSetup 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    self.stationCount = [prefs integerForKey:@"stationCount"];
    self.inventorySize = [prefs integerForKey:@"inventorySize"];
    
    self.stationCountLabel.text = [NSString stringWithFormat: @"%i", self.stationCount];
    self.inventorySizeLabel.text = [NSString stringWithFormat: @"%i", self.inventorySize];
    
//    self.stationTable.numberOfSections = self.stationCount;
}

@end

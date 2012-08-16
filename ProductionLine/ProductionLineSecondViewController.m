//
//  ProductionLineSecondViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductionLineSecondViewController.h"

@interface ProductionLineSecondViewController ()

- (void)retreiveSetup;
@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *stationTable;

@end

@implementation ProductionLineSecondViewController
@synthesize inventorySizeLabel;
@synthesize stationCountLabel;
@synthesize stationTable;


@synthesize inventorySize;
@synthesize stationCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self retreiveSetup];
}

- (void)viewDidUnload
{
    [self setInventorySizeLabel:nil];
    [self setStationCountLabel:nil];
    [self setStationTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
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

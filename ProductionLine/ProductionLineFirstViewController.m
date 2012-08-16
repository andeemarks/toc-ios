//
//  ProductionLineFirstViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProductionLineFirstViewController.h"

@interface ProductionLineFirstViewController ()

- (IBAction)inventorySizeChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *inventorySizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;

- (IBAction)stationCountChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *stationCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *stationCountLabel;

- (void)persistSetup;

@end

@implementation ProductionLineFirstViewController

@synthesize stationCountSlider;
@synthesize stationCountLabel;
@synthesize stationCount;
@synthesize inventorySizeSlider;
@synthesize inventorySizeLabel;
@synthesize inventorySize;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setInventorySizeSlider:nil];
    [self setInventorySizeLabel:nil];
    [self setStationCountSlider:nil];
    [self setStationCountLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)inventorySizeChanged:(UISlider *)sender {
    self.inventorySize = (int) inventorySizeSlider.value;
    
    self.inventorySizeLabel.text = [NSString stringWithFormat: @"%i", self.inventorySize];

    [self persistSetup];
}
- (IBAction)stationCountChanged:(UISlider *)sender {
    self.stationCount = (int) stationCountSlider.value;
    
    self.stationCountLabel.text = [NSString stringWithFormat: @"%i", self.stationCount];

    [self persistSetup];
}

- (void)persistSetup 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    [prefs setInteger:self.stationCount forKey:@"stationCount"];
    [prefs setInteger:self.inventorySize forKey:@"inventorySize"];

    [prefs synchronize];
}
@end

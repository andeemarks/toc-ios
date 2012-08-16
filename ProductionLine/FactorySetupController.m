//
//  ProductionLineFirstViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FactorySetupController.h"
#import "StationCountPickerController.h"

@interface FactorySetupController ()

- (IBAction)inventorySizeChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *inventorySizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;

- (IBAction)stationCountChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *stationCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *stationCountLabel;

- (void)persistSetup;

@end

@implementation FactorySetupController

@synthesize stationCountSlider;
@synthesize stationCountLabel;
@synthesize stationCount;
@synthesize inventorySizeSlider;
@synthesize inventorySizeLabel;
@synthesize inventorySize;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    StationCountPickerController *stationCountPicker = [[StationCountPickerController alloc] initWithNibName:@"PickerView" bundle:[NSBundle mainBundle]];
    
    [window addSubview:stationCountPicker.view];
    
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self persistSetup];
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

- (void)captureInventorySize {
    self.inventorySize = (int) inventorySizeSlider.value;
    
    self.inventorySizeLabel.text = [NSString stringWithFormat: @"%i", self.inventorySize];
}

- (IBAction)inventorySizeChanged:(UISlider *)sender {
    [self captureInventorySize];
}

- (void)captureStationCount {
    self.stationCount = (int) stationCountSlider.value;
    
    self.stationCountLabel.text = [NSString stringWithFormat: @"%i", self.stationCount];
}

- (IBAction)stationCountChanged:(UISlider *)sender {
    [self captureStationCount];
}

- (void)persistSetup 
{
    [self captureInventorySize];
    [self captureStationCount];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    [prefs setInteger:self.stationCount forKey:@"stationCount"];
    [prefs setInteger:self.inventorySize forKey:@"inventorySize"];

    [prefs synchronize];
}
@end

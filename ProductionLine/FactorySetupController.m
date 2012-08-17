//
//  ProductionLineFirstViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FactorySetupController.h"

@interface FactorySetupController ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (IBAction)inventorySizeChanged:(UISlider *)sender;
@property (weak, nonatomic) IBOutlet UISlider *inventorySizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *inventorySizeLabel;

- (void)persistSetup;

@end

@implementation FactorySetupController

@synthesize stationCount;
@synthesize inventorySizeSlider;
@synthesize inventorySizeLabel;
@synthesize inventorySize;
@synthesize pickerView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    values = [[NSMutableArray alloc] init];
    [values addObject:[NSNumber numberWithInteger:1]];
    [values addObject:[NSNumber numberWithInteger:2]];
    [values addObject:[NSNumber numberWithInteger:3]];
    [values addObject:[NSNumber numberWithInteger:4]];
    [values addObject:[NSNumber numberWithInteger:5]];
    [values addObject:[NSNumber numberWithInteger:6]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 6;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[values objectAtIndex:row] stringValue];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.stationCount = [[values objectAtIndex:row] integerValue];
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
    [self setPickerView:nil];
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

- (void)persistSetup 
{
    [self captureInventorySize];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    [prefs setInteger:self.stationCount forKey:@"stationCount"];
    [prefs setInteger:self.inventorySize forKey:@"inventorySize"];

    [prefs synchronize];
}
@end

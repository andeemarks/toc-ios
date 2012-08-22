//
//  ProductionLineFirstViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FactorySetupController.h"

@interface FactorySetupController ()
@property (weak, nonatomic) IBOutlet UIPickerView *stationCountPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *inventorySizePicker;

- (void)persistSetup;

@end

@implementation FactorySetupController
@synthesize stationCountPicker;
@synthesize inventorySizePicker;

@synthesize stationCount;
@synthesize inventorySize;

static int stationCountValues[8] = {1, 2, 3, 4, 5, 6, 7, 8 };
static int inventorySizeValues[6] = {25, 50, 75, 100, 125, 150};
        
- (void)initStationCountPicker
{
    [self.stationCountPicker selectRow:2 inComponent:0 animated:NO];
    self.stationCount = 3;
}

- (void)initInventorySizePicker
{
    [self.inventorySizePicker selectRow:2 inComponent:0 animated:NO];
    self.inventorySize = 75;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initStationCountPicker];
    [self initInventorySizePicker];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: stationCountPicker]) {
        return 8;
    }
    
    return 6;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual: stationCountPicker]) {
        return [NSString stringWithFormat: @"%d", stationCountValues[row]];
    }
    
    return [NSString stringWithFormat: @"%d", inventorySizeValues[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([pickerView isEqual: stationCountPicker]) {
        self.stationCount = stationCountValues[row];
    } else {
        self.inventorySize = inventorySizeValues[row];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self persistSetup];
}

- (void)viewDidUnload
{
    [self setInventorySizePicker:nil];
    [self setStationCountPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)persistSetup 
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];

    [prefs setInteger:stationCount forKey:@"stationCount"];
    [prefs setInteger:inventorySize forKey:@"inventorySize"];

    [prefs synchronize];
}
@end

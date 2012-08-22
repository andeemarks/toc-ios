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

- (void)initStationCountPicker
{
	// Do any additional setup after loading the view, typically from a nib.
    stationCountValues = [[NSMutableArray alloc] initWithCapacity: 8];
    for ( int i = 1 ; i <= 6 ; i ++ ) {
        [stationCountValues addObject:[NSNumber numberWithInt:i]];
    }
    
    [self.stationCountPicker selectRow:2 inComponent:0 animated:NO];
    self.stationCount = 3;
}

- (void)initInventorySizePicker
{
	// Do any additional setup after loading the view, typically from a nib.
    inventorySizeValues = [[NSMutableArray alloc] initWithCapacity: 6];
    for ( int i = 25 ; i <= 150 ; i = i + 25 ) {
        [inventorySizeValues addObject:[NSNumber numberWithInt:i]];
    }
    
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
        return stationCountValues.count;
    }
    
    return inventorySizeValues.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual: stationCountPicker]) {
        return [[stationCountValues objectAtIndex:row] stringValue];
    }
    
    return [[inventorySizeValues objectAtIndex:row] stringValue];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if ([pickerView isEqual: stationCountPicker]) {
        self.stationCount = [[stationCountValues objectAtIndex:row] integerValue];
    }
    
    self.inventorySize = [[inventorySizeValues objectAtIndex:row] integerValue];
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

    [prefs setInteger:self.stationCount forKey:@"stationCount"];
    [prefs setInteger:self.inventorySize forKey:@"inventorySize"];

    [prefs synchronize];
}
@end

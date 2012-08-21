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
    stationCountValues = [[NSMutableArray alloc] init];
    [stationCountValues addObject:[NSNumber numberWithInteger:1]];
    [stationCountValues addObject:[NSNumber numberWithInteger:2]];
    [stationCountValues addObject:[NSNumber numberWithInteger:3]];
    [stationCountValues addObject:[NSNumber numberWithInteger:4]];
    [stationCountValues addObject:[NSNumber numberWithInteger:5]];
    [stationCountValues addObject:[NSNumber numberWithInteger:6]];
    
    [self.stationCountPicker selectRow:2 inComponent:0 animated:NO];
    self.stationCount = 3;
}

- (void)initInventorySizePicker
{
	// Do any additional setup after loading the view, typically from a nib.
    inventorySizeValues = [[NSMutableArray alloc] init];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:25]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:50]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:75]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:100]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:125]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:150]];
    
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
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Factory setup has changed" 
//                                                    message:@"Do you want to reset the factory floor to match the setup?" 
//                                                   delegate:self 
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:@"Cancel", nil];
//    [alert show];
    
    [self persistSetup];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
	
	if([title isEqualToString:@"OK"])
	{
		NSLog(@"Button 1 was selected.");
	}
	else if([title isEqualToString:@"Cancel"])
	{
		NSLog(@"Button 2 was selected.");
	}
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

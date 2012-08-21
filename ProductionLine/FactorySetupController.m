//
//  ProductionLineFirstViewController.m
//  ProductionLine
//
//  Created by Andrew Marks on 16/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FactorySetupController.h"

@interface FactorySetupController ()
@property (weak, nonatomic) IBOutlet UIPickerView *inventorySizePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *stationCountPicker;

- (void)persistSetup;

@end

@implementation FactorySetupController

@synthesize stationCount;
@synthesize inventorySize;
@synthesize inventorySizePicker;
@synthesize stationCountPicker;

- (void)initStationCountPicker
{
	// Do any additional setup after loading the view, typically from a nib.
    stationCountValues = [[NSMutableArray alloc] init];
    [stationCountValues addObject:[NSNumber numberWithInteger:25]];
    [stationCountValues addObject:[NSNumber numberWithInteger:50]];
    [stationCountValues addObject:[NSNumber numberWithInteger:75]];
    [stationCountValues addObject:[NSNumber numberWithInteger:100]];
    [stationCountValues addObject:[NSNumber numberWithInteger:125]];
    [stationCountValues addObject:[NSNumber numberWithInteger:150]];
    
    [self.stationCountPicker selectRow:2 inComponent:0 animated:NO];
    self.stationCount = 3;
}

- (void)initInventorySizePicker
{
	// Do any additional setup after loading the view, typically from a nib.
    inventorySizeValues = [[NSMutableArray alloc] init];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:1]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:2]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:3]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:4]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:5]];
    [inventorySizeValues addObject:[NSNumber numberWithInteger:6]];
    
    [self.inventorySizePicker selectRow:2 inComponent:0 animated:NO];
    self.inventorySize = 3;
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
    return 6;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[stationCountValues objectAtIndex:row] stringValue];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.stationCount = [[stationCountValues objectAtIndex:row] integerValue];
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

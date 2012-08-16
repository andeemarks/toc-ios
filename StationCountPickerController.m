//
//  StationCountPickerController.m
//  ProductionLine
//
//  Created by Andy Marks on 16/8/12.
//  Copyright (c) 2012 amarks@thoughtworks.com. All rights reserved.
//

#import "StationCountPickerController.h"

@interface StationCountPickerController ()

@end

@implementation StationCountPickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    values = [[NSMutableArray alloc] init];
    [values addObject:@"1"];
    [values addObject:@"2"];
    [values addObject:@"3"];
    [values addObject:@"4"];
    [values addObject:@"5"];
    [values addObject:@"6"];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [values objectAtIndex:row];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

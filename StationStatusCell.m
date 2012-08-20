//
//  StationStatusCell.m
//  ProductionLine
//
//  Created by Andy Marks on 20/8/12.
//  Copyright (c) 2012 amarks@thoughtworks.com. All rights reserved.
//

#import "StationStatusCell.h"

@implementation StationStatusCell

@synthesize number;
@synthesize score;
@synthesize size;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
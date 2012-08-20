//
//  StationStatusCell.h
//  ProductionLine
//
//  Created by Andy Marks on 20/8/12.
//  Copyright (c) 2012 amarks@thoughtworks.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationStatusCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *number;
@property (strong, nonatomic) IBOutlet UILabel *size;
@property (strong, nonatomic) IBOutlet UILabel *score;


@end

//
// Created by amarks on 10/9/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "StationStatusHeaderView.h"


@implementation StationStatusHeaderView


- (void) addLabel: (NSString *) text startingAtXPos: (NSInteger) startXPos {
    UILabel *label = [[UILabel alloc]
            initWithFrame:CGRectMake(startXPos, 0, 200, self.frame.size.height)];

    label.text = text;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont fontWithName:@"Helvetica" size: 12.0];

    [self addSubview:label];
}

- (id)initWithWidth: (int) width {
    self = [super initWithFrame:CGRectMake(0, 0, width, 20)];
    if (self) {
        [self addLabel:@"#" startingAtXPos:0];
        [self addLabel:@"Roll" startingAtXPos:130];
        [self addLabel:@"Size" startingAtXPos:15];
        [self addLabel:@"Score" startingAtXPos:230];
        [self addLabel:@"Changes" startingAtXPos:160];
    }

    return self;
}


@end
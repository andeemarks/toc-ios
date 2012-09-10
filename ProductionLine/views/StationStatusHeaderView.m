//
// Created by amarks on 10/9/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "StationStatusHeaderView.h"

@implementation StationStatusHeaderView


- (void) addLabel: (NSString *) text startingAtXPos: (NSInteger) startXPos {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(startXPos, 0, 200, [StationStatusHeaderView HEIGHT])];

    label.text = text;
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont fontWithName:@"Helvetica" size: 12.0];

    [self addSubview:label];
}

- (id)initWithWidth: (int) width {
    DLog(@"Header width %d", width);
    self = [super initWithFrame:CGRectMake(0, 0, width, [StationStatusHeaderView HEIGHT])];
    if (self) {
        [self addLabel:@"#" startingAtXPos:0];
        [self addLabel:@"Size" startingAtXPos:15];
        [self addLabel:@"Roll" startingAtXPos:130];
        [self addLabel:@"Changes" startingAtXPos:160];
        [self addLabel:@"Score" startingAtXPos:230];
    }

    return self;
}

+ (int)HEIGHT {
    return 20;
}

@end
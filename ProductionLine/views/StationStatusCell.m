#import "StationStatusCell.h"
#import "Station.h"

@implementation StationStatusCell

@synthesize number;
@synthesize score;
@synthesize changes;
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

-(void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(ctx, 0.0, 0.0, 1.0, 1.0);
    CGContextFillRect(ctx, CGRectMake(15, 0, size.text.floatValue, 20));
}

- (void)updateFromStation:(Station *)station previousStation:(Station *)previousStation {
    self.number.text = [NSString stringWithFormat: @"%d", [station number]];
    self.size.text =   [NSString stringWithFormat: @"%d", [station size]];
    self.score.text =  [NSString stringWithFormat: @"%.1f", [station score]];
    self.changes.text =[station recentChanges];

    UIImageView *imv = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 20, 20)];
    imv.image = [UIImage imageNamed:[NSString stringWithFormat: @"Dice%d.png", [previousStation dice]]];
    [self.contentView addSubview:imv];

}
@end
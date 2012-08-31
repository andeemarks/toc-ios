#import "FlashMessageView.h"

@implementation FlashMessageView

- (id)initWithMessage:(NSString *)message dismissAfter:(NSTimeInterval)interval
{
    if ((self = [super initWithTitle: @"Notice!" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles:nil, nil]))
    {
        [self performSelector:@selector(dismissAfterDelay) withObject:nil afterDelay:interval];
    }
    return self;
}

- (void)dismissAfterDelay
{
    [self dismissWithClickedButtonIndex:0 animated:YES]; 
}

@end

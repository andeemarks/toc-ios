#import <UIKit/UIKit.h>

@interface FlashMessageView : UIAlertView

- (id)initWithMessage:(NSString *)message dismissAfter:(NSTimeInterval)interval;

@end

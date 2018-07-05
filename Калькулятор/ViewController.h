#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *Field_Expression;
@property (weak) IBOutlet NSTextField *Field_Result;
@end

@interface HistoryViewController : NSViewController
@property (unsafe_unretained) IBOutlet NSTextView *HistoryView;
@end

#import <Foundation/Foundation.h>

@interface Stack : NSObject{
    @private
        NSMutableArray* stack;
}
-(void)push:(NSString*_Nullable)str;
-(NSString*_Nullable)pop;
-(int)count;
-(NSString*_Nullable)view:(NSUInteger)index;
@end

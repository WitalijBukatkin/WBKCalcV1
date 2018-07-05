#import "Stack.h"

@implementation Stack

-(void)push:(NSString*)str{
    if([stack count]==0) stack=[[NSMutableArray alloc] init];
    [stack addObject:str];
}

-(NSString*)pop{
    if([stack count]==0) return @"";
    NSString *temp=stack[[stack count]-1];
    [stack removeObjectAtIndex:[stack count]-1];
    return temp;
}

-(int)count{
    return (int)[stack count];
}

-(NSString*)view:(NSUInteger)index{
    if([stack count]==0) return 0;
    if(index>=[stack count]) return 0;
    return stack[[stack count]-index-1];
}

@end

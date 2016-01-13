#import <Foundation/Foundation.h>

@interface LCHQueue : NSObject
@property (nonatomic, readonly) NSArray *items;

- (void)enqueue:(id)object;
- (id)dequeue;

@end

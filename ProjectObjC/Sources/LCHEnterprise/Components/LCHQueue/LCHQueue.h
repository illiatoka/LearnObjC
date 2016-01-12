#import "LCHContainer.h"

@interface LCHQueue : LCHContainer

- (void)enqueue:(id)object;
- (id)dequeue;

@end

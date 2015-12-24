#import "LCHContainer.h"

@interface LCHQueue : LCHContainer

- (void)addToQueue:(id)object;
- (id)nextObjectFromQueue;

@end

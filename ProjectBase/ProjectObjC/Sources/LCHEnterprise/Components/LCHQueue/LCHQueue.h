#import <Foundation/Foundation.h>

@interface LCHQueue : NSObject

- (void)enqueue:(id)object;
- (id)dequeue;

@end

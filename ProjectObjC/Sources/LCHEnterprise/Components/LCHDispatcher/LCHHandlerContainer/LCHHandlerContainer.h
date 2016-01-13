#import <Foundation/Foundation.h>

@interface LCHHandlerContainer : NSObject
@property (nonatomic, readonly) NSArray *handlers;

- (id)reserveHandler;

- (void)addHandler:(id)handler;
- (void)removeHandler:(id)handler;

@end

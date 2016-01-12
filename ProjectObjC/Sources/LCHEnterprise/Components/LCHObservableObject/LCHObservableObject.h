#import <Foundation/Foundation.h>
#import "LCHObserverProtocol.h"

@interface LCHObservable : NSObject <LCHObserverProtocol>
@property (nonatomic, readonly) NSArray     *observers;
@property (nonatomic)           NSUInteger  state;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (BOOL)containsObserver:(id)observer;

- (void)notifyWithSelector:(SEL)selector;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object withObject:(id)object2;

- (SEL)selectorForState:(NSUInteger)state;

@end

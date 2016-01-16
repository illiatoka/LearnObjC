#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@interface LCHObservableObject : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, readonly) NSArray     *observers;
@property (nonatomic, assign)   NSUInteger  state;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)addObserversFromArray:(NSArray *)array;
- (void)removeObserversFromArray:(NSArray *)array;

- (BOOL)containsObserver:(id)observer;

- (void)notifyWithSelector:(SEL)selector;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object;

// This method should be overridden in subclass
- (SEL)selectorForState:(NSUInteger)state;

@end

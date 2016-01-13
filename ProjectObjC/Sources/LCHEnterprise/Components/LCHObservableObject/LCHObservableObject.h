#import <Foundation/Foundation.h>
#import "LCHEmployeeObserverProtocol.h"

@interface LCHObservableObject : NSObject <LCHEmployeeObserverProtocol>
@property (nonatomic, readonly) NSArray     *observers;
@property (nonatomic)           NSUInteger  state;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)addObserversFromArray:(NSArray *)array;
- (void)removeObserversFromArray:(NSArray *)array;

- (BOOL)containsObserver:(id)observer;

- (void)notifyWithSelector:(SEL)selector;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object;

- (void)setState:(NSUInteger)state withObject:(id)object;

- (SEL)selectorForState:(NSUInteger)state;

@end

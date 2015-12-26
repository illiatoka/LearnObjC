#import <Foundation/Foundation.h>

@interface LCHObservable : NSObject
@property (nonatomic, readonly) NSArray *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)notifyWithSelector:(SEL)selector;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object withObject:(id)object2;

- (BOOL)containsObserver:(id)observer;

@end

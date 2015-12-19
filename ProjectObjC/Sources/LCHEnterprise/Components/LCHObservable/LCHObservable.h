#import <Foundation/Foundation.h>

@interface LCHObservable : NSObject
@property (nonatomic, readonly) NSArray *observers;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)notifyWithSelector:(SEL)selector;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object;

- (BOOL)containsObserver:(id)observer;

@end

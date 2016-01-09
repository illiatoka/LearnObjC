#import <Foundation/Foundation.h>
#import "LCHObserverProtocol.h"

typedef NS_ENUM(NSUInteger, LCHObjectState) {
    kLCHObjectProcessed,
    kLCHObjectFinished,
    kLCHObjectIsFree
};

@interface LCHObservable : NSObject <LCHObserverProtocol>
@property (nonatomic, readonly) NSArray         *observers;
@property (nonatomic, assign)   LCHObjectState  state;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)notifyWithSelector:(SEL)selector;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object withObject:(id)object2;

- (SEL)selectorForState:(LCHObjectState)state;

- (BOOL)containsObserver:(id)observer;

@end

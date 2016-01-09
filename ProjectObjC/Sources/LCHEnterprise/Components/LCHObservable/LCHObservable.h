#import <Foundation/Foundation.h>
#import "LCHObserverProtocol.h"

typedef NS_ENUM(NSUInteger, LCHEmployeeState) {
    kLCHEmployeeIsWorking,
    kLCHEmployeeIsFinished,
    kLCHEmployeeIsFree
};

@interface LCHObservable : NSObject <LCHObserverProtocol>
@property (nonatomic, readonly) NSArray             *observers;
@property (nonatomic, assign)   LCHEmployeeState    state;

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

- (void)notifyWithSelector:(SEL)selector;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object;
- (void)notifyWithSelector:(SEL)selector withObject:(id)object withObject:(id)object2;

- (SEL)selectorForState:(LCHEmployeeState)state;

- (BOOL)containsObserver:(id)observer;

@end

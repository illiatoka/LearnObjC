#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PUSingleArrayModelAction) {
    PUSingleArrayModelActionStart = 0,
    PUArrayModelActionInsert,
    PUArrayModelActionRemove,
    PUArrayModelActionReplace,
    PUSingleArrayModelActionEnd
};

@interface PUArraySingleIndexChangeModel : NSObject
@property (nonatomic, readonly) NSUInteger  modelAction;
@property (nonatomic, readonly) NSUInteger  index;

+ (instancetype)changeModelWithAction:(NSUInteger)action index:(NSUInteger)index;

- (instancetype)initWithAction:(NSUInteger)action index:(NSUInteger)index;

@end

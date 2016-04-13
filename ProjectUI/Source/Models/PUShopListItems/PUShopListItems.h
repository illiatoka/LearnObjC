#import "PUArrayModel.h"

typedef void(^PUVoidBlock)(void);

@interface PUShopListItems : PUArrayModel
@property (nonatomic, readonly, getter=isCached)    BOOL    cached;

- (void)save;

@end

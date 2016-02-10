#import <UIKit/UIKit.h>

#import "PUObservableObject.h"
#import "PUFoodListItemObserverProtocol.h"

@interface PUFoodListItem : PUObservableObject <PUFoodListItemObserverProtocol>
@property (nonatomic, strong)   NSString    *foodName;

@property (nonatomic, getter=isChecked) BOOL    checked;

- (instancetype)initWithFoodName:(NSString *)foodName;

@end

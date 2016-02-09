#import <Foundation/Foundation.h>

@interface PUListItem : NSObject
@property (nonatomic, strong)           NSString    *itemText;
@property (nonatomic, getter=isChecked) BOOL        checked;

@end

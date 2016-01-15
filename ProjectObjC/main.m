#import <Foundation/Foundation.h>

#import "LCHController.h"
#import "LCHEnterprise.h"
#import "LCHCar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[LCHController controllerWithEnterprise:[LCHEnterprise object]] startWork];
        [[NSRunLoop mainRunLoop] run];
    }
    
    return 0;
}

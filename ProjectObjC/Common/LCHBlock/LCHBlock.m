#import "LCHBlock.h"

#pragma mark -
#pragma mark Publiс

void performSyncOnMainQueue(dispatch_block_t block) {
    dispatch_sync(dispatch_get_main_queue(), block);
}

void performAsyncOnMainQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_main_queue(), block);
}

void performSyncOnBackgroundQueue(dispatch_block_t block) {
     dispatch_sync(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), block);
}

void performAsyncOnBackgroundQueue(dispatch_block_t block) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), block);
}

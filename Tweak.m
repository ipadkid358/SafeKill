#import <Foundation/Foundation.h>
#import "SKNotificationKeys.h"

@interface FBSystemService : NSObject
+ (instancetype)sharedInstance;
- (void)exitAndRelaunch:(BOOL)shouldRelaunch;
@end

@interface FBSSystemService : NSObject
+ (instancetype)sharedService;
- (void)reboot;
- (void)shutdown;
@end

static __attribute__((constructor)) void safeKillSpringBoardServer() {
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    
    int respringRegToken;
    notify_register_dispatch(kRespringNotifyKey, &respringRegToken, main_queue, ^(int token) {
        [[FBSystemService sharedInstance] exitAndRelaunch:YES];
    });
    
    int rebootRegToken;
    notify_register_dispatch(kRebootNotifyKey, &rebootRegToken, main_queue, ^(int token) {
        [[FBSSystemService sharedService] reboot];
    });
    
    int shutdownRegToken;
    notify_register_dispatch(kShutdownNotifyKey, &shutdownRegToken, main_queue, ^(int token) {
        [[FBSSystemService sharedService] shutdown];
    });
}

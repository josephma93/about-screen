#import "AboutScreen.h"
#import <Cordova/CDV.h>

@implementation AboutScreen

- (void)getInfo:(CDVInvokedUrlCommand*)command
{
	CDVPluginResult* pluginResult = nil;
    
    // For reference, look at http://stackoverflow.com/questions/4779221/in-iphone-app-how-to-detect-the-screen-resolution-of-the-device
    
    // This returns the screen size in "points". ie 320x480 in iPhones
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    // To get the actual pixels, we need to multiply by the screen scale.
    float screenScale = 1;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        screenScale = [[UIScreen mainScreen] scale];
    }
    
    CGFloat screenWidth = screenBounds.size.width * screenScale;
    CGFloat screenHeight = screenBounds.size.height * screenScale;
    
    // http://stackoverflow.com/questions/3860305/get-ppi-of-iphone-ipad-ipod-touch-at-runtime
    float dpi;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        dpi = 132 * screenScale;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        dpi = 163 * screenScale;
    } else {
        dpi = 160 * screenScale;
    }
    
    float diagonal = sqrtf(screenWidth*screenWidth + screenHeight*screenHeight) / dpi;
    
    NSDictionary *info = @{ @"width" : [NSNumber numberWithFloat:screenWidth],
                            @"height" : [NSNumber numberWithFloat:screenHeight],
                            @"density" : [NSNumber numberWithFloat:dpi],
                            @"screenDiagonal" : [NSNumber numberWithFloat:diagonal]
                            };
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:info];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
#import <Foundation/Foundation.h>

// Apple's compiler-rt normally provides this for @available / __builtin_available
// checks. The Linux iOS toolchain does not link it, so supply the runtime check.
int __isOSVersionAtLeast(int major, int minor, int patch) {
    static NSOperatingSystemVersion version;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        version = NSProcessInfo.processInfo.operatingSystemVersion;
    });
    if (version.majorVersion != major) return version.majorVersion > major;
    if (version.minorVersion != minor) return version.minorVersion > minor;
    return version.patchVersion >= patch;
}

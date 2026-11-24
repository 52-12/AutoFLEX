FINALPACKAGE=1

ARCHS = arm64
TARGET = iphone:clang:latest:16.0
export THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = autoflex
FLEX_FILES := $(shell find src -type f -name "*.m" -o -name "*.mm" -o -name "*.c")

autoflex_FILES = Tweak.x $(FLEX_FILES)
autoflex_CFLAGS = -Isrc -fobjc-arc -Wno-deprecated-declarations -Wno-strict-prototypes -Wno-unsupported-availability-guard -Wno-unused-but-set-variable

autoflex_FRAMEWORKS = UIKit CoreGraphics QuartzCore ImageIO WebKit Security SceneKit AVFoundation UserNotifications
autoflex_LDFLAGS += -lz -lsqlite3

include $(THEOS_MAKE_PATH)/tweak.mk

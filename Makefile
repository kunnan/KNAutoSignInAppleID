THEOS_DEVICE_IP=usb2222	#5C9
TARGET = iphone:latest:8.0
ARCHS = armv7 arm64
THEOS=/opt/theos
THEOS_MAKE_PATH=$(THEOS)/makefiles

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = StoreSettingsController
StoreSettingsController_FILES = Tweak.xm KNHook.m

$(TWEAK_NAME)_CFLAGS += -Wno-error


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Preferences"

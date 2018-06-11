include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SafeKill
SafeKill_FILES = Tweak.m
SafeKill_PRIVATE_FRAMEWORKS = FrontBoard FrontBoardServices
SafeKill_CFLAGS = -fobjc-arc

TOOL_NAME = respring reboot shutdown
respring_FILES = respring.c
reboot_FILES = reboot.c
shutdown_FILES = shutdown.c

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := SuperBubbleQS
LOCAL_MODULE_PATH := $(TARGET_OUT)/descendant-overlays
LOCAL_IS_RUNTIME_RESOURCE_OVERLAY := true
LOCAL_SDK_PLATFORM := current
include $(BUILD_PACKAGE)
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE := SimpleCalculator
LOCAL_SRC_FILES := SimpleCalculator.apk
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := .apk
LOCAL_DEX_PREOPT := false
LOCAL_OVERRIDES_PACKAGES := ExactCalculator
include $(BUILD_PREBUILT)

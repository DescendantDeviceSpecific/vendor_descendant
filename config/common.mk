# Copyright (C) 2019 Descendant
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#Device Codename

DESCENDANT_DEVICE := $(subst descendant_,,$(TARGET_PRODUCT))

#Overlays

DEVICE_PACKAGE_OVERLAYS += vendor/descendant/overlays/common

#Prebuilts
include vendor/descendant/prebuilt/pre.mk

#Custom doze
PRODUCT_PACKAGES += \
    CustomDoze

#Weather client
PRODUCT_PACKAGES += \
    WeatherClient

#OTA
PRODUCT_PACKAGES += \
    DescendantOTA

#Fonts
PRODUCT_COPY_FILES += \
    vendor/descendant/fonts/Montserrat-Black.ttf:system/fonts/Roboto-Black.ttf \
    vendor/descendant/fonts/Montserrat-BlackItalic.ttf:system/fonts/Roboto-BlackItalic.ttf \
    vendor/descendant/fonts/Montserrat-Bold.ttf:system/fonts/Roboto-Bold.ttf \
    vendor/descendant/fonts/Montserrat-BoldItalic.ttf:system/fonts/Roboto-BoldItalic.ttf \
    vendor/descendant/fonts/Montserrat-ExtraBold.ttf:system/fonts/Roboto-ExtraBold.ttf \
    vendor/descendant/fonts/Montserrat-ExtraBoldItalic.ttf:system/fonts/Roboto-ExtraBoldItalic.ttf \
    vendor/descendant/fonts/Montserrat-ExtraLight.ttf:system/fonts/Roboto-ExtraLight.ttf \
    vendor/descendant/fonts/Montserrat-ExtraLightItalic.ttf:system/fonts/Roboto-ExtraLightItalic.ttf \
    vendor/descendant/fonts/Montserrat-Italic.ttf:system/fonts/Roboto-Italic.ttf \
    vendor/descendant/fonts/Montserrat-Light.ttf:system/fonts/Roboto-Light.ttf \
    vendor/descendant/fonts/Montserrat-LightItalic.ttf:system/fonts/Roboto-LightItalic.ttf \
    vendor/descendant/fonts/Montserrat-Medium.ttf:system/fonts/Roboto-Medium.ttf \
    vendor/descendant/fonts/Montserrat-MediumItalic.ttf:system/fonts/Roboto-MediumItalic.ttf \
    vendor/descendant/fonts/Montserrat-Regular.ttf:system/fonts/Roboto-Regular.ttf \
    vendor/descendant/fonts/Montserrat-SemiBold.ttf:system/fonts/Roboto-SemiBold.ttf \
    vendor/descendant/fonts/Montserrat-SemiBoldItalic.ttf:system/fonts/Roboto-SemiBoldItalic.ttf \
    vendor/descendant/fonts/Montserrat-Thin.ttf:system/fonts/Roboto-Thin.ttf \
    vendor/descendant/fonts/Montserrat-ThinItalic.ttf:system/fonts/Roboto-ThinItalic.ttf 

#Pixel Sysconfig
PRODUCT_COPY_FILES += \
     vendor/descendant/prebuilts/configs/pixel.xml:system/etc/sysconfig/pixel.xml

# whitelist packages for location providers not in system
PRODUCT_PROPERTY_OVERRIDES += \
    ro.services.whitelist.packagelist=com.google.android.gms

#Build themes 
include vendor/themes/common.mk

#Build sounds
include vendor/sounds/sounds.mk

#Include custom init
PRODUCT_COPY_FILES += \
    vendor/descendant/prebuilt/etc/init.descendant.rc:system/etc/init/init.descendant.rc

PRODUCT_BUILD_WPROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/descendant/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/descendant/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/descendant/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \
    vendor/descendant/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/descendant/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/descendant/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/descendant/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    keyguard.no_require_sim=true \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0 \
    ro.build.selinux=1 \
    ro.opa.eligible_device=true

# Disable Rescue Party
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.disable_rescue=true

# We modify several neverallows, so let the build proceed
ifneq ($(TARGET_BUILD_VARIANT),user)
    SELINUX_IGNORE_NEVERALLOWS := true
endif

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Versioning
include vendor/descendant/config/version.mk

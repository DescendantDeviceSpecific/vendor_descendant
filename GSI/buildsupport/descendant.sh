(cd patches && git pull phh android-9.0)
bash "apply-patch.sh" patches
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export BUILD_TYPE=OFFICIAL
. build/envsetup.sh

buildVariant() {
	lunch treble_arm64_avN
	make WITHOUT_CHECK_API=true BUILD_NUMBER=$rom_fp installclean
	make WITHOUT_CHECK_API=true BUILD_NUMBER=$rom_fp -j$jobs systemimage
	make WITHOUT_CHECK_API=true BUILD_NUMBER=$rom_fp vndk-test-sepolicy
}

buildVariant treble_arm64_avN-userdebug
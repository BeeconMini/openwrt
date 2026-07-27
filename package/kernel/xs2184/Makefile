include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=xs2184
PKG_VERSION:=0.0.1

PKG_SOURCE_URL=https://github.com/BeeconMini/beeconmini_drivers.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=main
PKG_SOURCE_BRANCH:=main

include $(INCLUDE_DIR)/package.mk

define KernelPackage/xs2184
  SECTION:=kernel
  CATEGORY:=Kernel modules
  SUBMENU:=Network Devices
  TITLE:=PSE xs2184 support
  DEPENDS:=+kmod-i2c-gpio
  FILES:= $(PKG_BUILD_DIR)/xs2184.ko
  AUTOLOAD:=$(call AutoProbe,xs2184)
endef

define Build/Compile
	if [ -f "$(PKG_BUILD_DIR)/seed_ac1/xs2184/$(LINUX_VERSION)/xs2184.ko" ]; then \
		$(CP) "$(PKG_BUILD_DIR)/seed_ac1/xs2184/$(LINUX_VERSION)/xs2184.ko" $(PKG_BUILD_DIR); \
	else \
		$(CP) "$(PKG_BUILD_DIR)/seed_ac1/xs2184/generic/xs2184.ko" $(PKG_BUILD_DIR); \
	fi
endef

$(eval $(call KernelPackage,xs2184))

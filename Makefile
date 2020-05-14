include $(TOPDIR)/rules.mk
 
PKG_NAME:=luci-app-serverstatus
LUCI_TITLE:=LuCI support for ServerStatus
LUCI_DEPENDS:=+luci
LUCI_PKGARCH:=all
PKG_VERSION=1.0
PKG_RELEASE:=1
 
include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
Change log
-----------

# v2.13.5+rev1
## (2018-07-10)

* Update the meta-resin submodule to version v2.13.5 [Florin]
* Update the resin-yocto-scripts submodule to 59ccd8558435ff6424827fb36ccb43b14650f4d4 (on master branch) [Florin]

# v2.12.7+rev1
## (2018-05-04)

* Update the meta-resin submodule to version v2.12.7 [Florin]
* Update the resin-yocto-scripts submodule to f7718efbbf53369aaacb7eb54e707ee8a5d4fc4b (on master branch) [Florin]

# v2.12.5+rev2
## (2018-03-27)

* Update the resin-yocto-scripts submodule to 9cecb1ca4d9d4713dd337148b7d04a17afdba772 (on master branch) [Florin]

# v2.12.5+rev1
## (2018-03-22)

* Update the meta-resin submodule to version v2.12.5 [Florin]
* Update the resin-yocto-scripts submodule to 51b8849e2a02d0d4e729bff24909d9746e0bf4c3 (on master branch) [Florin]

# v2.12.3+rev1
## (2018-03-20)

* Update the meta-resin submodule to version v2.12.3 [Florin]

# v2.12.1+rev1
## (2018-03-12)

* Update the meta-resin submodule to version v2.12.1 [Andrei]

# v2.10.1+rev1
## (2018-02-28)

* Update the meta-resin submodule to version v2.10.1 [Florin]
* Switch to Poky Rocko [Florin]
* Update the resin-yocto-scripts submodule to dc9dfe466e48d934e55fb20a05156886873b1ab1 (on master branch) [Florin]

# v2.9.7+rev2
## (2018-02-22)

* Zero-out the entire u-boot environment partition in case we need to re-write it [Florin]
* Copy various files to the edison's boot partition [Florin]
* Deploy the kernel in /resin-boot so we also update the kernel when doing hostapps update [Florin]

# v2.9.7+rev1
## (2018-02-02)

* Update the meta-resin submodule to version v2.9.7 [Florin]
* Add hostapp update hook that allows flashing the bootloader when doing host OS updates [Florin]
* Update the resin-yocto-scripts submodule to d209b8c9c797ebd52a0f5ce404ea2420c248724c (on master branch) [Florin]
* Update flashing instructions for Edison [Zach]
* Update meta-edison-bsp submodule to 1446040dadd82e2c87820ea3746628b43a84ee2e (on pyro branch) [Sebastian]

# v2.7.8+rev3
## (2018-01-03)

* Add bluez5-noinst-tools to the rootfs for having a functional bluetooth [Florin]
* Update the meta-edison-bsp submodule to f2740e29e74ebf5e4b0a07907db5cedcb673c9b5 (on pyro branch) [Florin]
* Do not let ModemManager take over ttyS* interfaces [Florin]
* Add support for FUSE [Florin]

# v2.7.8+rev2
## (2017-12-21)

* Updated layer meta-edison-bsp with patch to enable PWM channels 0,1,2,3 [Sebastian]

# v2.7.8+rev1
## (2017-11-17)

* Update the meta-resin submodule to version v2.7.8 [Florin]
* Update the resin-yocto-scripts submodule to c4db082fd2d5a3b4857035264c1e726962d7b826 (on master branch) [Florin]
* Switch to the Intel Edison BSP (pyro branch) which allows us to use kernel 4.13.0 [Florin]
* Switch to Yocto Pyro [Florin]
* Fix the FlashEdison.json file: remove unescaped newlines in strings [Alexis]

# v2.7.2+rev2
## (2017-10-10)

* Install in the rootfs the 99-resin-uboot hostapp hook needed for u-boot to switch the root partition when doing host OS updates [Florin]
* Create and write the empty ext4 filesystem image onto resin-rootB [Florin]
* Switch to using the hostapps enabled rootfs instead of the plain ext4 rootfs [Florin]

# v2.7.2+rev1
## (2017-10-05)

* Update the meta-resin submodule to version v2.7.2 [Florin]
* Update resin-yocto-scripts to HEAD of master branch [Florin]
* Update meta-rust to morty [Will]
* Include meta-rust layer [Will]
* Add meta-rust layer [Will]

# v2.4.2+rev1
## (2017-09-13)

* Update the meta-resin submodule to version v2.4.2 [Florin]
* Make NetworkManager generate stable random MAC addresses for SMSC9514 devices [Florin]

# v2.3.0+rev1
## (2017-08-17)

* Update the meta-resin submodule to version v2.3.0 [Florin]
* Use meta-resin-jethro for BBLAYERS_NON_REMOVABLE too in bblayers.conf.sample [Florin]
* Integrate the resin u-boot implementation [Theodor]

# v2.2.0+rev2
## (2017-08-01)

* Fix missing system-connections directory from the boot partition [Florin]

# v2.2.0+rev1
## (2017-07-28)

* Update the meta-resin submodule to version v2.2.0 [Florin]
* Update resin-yocto-scripts to HEAD of master branch [Florin]
* Enable SMSC95xx driver as module for being used by some ethernet over usb devices [Florin]

# v2.0.5+rev1
## (2017-06-02)

* Update the meta-resin submodule to version v2.0.5 [Andrei]

# v2.0.4+rev2
## (2017-05-31)

* Update resin-yocto-scripts to HEAD of master branch [Florin]

# v2.0.4+rev1
## (2017-05-25)

* Update the meta-resin submodule to version v2.0.4 [Florin]
* Update resin-yocto-scripts to HEAD of master branch [Florin]
* Copy example NetworkManager config file [Florin]
* Ensure flashall.sh has the +x permission on [Michal]
* Update poky and meta-openembedded submodules [Will]
* Disable NetworkManager random MAC address when scanning [Florin]
* Increase the boot partition's size to 40MB [Michal]
* Update the meta-edison-bsp submodule to the latest version [Michal]
* Fix append in busybox [Andrei]
* Mount the rootfs read-only [Michal]
* Increase size of the resin initramfs image from 8192K to 16384K to accommodate for size increase due to x86 arch [Florin]
* Switch to the kernel with the initramfs bundled in [Florin]
* Update the meta-resin submodule to version v2.0.0-rc3 [Florin]
* Update to kernel version 3.10.98 and fix aufs for this kernel version [Florin]
* Adapt to resin-image changes [Florin]

# v2.0.0-beta12.rev1
## (2017-02-27)

* Bump resin-yocto-scripts to current HEAD [Andrei]
* meta-resin: Bump to 2.0.0-beta12 [Andrei]
* Change rootfs partitions sizes to 308 MB each [Florin]

# v2.0.0-beta11.rev1
## (2017-02-15)

* Update meta-resin to v2.0.0-beta.11 [Andrei]

# v2.0.0-beta10.rev1
## (2017-02-14)

* Update meta-resin to v2.0.0-beta.10 [Andrei]

# v2.0.0-beta.9
## (2017-02-08)

* Update meta-resin to v2.0-beta.9 [Andrei]
* Downgrade kernel version to 3.10.17 to avoid messing with AUFS patched [Andrei]

# v2.0.0-beta.8
## (2017-01-27)

* Update meta-resin to v2.0-beta.8 [Andrei]
* Update resin-yocto-scripts to HEAD of the master branch [Florin]
* Change watchdog ping interval to 35 seconds [Florin]
* Update to kernel 3.10.98 [Florin]

# v2.0.0-beta.7
## (2016-12-05)

* Update meta-resin to v2.0-beta.7 [Florin]

# v2.0.0-beta.6
## (2016-12-05)

* Update meta-resin to v2.0-beta.6 [Andrei]

# v2.0.0-beta.5
## (2016-11-30)

* Update meta-resin to v2.0-beta.5 [Andrei]
* Fix kernel compile with CONFIG_IP6_NF_IPTABLES [Andrei]
* Move edison BSP repo to https://github.com/resin-os/meta-edison-bsp.git (also updated to HEAD of previous location) [Florin]

# v2.0.0-beta.3
## (2016-11-07)

* Update meta-resin to v2.0-beta.3 [Andrei]
* Cleanup docker-resin-supervisor-disk of unneeded variables [Andrei]
* Update resin-yocto-scripts to fix logging in container builds
* Remove obsolete openvpn 2.3.6 recipe from our layers and let bitbake use openvpn 2.3.7 from meta-openembedded [Florin]
* Change resin-boot and resin-conf sizes in accordance with our partitioning scheme [Florin]
* Change resin-conf from vfat to ext4 [Florin]

# v2.0.0-beta.1
## (2016-10-11)

* Update meta-resin to v2.0-beta.1 [Andrei]
* Add meta-filesystem as we need aufs-utils [Andrei]
* Add build support for resinos [Andrei]
* Provide hook to inject files in our boot partition and inject initial config.json file [Theodor]
* Update resin-yocto-script to include changes in our image types [Theodor]
* Replace the concept of a debug image with a development image [Theodor]
* Update meta-resin to include avahi [Florin]
* Update resin-yocto-scripts to include kernel headers handling as gzip [Florin]

# v1.16.1
## (2016-10-04)

* Move config.json to our first partition (i.e. resin-boot) [Theodor]

# v1.16.0
## (2016-09-27)

* Update meta-resin to v1.16 [Florin]

# v1.15.0
## (2016-09-24)

* Update meta-resin to v1.15 [Florin]

# v1.14.0
## (2016-09-23)

* Update meta-resin to v1.14 [Florin]

# v1.13.0
## (2016-09-23)

* Update meta-resin to v1.13 [Florin]

# v1.12.0
## (2016-09-21)

* Update meta-resin to v1.12 [Florin]
* Update resin-yocto-scripts to include resinhup upload to dockerhub [Florin]
* Update meta-resin [Florin]
* Change .coffee to introduce versioning (v1) [Florin]

# v1.11.0
## (2016-08-31)

* Update meta-resin to v1.11 [Florin]

# v1.10.0
## (2016-08-24)

* Update meta-resin to v1.10 [Florin]

# v1.9.0
## (2016-08-24)

* Update meta-resin to v1.9 [Florin]
* Update resin-yocto-scripts for including kernel modules headers deploy [Florin]
* Update yocto-resin-scripts for host nodejs detection improvements [Florin]

# v1.8.0
## (2016-08-02)

* Bump meta-resin to v1.8 [Andrei]
* Bump resin-device-types to include partial manifest support [Andrei]
* No more debug images in staging

# v1.7.0
## (2016-07-14)

* Update meta-resin to v1.7

# v1.6.0
## (2016-07-06)

* Update meta-resin to v1.6 [Florin]

# v1.5.0
## (2016-07-04)

* Update meta-resin to v1.5 [Florin]

# v1.5.0rc4
## (2016-06-29)

* Update meta-resin to include supervisor update to v1.11.6 [Florin]

# v1.5.0rc3
## (2016-06-29)

* Update meta-resin to include openvpn-resin.service refactoring [Florin]

# v1.5.0rc2
## (2016-06-28)

* Update meta-resin to include docker key.json fix [Florin]
* Update meta-resin to include flasher fixes [Florin]

# v1.4.0
## (2016-06-27)

* Update meta-resin to v1.4 [Florin]
* Update meta-resin to allow let error out [Florin]
* Update meta-resin to allow patching of kernel-modules-headers [Florin]
* Bump meta-resin to fix various issues [Andrei]
* Fix a small syntax error in meta-resin [Andrei]
* Fix automation fix for debug image [Andrei]
* Replace RESIN_STAGING_BUILD by DEBUG_IMAGE [Andrei]

# v1.3.0
## (2016-06-24)

* Update meta-resin to v1.3 [Andrei]
* Update meta-resin to include kernel modules compress support [Andrei]
* Replace SUPERVISOR_TAG by TARGET_TAG [Andrei]
* Custom docker images in connectable builds [Andrei]
* Bump meta-resin to include connectable builds [Andrei]
* Add support for optional supervisor image [Andrei]
* Update meta-resin to v1.2 [Andrei]
* Bump meta-resin to HEAD [Andrei]
* Fix btrfs skinny relocation bug [Florin]
* Bump yocto-resin-scripts to bring in improvements for in-docker builds [Andrei]
* Configure builds with RM_OLD_IMAGE [Theodor]
* Bump meta-resin to include switch from rce to docker [Andrei]
* Update to jethro dependent components and added needed fixes [Andrei]

# v1.1.1
## (2016-03-16)

* Switch to open edison bsp repository (git://sandbox.sakoman.com/meta-edison-bsp.git) [Florin]
* Fix supervisor tag configuration used with barys [Andrei]

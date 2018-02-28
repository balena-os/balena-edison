deviceTypesCommon = require '@resin.io/device-types/common'
{ networkOptions } = deviceTypesCommon

OSX_DFU_COREUTILS_USBUTILS = '''
	You need <a href="https://www.macports.org/">MacPorts</a> installed on your system.
	<br>
	Run the following to install <code>dfu-util</code>, <code>usbutils</code> and <code>coreutils</code>:
	<code>sudo port install dfu-util usbutils coreutils && sudo port activate dfu-util</code>
'''

UNPLUG = 'Unplug the Intel Edison board from your system.'

UNZIP = 'Unzip the downloaded Device OS file.'

OSX_LINUX_FLASH = '''
	Execute the following from the unzipped directory:
	<br>
	<code>sudo ./flashall.sh</code>
	<br>
	If you have trouble executing, you may need to modify the file permissions first:
	<br>
	<code>sudo chmod +x ./flashall.sh</code>
'''

PLUG = '''
	Plug the Intel Edison as per the instructions on your terminal.
	<br>
	You can check the progress of the provisioning on your terminal.
'''

WINDOWS_DRIVERS = 'Install Windows drivers for Edison from
	<a href="https://downloadmirror.intel.com/26993/eng/IntelEdisonDriverSetup1.2.1.exe">here</a>'

WINDOWS_FLASH = '''
	Open a terminal with administrative privileges and execute the following from the unzipped directory:
	<br>
	<code>flashall.bat</code>
'''

LINUX_DFU_COREUTILS = '''
	Install <code>dfu-util</code> and <code>coreutils</code> from your distributions repos. For example, for Ubuntu:
	<br>
	<code>apt-get install dfu-util coreutils</code>
'''

module.exports =
	version: 1
	slug: 'intel-edison'
	aliases: [ 'edison' ]
	name: 'Intel Edison'
	arch: 'i386'
	state: 'released'

	gettingStartedLink: 'http://docs.resin.io/#/pages/installing/gettingStarted-Edison.md'

	instructions:
		windows: [ WINDOWS_DRIVERS, UNPLUG, UNZIP, WINDOWS_FLASH, PLUG ]
		osx: [ OSX_DFU_COREUTILS_USBUTILS, UNPLUG, UNZIP, OSX_LINUX_FLASH, PLUG ]
		linux:  [ LINUX_DFU_COREUTILS, UNPLUG, UNZIP, OSX_LINUX_FLASH, PLUG ]

	yocto:
		machine: 'edison'
		image: 'resin-image'
		fstype: 'zip'
		version: 'yocto-rocko'
		deployArtifact: 'resin-edison'
		archive: true
		compressed: true

	options: [
		isGroup: true
		name: 'network'
		message: 'Network'
		options: [
			message: 'Network Type'
			name: 'network'
			type: 'list'
			choices: [ 'wifi' ]
			hidden: true
		,
			networkOptions.wifiSsid,
		,
			networkOptions.wifiKey
		]
	]

	configuration:
		config:
			image: 'resin-image-edison.hddimg'
			path: '/config.json'

	initialization:
		dependencies:
			osx: [
					name: 'greadlink'
					instructions: '''
						This utility is included in the `coreutils` package. Run:

							$ sudo port install coreutils

						Or with Homebrew:

							$ brew install coreutils
					'''
				,
					name: 'dfu-util'
					instructions: '''
						Install dfu-util by running:

							$ sudo port install dfu-util@0.7

						Or with Homebrew:

							$ brew install dfu-util
					'''
			]
			linux: [
					name: 'readlink'
					instructions: '''
						Install `coreutils` from your distribution repos. For example, for Ubuntu:

							$ sudo apt-get install coreutils
					'''
				,
					name: 'dfu-util'
					instructions: '''
						Install `dfu-util` from your distribution repos. For example, for Ubuntu:

							$ sudo apt-get install dfu-util
					'''
			]
			win32: [
				name: 'dfu-util'
				instructions: '''
					Install Windows drivers for Edison from:

						http://downloadmirror.intel.com/24909/eng/IntelEdisonDriverSetup1.2.1.exe
				'''
			]

		operations: [
			command: 'run-script'
			script: 'flashall.bat'
			when:
				os: 'win32'
		,
			command: 'run-script'
			script: 'flashall.sh'
			when:
				os: 'osx'
		,
			command: 'run-script'
			script: 'flashall.sh'
			when:
				os: 'linux'
		]

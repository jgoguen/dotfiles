#!/bin/sh
# vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0:

set -eux

os=$(command -p uname)
if [ x"${os}" != x"Darwin" ]; then
	exit 0
fi

set -eux

/usr/bin/defaults write -globalDomain AppleActionOnDoubleClick -string Minimize
/usr/bin/defaults write -globalDomain AppleEnableSwipeNavigateWithScrolls -bool true
/usr/bin/defaults write -globalDomain AppleFontSmoothing -int 1
/usr/bin/defaults write -globalDomain AppleICUForce24HourTime -bool false
/usr/bin/defaults write -globalDomain AppleKeyboardUIMode -int 3
/usr/bin/defaults write -globalDomain ApplePressAndHoldEnabled -bool false
/usr/bin/defaults write -globalDomain AppleWindowTabbingMode -string always
/usr/bin/defaults write -globalDomain CGFontRenderingFontSmoothingDisabled -bool false
/usr/bin/defaults write -globalDomain com.apple.mouse.tapBehavior -int 1
/usr/bin/defaults write -globalDomain InitialKeyRepeat -int 20
/usr/bin/defaults write -globalDomain KeyRepeat -int 10
/usr/bin/defaults write -globalDomain NSAutomaticDashSubstitutionEnabled -bool false
/usr/bin/defaults write -globalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
/usr/bin/defaults write -globalDomain NSAutomaticDashSubstitutionEnabled -bool true
/usr/bin/defaults write -globalDomain NSNavPanelExpandedStateForSaveMode -bool true
/usr/bin/defaults write -globalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
/usr/bin/defaults write -globalDomain NSScrollViewRubberbanding -bool true
/usr/bin/defaults write -globalDomain NSTextShowsControlCharacters -bool true
/usr/bin/defaults write -globalDomain NSWindowResizeTime -float 0.001
/usr/bin/defaults write -globalDomain PMPrintingExpandedStateForPrint -bool true
/usr/bin/defaults write -globalDomain PMPrintingExpandedStateForPrint2 -bool true
/usr/bin/defaults write -globalDomain WebKitDeveloperExtras -bool true

/usr/bin/defaults write com.apple.ActivityMonitor ShowCategory -int 100
/usr/bin/defaults write com.apple.ActivityMonitor SortColumn -string CPUUsage
/usr/bin/defaults write com.apple.ActivityMonitor SortDirection -int 0

/usr/bin/defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -int 1
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad Dragging -int 1
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -int 1
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -int 1
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -int 1
/usr/bin/defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -int 1
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 2
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -int 1
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -int 1
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -int 1
/usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3

/usr/bin/defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40

/usr/bin/defaults write com.apple.commerce AutoUpdate -bool true

/usr/bin/defaults write com.apple.controlstrip FullCustomized -array com.apple.system.group.brightness com.apple.system.group.keyboard-brightness com.apple.system.airplay com.apple.system.group.media com.apple.system.screen-lock com.apple.system.group.volume com.apple.system.siri
/usr/bin/defaults write com.apple.controlstrip MiniCustomized -array com.apple.system.brightness com.apple.system.volume com.apple.system.mute com.apple.system.screen-lock

/usr/bin/defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
/usr/bin/defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

/usr/bin/defaults write com.apple.dock autohide -bool false
/usr/bin/defaults write com.apple.dock autohide-delay -float 0
/usr/bin/defaults write com.apple.dock autohide-time-modifier -int 0
/usr/bin/defaults write com.apple.dock largesize -int 50
/usr/bin/defaults write com.apple.dock magnification -bool true
/usr/bin/defaults write com.apple.dock mru-spaces -bool false
/usr/bin/defaults write com.apple.dock orientation -string right
/usr/bin/defaults write com.apple.dock showAppExposeGestureEnabled -bool true
/usr/bin/defaults write com.apple.dock show-recents -bool false
/usr/bin/defaults write com.apple.dock tilesize -int 33
# wvous-bl-*: Bottom-left corner starts screensaver
/usr/bin/defaults write com.apple.dock wvous-bl-corner -int 13
/usr/bin/defaults write com.apple.dock wvous-bl-modifier -int 0

/usr/bin/defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
/usr/bin/defaults write com.apple.finder _FXSortFoldersFirst -bool true
/usr/bin/defaults write com.apple.finder FXArrangeGroupViewBy -string Name
/usr/bin/defaults write com.apple.finder FXPreferredGroupBy -string Name
/usr/bin/defaults write com.apple.finder FXPreferredViewStyle -string icnv
/usr/bin/defaults write com.apple.finder FXRemoveOldTrashItems -bool true
/usr/bin/defaults write com.apple.finder QLEnableTextSelection -bool true
/usr/bin/defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
/usr/bin/defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
/usr/bin/defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
/usr/bin/defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
/usr/bin/defaults write com.apple.finder ShowSidebar -bool true

/usr/bin/defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

/usr/bin/defaults write com.apple.menuextra.battery ShowPercent -string YES

/usr/bin/defaults write com.apple.menuextra.clock DateFormat -string 'EEE MMM d h:mm:ss'
/usr/bin/defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
/usr/bin/defaults write com.apple.menuextra.clock IsAnalog -bool false

/usr/bin/defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true

/usr/bin/defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
/usr/bin/defaults write com.apple.Safari IncludeDevelopMenu -bool true
/usr/bin/defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
/usr/bin/defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

/usr/bin/defaults write com.apple.screensaver askForPassword -int 1
/usr/bin/defaults write com.apple.screensaver askForPasswordDelay -int 0

/usr/bin/defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
/usr/bin/defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
/usr/bin/defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

/usr/bin/defaults write com.apple.Terminal SecureKeyboardEntry -bool true

/usr/bin/defaults write com.apple.TextEdit PlainTextEncoding -int 4
/usr/bin/defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
/usr/bin/defaults write com.apple.TextEdit RichText -int 0

/usr/bin/defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

/usr/bin/defaults write com.googlecode.iterm2 PromptOnQuit -bool false
/usr/bin/defaults write com.googlecode.iterm2 'Secure Input' -bool true

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Disable the sound effects on boot
/usr/bin/sudo /usr/sbin/nvram SystemAudioVolume=" "
/usr/bin/sudo /usr/sbin/nvram StartupMute=%01

# Set date format strings
/usr/bin/defaults write NSGlobalDomain AppleICUDateFormatStrings -dict 1 "y-MM-dd" 2 "d MMM y" 3 "d MMMM y" 4 "EEEE, d MMMM y"

# Never sleep
/usr/bin/sudo /usr/sbin/systemsetup -setcomputersleep never

# Disable remote events
/usr/bin/sudo /usr/sbin/systemsetup -setremoteappleevents off

# Restart automatically if the computer freezes
/usr/bin/sudo /usr/sbin/systemsetup -setrestartfreeze on

# Disable wake on network access
/usr/bin/sudo /usr/sbin/systemsetup -setwakeonnetworkaccess off

# Disable Sudden Motion Sensor (who doesn't have SSDs these days?!)
/usr/bin/sudo /usr/bin/pmset -a sms 0

# Enable lid wakeup
/usr/bin/sudo /usr/bin/pmset -a lidwake 1

# Disable machine sleep while charging
/usr/bin/sudo /usr/bin/pmset -c sleep 0

# Set machine sleep to 10 minutes on battery
/usr/bin/sudo /usr/bin/pmset -b sleep 10

# Set standby delay to 24 hours (default is 1 hour)
/usr/bin/sudo /usr/bin/pmset -a standbydelay 86400

# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
/usr/bin/sudo /usr/bin/pmset -a hibernatemode 3

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder
/usr/bin/chflags nohidden ~/Library

# Show the /Volumes folder
/usr/bin/sudo /usr/bin/chflags nohidden /Volumes

# Keep this at the end!
# Restart Finder and Dock
/usr/bin/killall Finder
/usr/bin/killall Dock

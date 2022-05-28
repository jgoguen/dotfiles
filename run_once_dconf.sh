#!/bin/sh
# vim: set noexpandtab tabstop=2 shiftwidth=2 autoindent:
# vim: set foldmarker=[[[,]]] foldmethod=marker foldlevel=0 nospell:

set -ux

os=$(command -p uname)
if [ x"${os}" != x"Linux" ]; then
	exit 0
fi

DCONF_BIN="$(command -pv dconf)"
if [ -z "${DCONF_BIN}" ]; then
	printf 'dconf not found, skipping dconf settings\n' >&2
	exit 0
fi

set -e

"${DCONF_BIN}" write /desktop/gnome/crypto/pgp/ascii-armor "true"
"${DCONF_BIN}" write /desktop/gnome/crypto/pgp/default-key "'A8B51F5E8032CCE4'"
"${DCONF_BIN}" write /desktop/gnome/crypto/pgp/encrypt-to-self "true"

"${DCONF_BIN}" write /org/cinnamon/enabled-applets "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:grouped-window-list@cinnamon.org:2', 'panel1:left:2:window-list@cinnamon.org:13', 'panel1:right:1:keyboard@cinnamon.org:3', 'panel1:right:2:systray@cinnamon.org:4', 'panel1:right:3:xapp-status@cinnamon.org:5', 'panel1:right:4:notifications@cinnamon.org:6', 'panel1:right:5:printers@cinnamon.org:7', 'panel1:right:6:removable-drives@cinnamon.org:8', 'panel1:right:7:network@cinnamon.org:9', 'panel1:right:8:power@cinnamon.org:10', 'panel1:right:9:calendar@cinnamon.org:11', 'panel1:right:10:sound@cinnamon.org:12']"

"${DCONF_BIN}" write /org/cinnamon/desktop/input-sources/sources "[('xkb', 'us'), ('ibus', 'typing-booster')]"
"${DCONF_BIN}" write /org/cinnamon/desktop/input-sources/xkb-options "['caps:escape', 'grp:win_space_toggle', 'terminate:ctrl_alt_bksp', 'compose:ralt']"

"${DCONF_BIN}" write /org/cinnamon/desktop/interface/clock-show-date "true"
"${DCONF_BIN}" write /org/cinnamon/desktop/interface/clock-show-seconds "true"
"${DCONF_BIN}" write /org/cinnamon/desktop/interface/gtk-im-module "'ibus'"

"${DCONF_BIN}" write /org/cinnamon/desktop/keybindings/looking-glass-keybinding "@as []"

"${DCONF_BIN}" write /org/cinnamon/desktop/keybindings/media-keys/area-screenshot "['<Shift><Alt>dollar']"
"${DCONF_BIN}" write /org/cinnamon/desktop/keybindings/media-keys/screensaver "['<Control><Alt>l', 'XF86ScreenSaver', '<Super>l']"
"${DCONF_BIN}" write /org/cinnamon/desktop/keybindings/media-keys/window-screenshot "['<Control><Shift><Alt>dollar']"

"${DCONF_BIN}" write /org/cinnamon/desktop/notifications/bottom-notifications "true"

"${DCONF_BIN}" write /org/cinnamon/desktop/sound/event-sounds "false"

"${DCONF_BIN}" write /org/cinnamon/settings-daemon/peripherals/mouse/natural-scroll "true"

"${DCONF_BIN}" write /org/cinnamon/settings-daemon/peripherals/touchpad/horizontal-scrolling "true"
"${DCONF_BIN}" write /org/cinnamon/settings-daemon/peripherals/touchpad/motion-threshold "1"
"${DCONF_BIN}" write /org/cinnamon/settings-daemon/peripherals/touchpad/scrolling-method "1"

"${DCONF_BIN}" write /org/cinnamon/settings-daemon/plugins/power/button-power "'nothing'"
"${DCONF_BIN}" write /org/cinnamon/settings-daemon/plugins/power/sleep-display-battery "300"
"${DCONF_BIN}" write /org/cinnamon/settings-daemon/plugins/power/sleep-inactive-ac-timeout "3600"
"${DCONF_BIN}" write /org/cinnamon/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
"${DCONF_BIN}" write /org/cinnamon/settings-daemon/plugins/power/sleep-inactive-battery-timeout "900"

"${DCONF_BIN}" write /org/cinnamon/settings-daemon/plugins/xsettings/hinting "'full'"

"${DCONF_BIN}" write /org/cinnamon/sounds/close-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/login-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/logout-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/map-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/maximize-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/minimize-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/notification-enabled "true"
"${DCONF_BIN}" write /org/cinnamon/sounds/switch-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/tile-enabled "false"
"${DCONF_BIN}" write /org/cinnamon/sounds/unmaximize-enabled "false"

"${DCONF_BIN}" write /org/freedesktop/ibus/engine/typing-booster/dictionary "'en_US,en_CA'"
"${DCONF_BIN}" write /org/freedesktop/ibus/engine/typing-booster/labeldictionary "true"
"${DCONF_BIN}" write /org/freedesktop/ibus/engine/typing-booster/labelspellcheck "true"
"${DCONF_BIN}" write /org/freedesktop/ibus/engine/typing-booster/labeluserdb "true"

"${DCONF_BIN}" write /org/gnome/desktop/input-sources/sources "[('xkb', 'us'), ('ibus', 'typing-booster')]"
"${DCONF_BIN}" write /org/gnome/desktop/input-sources/xkb-options "['caps:escape', 'grp:win_space_toggle', 'terminate:ctrl_alt_bksp', 'compose:ralt']"

"${DCONF_BIN}" write /org/gnome/desktop/interface/clock-show-seconds "true"
"${DCONF_BIN}" write /org/gnome/desktop/interface/clock-show-weekday "true"
"${DCONF_BIN}" write /org/gnome/desktop/interface/gtk-im-module "'ibus'"
"${DCONF_BIN}" write /org/gnome/desktop/interface/monospace-font-name "'Source Code Pro Medium 11'"
"${DCONF_BIN}" write /org/gnome/desktop/interface/show-battery-percentage "true"

"${DCONF_BIN}" write /org/gnome/desktop/peripherals/mouse/natural-scroll "true"

"${DCONF_BIN}" write /org/gnome/desktop/peripherals/touchpad/click-method "'fingers'"
"${DCONF_BIN}" write /org/gnome/desktop/peripherals/touchpad/tap-to-click "true"
"${DCONF_BIN}" write /org/gnome/desktop/peripherals/touchpad/two-finger-scrolling-enabled "true"

"${DCONF_BIN}" write /org/gnome/desktop/privacy/old-files-age "uint32 3"
"${DCONF_BIN}" write /org/gnome/desktop/privacy/remove-old-temp-files "true"
"${DCONF_BIN}" write /org/gnome/desktop/privacy/remove-old-trash-files "true"
"${DCONF_BIN}" write /org/gnome/desktop/privacy/report-technical-problems "true"

"${DCONF_BIN}" write /org/gnome/desktop/wm/keybindings/switch-applications "['<Super>Tab']"
"${DCONF_BIN}" write /org/gnome/desktop/wm/keybindings/switch-applications-backward "['<Shift><Super>Tab']"
"${DCONF_BIN}" write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"
"${DCONF_BIN}" write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Shift><Alt>Tab']"

"${DCONF_BIN}" write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"

"${DCONF_BIN}" write /org/gnome/gedit/preferences/editor/display-line-numbers "true"
"${DCONF_BIN}" write /org/gnome/gedit/preferences/editor/display-overview-map "false"
"${DCONF_BIN}" write /org/gnome/gedit/preferences/editor/highlight-current-line "true"
"${DCONF_BIN}" write /org/gnome/gedit/preferences/editor/scheme "'solarized-dark'"
"${DCONF_BIN}" write /org/gnome/gedit/preferences/editor/tabs-size "uint32 4"

"${DCONF_BIN}" write /org/gnome/mutter/experimental-features "['scale-monitor-framebuffer', 'x11-randr-fractional-scaling']"

"${DCONF_BIN}" write /org/gnome/seahorse/nautilus/armor-mode "true"

"${DCONF_BIN}" write /org/gnome/settings-daemon/peripherals/keyboard/numlock-state "'on'"

"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/color/night-light-enabled "true"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/color/night-light-schedule-automatic "true"

"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/media-keys/area-screenshot "'<Shift><Alt>dollar'"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/media-keys/window-screenshot "'<Control><Shift><Alt>dollar'"

"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/power/power-button-action "'nothing'"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-timeout "3600"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery "'suspend'"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-timeout "900"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-type "'suspend'"

"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/xsettings/antialiasing "'rgba'"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/xsettings/hinting "'full'"
"${DCONF_BIN}" write /org/gnome/settings-daemon/plugins/xsettings/overrides "{'Gtk/ShellShowsAppMenu': <0>}"

"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/appicon-margin "2"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/appicon-padding "1"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-1 "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-2 "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-3 "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-4 "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-1 "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-2= "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-3 "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-4 "'#5294e2'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/dot-style-unfocused "'DOTS'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/focus-highlight-color "'#eeeeee'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/hotkeys-overlay-combo "'TEMPORARILY'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/location-clock "'STATUSRIGHT'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/panel-position "'BOTTOM'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/panel-size "24"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/show-favorites "true"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/show-show-apps-button "false"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/show-showdesktop-button "false"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/stockgs-panelbtn-click-only "false"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/trans-dynamic-behavior "'FOCUSED_WINDOWS'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-opacity "true"
"${DCONF_BIN}" write /org/gnome/shell/extensions/dash-to-panel/trans-use-dynamic-opacity "true"

"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/compact-display "false"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/cpu-graph-width "50"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/cpu-iowait-color "'#ef2929ff'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/cpu-nice-color "'#edd400ff'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/cpu-refresh-time "1000"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/cpu-show-text "true"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/cpu-user-color "'#73d216ff'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/icon-display "false"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/memory-buffer-color "'#edd400ff'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/memory-cache-color "'#888a85ff'"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/memory-graph-width "50"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/net-graph-width "50"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/net-show-menu "true"
"${DCONF_BIN}" write /org/gnome/shell/extensions/system-monitor/show-tooltip "true"

"${DCONF_BIN}" write /org/gnome/shell/extensions/window-list/grouping-mode "'auto'"

"${DCONF_BIN}" write /org/gnome/shell/window-switcher/current-workspace-only "true"

"${DCONF_BIN}" write /system/locale/region "'en_US.UTF-8'"

GSETTINGS_BIN="$(command -pv gsettings)"
if [ -z "${GSETTINGS_BIN}" ]; then
	printf 'Could not find gsettings, skipping gsettings\n' >&2
	exit 0
fi

set +e
WEZTERM_BIN="$(command -v wezterm)"
if [ -n "${WEZTERM_BIN}" ]; then
	"${GSETTINGS_BIN}" set org.cinnamon.desktop.default-applications.terminal exec "${WEZTERM_BIN}"
	"${GSETTINGS_BIN}" set org.cinnamon.desktop.default-applications.terminal exec-arg '--'
	"${GSETTINGS_BIN}" set org.gnome.desktop.default-applications.terminal exec "${WEZTERM_BIN}"
	"${GSETTINGS_BIN}" set org.gnome.desktop.default-applications.terminal exec-arg ''
fi
set -e

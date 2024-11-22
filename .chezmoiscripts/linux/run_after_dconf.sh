#!/bin/sh
# vim: set filetype=sh:

set -eu

# shellcheck source=../../helpers.sh
. "${HOME}/.local/share/chezmoi/helpers.sh"

if ! command -v dconf >/dev/null 2>&1; then
	log "dconf not found, skipping dconf settings" "WARN"
	exit 0
fi

set -e

dconf write /desktop/gnome/crypto/pgp/ascii-armor "true"
dconf write /desktop/gnome/crypto/pgp/default-key "'A8B51F5E8032CCE4'"
dconf write /desktop/gnome/crypto/pgp/encrypt-to-self "true"

dconf write /org/freedesktop/ibus/engine/typing-booster/dictionary "'en_US,en_CA'"
dconf write /org/freedesktop/ibus/engine/typing-booster/labeldictionary "true"
dconf write /org/freedesktop/ibus/engine/typing-booster/labelspellcheck "true"
dconf write /org/freedesktop/ibus/engine/typing-booster/labeluserdb "true"

dconf write /org/gnome/desktop/input-sources/sources "[('xkb', 'us'), ('ibus', 'typing-booster')]"
dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape', 'grp:win_space_toggle', 'terminate:ctrl_alt_bksp', 'compose:ralt']"

dconf write /org/gnome/desktop/interface/clock-show-seconds "true"
dconf write /org/gnome/desktop/interface/clock-show-weekday "true"
dconf write /org/gnome/desktop/interface/gtk-im-module "'ibus'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'JetBrainsMono Nerd Font Mono 11'"
dconf write /org/gnome/desktop/interface/show-battery-percentage "true"

dconf write /org/gnome/desktop/peripherals/mouse/natural-scroll "true"

dconf write /org/gnome/desktop/peripherals/touchpad/click-method "'fingers'"
dconf write /org/gnome/desktop/peripherals/touchpad/tap-to-click "true"
dconf write /org/gnome/desktop/peripherals/touchpad/two-finger-scrolling-enabled "true"

dconf write /org/gnome/desktop/privacy/old-files-age "uint32 3"
dconf write /org/gnome/desktop/privacy/remove-old-temp-files "true"
dconf write /org/gnome/desktop/privacy/remove-old-trash-files "true"
dconf write /org/gnome/desktop/privacy/report-technical-problems "true"

dconf write /org/gnome/desktop/wm/keybindings/switch-applications "['<Super>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-applications-backward "['<Shift><Super>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Shift><Alt>Tab']"

dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"

dconf write /org/gnome/gedit/preferences/editor/display-line-numbers "true"
dconf write /org/gnome/gedit/preferences/editor/display-overview-map "false"
dconf write /org/gnome/gedit/preferences/editor/highlight-current-line "true"
dconf write /org/gnome/gedit/preferences/editor/scheme "'solarized-dark'"
dconf write /org/gnome/gedit/preferences/editor/tabs-size "uint32 4"

dconf write /org/gnome/mutter/experimental-features "['scale-monitor-framebuffer', 'x11-randr-fractional-scaling']"

dconf write /org/gnome/seahorse/nautilus/armor-mode "true"

dconf write /org/gnome/settings-daemon/peripherals/keyboard/numlock-state "'on'"

dconf write /org/gnome/settings-daemon/plugins/color/night-light-enabled "false"
dconf write /org/gnome/settings-daemon/plugins/color/night-light-schedule-automatic "true"

dconf write /org/gnome/settings-daemon/plugins/media-keys/area-screenshot "'<Shift><Alt>dollar'"
dconf write /org/gnome/settings-daemon/plugins/media-keys/window-screenshot "'<Control><Shift><Alt>dollar'"

dconf write /org/gnome/settings-daemon/plugins/power/power-button-action "'nothing'"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-timeout "3600"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery "'suspend'"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-timeout "600"
dconf write /org/gnome/settings-daemon/plugins/power/sleep-inactive-battery-type "'suspend'"

dconf write /org/gnome/settings-daemon/plugins/xsettings/antialiasing "'rgba'"
dconf write /org/gnome/settings-daemon/plugins/xsettings/hinting "'full'"
dconf write /org/gnome/settings-daemon/plugins/xsettings/overrides "{'Gtk/ShellShowsAppMenu': <0>}"

dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-margin "2"
dconf write /org/gnome/shell/extensions/dash-to-panel/appicon-padding "1"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-1 "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-2 "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-3 "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-4 "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-1 "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-2= "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-3 "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-color-unfocused-4 "'#5294e2'"
dconf write /org/gnome/shell/extensions/dash-to-panel/dot-style-unfocused "'DOTS'"
dconf write /org/gnome/shell/extensions/dash-to-panel/focus-highlight-color "'#eeeeee'"
dconf write /org/gnome/shell/extensions/dash-to-panel/hotkeys-overlay-combo "'TEMPORARILY'"
dconf write /org/gnome/shell/extensions/dash-to-panel/location-clock "'STATUSRIGHT'"
dconf write /org/gnome/shell/extensions/dash-to-panel/panel-position "'BOTTOM'"
dconf write /org/gnome/shell/extensions/dash-to-panel/panel-size "24"
dconf write /org/gnome/shell/extensions/dash-to-panel/show-favorites "true"
dconf write /org/gnome/shell/extensions/dash-to-panel/show-show-apps-button "false"
dconf write /org/gnome/shell/extensions/dash-to-panel/show-showdesktop-button "false"
dconf write /org/gnome/shell/extensions/dash-to-panel/stockgs-panelbtn-click-only "false"
dconf write /org/gnome/shell/extensions/dash-to-panel/trans-dynamic-behavior "'FOCUSED_WINDOWS'"
dconf write /org/gnome/shell/extensions/dash-to-panel/trans-use-custom-opacity "true"
dconf write /org/gnome/shell/extensions/dash-to-panel/trans-use-dynamic-opacity "true"

dconf write /org/gnome/shell/extensions/system-monitor/compact-display "false"
dconf write /org/gnome/shell/extensions/system-monitor/cpu-graph-width "50"
dconf write /org/gnome/shell/extensions/system-monitor/cpu-iowait-color "'#ef2929ff'"
dconf write /org/gnome/shell/extensions/system-monitor/cpu-nice-color "'#edd400ff'"
dconf write /org/gnome/shell/extensions/system-monitor/cpu-refresh-time "1000"
dconf write /org/gnome/shell/extensions/system-monitor/cpu-show-text "true"
dconf write /org/gnome/shell/extensions/system-monitor/cpu-user-color "'#73d216ff'"
dconf write /org/gnome/shell/extensions/system-monitor/icon-display "false"
dconf write /org/gnome/shell/extensions/system-monitor/memory-buffer-color "'#edd400ff'"
dconf write /org/gnome/shell/extensions/system-monitor/memory-cache-color "'#888a85ff'"
dconf write /org/gnome/shell/extensions/system-monitor/memory-graph-width "50"
dconf write /org/gnome/shell/extensions/system-monitor/net-graph-width "50"
dconf write /org/gnome/shell/extensions/system-monitor/net-show-menu "true"
dconf write /org/gnome/shell/extensions/system-monitor/show-tooltip "true"

dconf write /org/gnome/shell/extensions/window-list/grouping-mode "'auto'"

dconf write /org/gnome/shell/window-switcher/current-workspace-only "true"

dconf write /system/locale/region "'en_US.UTF-8'"

if ! command -v gsettings >/dev/null 2>&1; then
	log "Could not find gsettings, skipping gsettings" "WARN"
	exit 0
fi

if ! which wezterm >/dev/null 2>&1; then
	gsettings set org.gnome.desktop.default-applications.terminal exec "$(command -v wezterm)"
	gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''
fi

#!/bin/bash
dconf write /org/cinnamon/settings-daemon/plugins/power/button-hibernate "'nothing'"
dconf write /org/cinnamon/settings-daemon/plugins/power/button-power "'shutdown'"
dconf write /org/cinnamon/settings-daemon/plugins/power/button-suspend "'nothing'"
dconf write /org/cinnamon/settings-daemon/plugins/power/critical-battery-action "'shutdown'"
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-ac-action "'shutdown'"
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-battery-action "'shutdown'"
dconf write /org/cinnamon/settings-daemon/plugins/power/lid-close-suspend-with-external-monitor false
dconf write /org/cinnamon/settings-daemon/plugins/power/percentage-action 3
dconf write /org/cinnamon/settings-daemon/plugins/power/percentage-critical 4
dconf write /org/cinnamon/settings-daemon/plugins/power/percentage-low 10
dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-inactive-ac-type "'nothing'"
dconf write /org/cinnamon/settings-daemon/plugins/power/sleep-inactive-battery-type "'nothing'"

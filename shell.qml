import Quickshell
import Quickshell.Io
import QtQuick

import qs.bar
import qs.widgets.dashboard

Scope {
  id: root

  property var theme
  property var config
  property var configFile: "./config.json"
  property var scripts: "/scripts/"
  
  FileView {
    id: pywal
    path: Quickshell.env("HOME") + "/.cache/wal/colors.json"
    watchChanges: true
    onFileChanged: reload()
    Component.onCompleted: reload()
    onLoaded: {
      root.theme = JSON.parse(text())
    }
  }

  Process {
    id: weather
    running: true
    command: ["bash", Quickshell.shellDir + "/scripts/get_weather.sh"]
  }

  Timer {
    interval: 1800000
    running: true
    repeat: true
    onTriggered: {
      weather.running = true
    }
  }

  FileView {
    id: config
    path: Qt.resolvedUrl(configFile)
    watchChanges: true
    onFileChanged: reload()
    Component.onCompleted: reload()
    onLoaded: {
      root.config = JSON.parse(text())
    }
  }

  Bar { 
    id: bar
    theme: root.theme 
    font: root.config.bar.font
    alpha: root.config.bar.alpha 
    radius: root.config.bar.radius
  }

  DashboardWindow {
    font: root.config.dashboard.font
    alpha: root.config.dashboard.alpha
    spacing: root.config.dashboard.spacing
    radius: root.config.bar.radius
    theme: root.theme
    open: bar.dashboardTrigger
  }
}

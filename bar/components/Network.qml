import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
  id: root

  property var font
  property var iconColor
  property var fg

  implicitWidth: row.implicitWidth
  implicitHeight: row.implicitHeight
  
  property var currentSsid: "NC"
  property bool isConnected: false

  Timer {
    interval: 1000
    repeat: true
    running: true // Added running true so the timer actually ticks
    onTriggered: {
      // networking.checkConnectivity() // Optional, keep if needed elsewhere
      
      // This restarts the process loop to fetch the current SSID every second
      iwdCheck.running = false
      iwdCheck.running = true
    }
  }

  Process {
    id: iwdCheck
    // Fixed: Removed wrapping single quotes, fixed inner escaping
    command: ["sh", "-c", "iwctl station wlan0 show | grep 'Connected network' | sed -E 's/^.*Connected network\\s+//' | tr -d \"'\""]
    running: true
    
    stdout: StdioCollector {
      id: stdoutCollector
      onStreamFinished: {
        let ssid = stdoutCollector.text.trim();

        if (ssid.length > 0) {
          root.currentSsid = ssid;
          root.isConnected = true;
        } else {
          root.currentSsid = "NC";
          root.isConnected = false;
        }
      }
    }
  }

  RowLayout {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    
    Text {
      // Changed to use your local root.isConnected state
      text: root.isConnected ? "" : "  " 
      color: root.iconColor
      font {
        family: root.font
        pixelSize: 20
      }
    }

    Text {
      // Changed from Network.name to root.currentSsid to display your parsed value
      text: root.currentSsid
      color: root.fg
      font {
        family: root.font
        pixelSize: 16
      }
    }
  }

}

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
  id: root

  property var font
  property var fg
  property var color
  property var percentage

  implicitWidth: row.implicitWidth

  
  Process {
    id: process
    command: ["sh", "-c", "last=''; while true; do current=$(brightnessctl get); if [ \"$current\" != \"$last\" ]; then echo \"$current\"; last=\"$current\"; fi; sleep 0.5; done"]
    running: true

    stdout: SplitParser {
      onRead: data => {
          percentage = data.trim()
      }
    }
  }


  RowLayout {
    id: row
    anchors.verticalCenter: parent.verticalCenter
    Text {
      text: {
        if (percentage >= 100) return ""
        if (percentage >= 66) return ""
        if (percentage >= 33) return ""
      }
      color: root.color
      font {
        family: root.font
        pixelSize: 20
      }
    }
    Text {
      text: percentage + "%"
      color: fg
      font {
        family: root.font
        pixelSize: 16
      }
    }
  }
}

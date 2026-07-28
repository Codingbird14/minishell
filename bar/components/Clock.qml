import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  property var color
  property var font
  property var background

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
  Rectangle {
    ColumnLayout {
      anchors.verticalCenter: parent.verticalCenter
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: -2
      Text {  
        text: Qt.formatDateTime(clock.date, "h:mm AP")
        color: root.color
        font {
          family: root.font
          pixelSize: 17
          bold: true
        }
      }
      Text {  
        text: Qt.formatDateTime(clock.date, "dddd, MMMM d")
        color: root.color
        font {
          family: root.font
          pixelSize: 12
        }
      }
    }
  }
}

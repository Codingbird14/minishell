import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  
  property var color
  property var colorAlt
  property var font
  property var radius
  property var bg
  
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  Rectangle {
    width: 230
    height: 80
    color: root.bg
    radius: root.radius
    ColumnLayout {
      spacing: -3
      anchors.left: parent.left
      anchors.leftMargin: 10
      anchors.top: parent.top
      anchors.topMargin: 5
      Text {
        text: Qt.formatDateTime(clock.date, "h:mm:ss AP")
        color: root.color
        font {
          family: root.font
          pixelSize: 30
        }
      }
      Text {
        text: Qt.formatDateTime(clock.date, "dddd, MMMM d")
        color: root.colorAlt
        font {
          family: root.font
          pixelSize: 18
        }
      }
    }
  }
}

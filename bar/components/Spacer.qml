import Quickshell
import QtQuick

Item {
  id: root
  property var color
  property var font

  Text {
    text: "|"
    color: root.color
    font {
      family: font
      pixelSize: 20
    }
  }
}

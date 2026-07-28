import Quickshell
import QtQuick

Item {
  id: root
  property var font
  property var fg
  property var icon
  property bool open

  implicitWidth: text.implicitWidth
  implicitHeight: text.implicitHeight

  Text {
    id: text
    anchors.verticalCenter: parent.verticalCenter
    text: root.icon
    color: root.fg
    font {
      family: root.font
      pixelSize: 25
    }
  }

  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    
    onClicked: {
      root.open = true
    }
    onExited: {
      root.open = false
    }
  }
}

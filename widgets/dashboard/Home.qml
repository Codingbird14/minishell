import Quickshell
import QtQuick.Layouts
import QtQuick

import "components"

Item {
  id: root

  property var font
  property var radius
  property var theme
  property var spacing
  property var bg

  ColumnLayout {
    RowLayout {
      spacing: root.spacing
      anchors.left: parent.left
      anchors.leftMargin: 10
      anchors.top: parent.top
      anchors.topMargin: 10
      Clock {
        font: root.font
        color: theme.colors.color12
        colorAlt: theme.special.foreground
        radius: root.radius
        bg: root.bg
      }
    }
  } 
}

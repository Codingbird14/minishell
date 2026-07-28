import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
  id: root

  property var theme
  property var font
  property var alpha
  property var spacing: 15
  property var radius
  property bool open
  property bool visible: false
  property var bgAltLightness: 2
  property var background: Qt.alpha(theme.special.background, root.alpha)
  property var lightBg: Qt.lighter(theme.special.background, root.bgAltLightness)
  property var backgroundAlt: Qt.alpha(root.lightBg, root.alpha)

  PanelWindow {
    visible: {
      if (open) root.visible = true
      return root.visible
    }
    implicitWidth: 400 + root.spacing
    implicitHeight: 500 + root.spacing
    color: "transparent"

    anchors.bottom: true
    anchors.right: true
     
    exclusionMode: ExclusionMode.None

    Rectangle {
      anchors.fill: parent
      color: background

      anchors.rightMargin: root.spacing
      anchors.bottomMargin: root.spacing
      radius: root.radius
 
      Home {
        font: root.font
        radius: root.radius
        theme: root.theme
        bg: root.backgroundAlt 
        spacing: root.spacing
      }
    }
  }
}

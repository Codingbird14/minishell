import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick
  
import "components"

ShellRoot {
  id: root
 
  property var theme
  property real spacing: 10
  property real height: 40
  property real radius
  property real alpha
  property bool dashboardTrigger: dashboard.open
  property var preset: "nope"
  property var font   // : "Jetbrains Mono Nerd Font"
  property var background: Qt.alpha(theme.special.background, root.alpha)
  property var lightBackground: Qt.lighter(theme.special.background, 2.5)

  PanelWindow {
    anchors.left: true
    anchors.right: true 
    anchors.bottom: true

    implicitHeight: root.height + root.spacing
    color: "transparent"

    Rectangle {
      anchors.horizontalCenter: parent.horizontalCenter
      anchors.left: parent.left
      anchors.right: parent.right
      anchors.leftMargin: spacing
      anchors.rightMargin: spacing
      
      implicitHeight: parent.height - spacing

      radius: root.radius
      color: background 

      RowLayout {
        id: leftSection
        anchors.verticalCenter: parent.verticalCenter
        Workspaces {
          focusedcol: theme.colors.color10
          activecol: theme.special.foreground
          normalcol: theme.colors.color2
          focusedfg: theme.special.background
          font: root.font 
        }

        Weather {
          font: root.font
          color_list: theme.colors  
        }

        Mpris {
          radius: 5
          font: root.font
          fg: theme.special.foreground 
          sliderbg: lightBackground
          sliderfg: theme.colors.color9
        }

      } 
      


      RowLayout {
        id: centerSection
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        Clock {
          color: theme.special.foreground
          font: root.font
          background: background
        }

      }
      

      RowLayout {
        id: rightSection
        spacing: 20
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        Volume {
          font: root.font
          color: theme.colors.color12
          fg: theme.special.foreground
        }
        Brightness {
          font: root.font
          color: theme.colors.color9
          fg: theme.special.foreground
        }

        SysInfo {
          font: root.font
          cpuColor: theme.colors.color1
          ramColor: theme.colors.color3
          bg: lightBackground
        }

        Network {
          font: root.font
          fg: theme.special.foreground
          iconColor: theme.colors.color14
        }

        Dashboard {
          id: dashboard
          icon: ""
          font: root.font
          fg: theme.colors.color6
        }
      }
    }

  }
}

import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Item {
  id: root 
  property var activecol
  property var focusedfg
  property var focusedcol
  property var normalcol
  property var size: 23
  property var font
  property int activeWorkspaceId: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1
  property var activeWorkspacesList: Hyprland.workspaces.values

  Layout.leftMargin: 25
  implicitWidth: (size + 5) * 5 - 5
  RowLayout {
    anchors.verticalCenter: parent.verticalCenter 
    spacing: size + 5
    Repeater {
      model: [1, 2, 3, 4, 5]
      Item {
        id: element
        property bool workspaceExists: root.activeWorkspacesList.some(ws => ws.id === modelData)
        
        Rectangle {
          anchors.horizontalCenter: parent.horizontalCenter 
          anchors.verticalCenter: parent.verticalCenter 
          width: size
          height: size
          radius: 5
          color: root.activeWorkspaceId === modelData ? focusedcol : "transparent"
          
          Text {
            text: modelData
            color: root.activeWorkspaceId === modelData ? focusedfg: element.workspaceExists ? activecol : normalcol
            anchors.centerIn: parent
            font {
              family: root.font
              pixelSize: 16
            }
          }

        }
      }
    }
  }
}

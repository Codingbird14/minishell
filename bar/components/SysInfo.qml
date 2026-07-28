import Quickshell
import Quickshell.Io
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts 

Item {
  id: root

  property var font
  property var ramColor
  property var cpuColor
  property var cpuUsage
  property var ramUsage
  property var bg
  property var sliderWidth: 20

  implicitWidth: row.implicitWidth

  Process {
    id: cpuProcess
    command: ["sh", "-c", "top -bn2 -d 0.1 | grep \"%Cpu\" | tail -n 1 | awk '{print 100 - $8 }'"]
    running: true

    stdout: StdioCollector {
      id: cpuStdio
      onStreamFinished: {
        cpuUsage = cpuStdio.text.trim()
      }
    }
  }

  Process {
    id: ramProcess
    command: ["sh", "-c", "free | grep Mem | awk '{print $3/$2 * 100.0}'"]
    running: true

    stdout: StdioCollector {
      id: ramStdio
      onStreamFinished: {
        ramUsage = ramStdio.text.trim()
      }
    }
  }

  Timer {
    interval: 5000
    repeat: true
    running: true

    onTriggered: {
      cpuProcess.running = true
      ramProcess.running = true
      cpuProgress.value = cpuUsage || 0
    }
  }

  RowLayout {
    id: row
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    ColumnLayout {
      spacing: 3
      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: ""
        color: cpuColor
        font {
          family: root.font
          pixelSize: 18
        }
      }
      Slider {
        id: cpuProgress

        from: 0
        to: 100

        implicitWidth: sliderWidth
        implicitHeight: 3


        hoverEnabled: true

        value: cpuUsage || 0 

        Behavior on value {
          NumberAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
          }
        }

        background: Rectangle {
          x: cpuProgress.leftPadding
          y: cpuProgress.topPadding + (cpuProgress.availableHeight - height) / 2

          width: cpuProgress.availableWidth
          implicitHeight: 3
          radius: 5
 
          color: bg

          Rectangle {
            width: cpuProgress.visualPosition * parent.width
            height: parent.height
            radius: 5

            color: cpuColor
          }
        }

        handle: Rectangle {
          visible: false
        }
      }

    }
    ColumnLayout {
      spacing: 3
      Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: ""
        color: ramColor
        font {
          family: root.font
          pixelSize: 18
        }
      }
      Slider {
        id: ramProgress

        from: 0
        to: 100

        implicitWidth: sliderWidth
        implicitHeight: 3

        hoverEnabled: true

        value: ramUsage || 0 

        Behavior on value {
          NumberAnimation {
            duration: 300
            easing.type: Easing.InOutQuad
          }
        }

        background: Rectangle {
          x: ramProgress.leftPadding
          y: ramProgress.topPadding + (ramProgress.availableHeight - height) / 2

          width: ramProgress.availableWidth
          implicitHeight: 3
          radius: 5
 
          color: bg

          Rectangle {
            width: ramProgress.visualPosition * parent.width
            height: parent.height
            radius: 5

            color: ramColor
          }
        }

        handle: Rectangle {
          visible: false
        }
      }

    }
  }
}

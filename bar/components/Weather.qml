import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Item {
  id: root
  property var weather
  property var color_list
  property var font

  implicitWidth: description.width + 60
  FileView {
    path: Quickshell.env("HOME") + "/.cache/weather/weather1day.json"
    watchChanges: true
    onFileChanged: reload()
    Component.onCompleted: reload()
    onLoaded: {
      root.weather = JSON.parse(text())
      console.log(JSON.stringify(root.weather))
    }
  } 
  RowLayout {
    spacing: 10
    anchors.verticalCenter: parent.verticalCenter
    Text {
      text: weather.icon
      color: eval("color_list." + weather.color)
      font {
        family: root.font
        pixelSize: 25
      }
    }

    ColumnLayout {
      spacing: -3
      Text {
        id: description
        text: weather.des
        color: color_list.color15
        font {
          family: root.font
          pixelSize: 15
        }
      }
      Text {
        text: weather.temp
        color: color_list.color15
        font {
          family: root.font
          pixelSize: 12
        }
      }
    }
  }
}

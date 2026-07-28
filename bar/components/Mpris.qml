import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
  id: root

  property var font
  property var sliderbg
  property var sliderfg
  property var fg
  property var radius

  property MprisPlayer player: {
    let keys = Object.keys(Mpris.players.values);
    if (keys.length > 0)
      return Mpris.players.values[keys[0]];
    return null;
  }
  Timer {
    interval: 250
    running: true//player != null
    repeat: true

    onTriggered: {
      progress.value = player && player.length > 0
        ? player.length / player.position * 100
        : 0
    }
  }
  RowLayout {
    anchors.verticalCenter: parent.verticalCenter

    
  Rectangle {
    id: clippingWrapper
    implicitWidth: 30
    implicitHeight: 30
    radius: root.radius
    color: "transparent" // Ensures the wrapper background is transparent

    layer.enabled: true
    layer.smooth: true

    // Only active when a track and artwork URL exist
    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        visible: player && player.trackArtUrl
        source: {
            if (!player || !player.trackArtUrl) return "";
            return player.trackArtUrl.toString().replace("https://", "http://");
        }
    }

    // Active when nothing is playing or artwork is missing
    Text {
        anchors.centerIn: parent
        visible: !player || !player.trackArtUrl
        font.family: "Symbols Nerd Font" // Use your system's exact Nerd Font name
        font.pixelSize: 20
        color: theme.colors.color11
        text: ""   // Nerd Font music icon code (nf-fa-music)
    }
}


    ColumnLayout {
      Text {
        text: player ? player.trackTitle.length > 16 ? player.trackTitle.substring(0, 14) + ".." : player.trackTitle : "" || "Not Playing"
        color: root.fg

        font {
          family: root.font
          pixelSize: 15
        }
      }

      Slider {
        id: progress

        from: 0
        to: 100

        implicitWidth: 150
        implicitHeight: 4

        hoverEnabled: true

        value: player && player.length > 0
          ? (player.position / player.length) * 100
          : 0

        background: Rectangle {
          x: progress.leftPadding
          y: progress.topPadding + (progress.availableHeight - height) / 2

          width: progress.availableWidth
          implicitHeight: 3
          radius: 5
 
          color: root.sliderbg

          Rectangle {
            width: progress.visualPosition * parent.width
            height: parent.height
            radius: 5

            color: root.sliderfg
          }
        }

        handle: Rectangle {
          visible: false
        }
      }
    }
  }
}

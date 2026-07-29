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

  // Dynamically retrieve the active MPRIS player
  property MprisPlayer player: {
    let players = Mpris.players.values;
    return players.length > 0 ? players[0] : null;
  }

  // Trigger position updates every frame when music is playing
  FrameAnimation {
    running: root.player && root.player.playbackState === MprisPlaybackState.Playing
    onTriggered: {
      if (root.player) {
        root.player.positionChanged()
      }
    }
  }

  RowLayout {
    anchors.verticalCenter: parent.verticalCenter

    ClippingWrapperRectangle {
      id: clippingWrapper
      implicitWidth: 30
      implicitHeight: 30
      radius: root.radius
      color: "transparent"

      Item {
        implicitWidth: 30
        implicitHeight: 30

        Image {
          anchors.fill: parent
          fillMode: Image.PreserveAspectCrop
          visible: !!(root.player && root.player.trackArtUrl)
          source: {
            if (!root.player || !root.player.trackArtUrl) return "";
            return root.player.trackArtUrl.toString().replace("https://", "http://");
          }
        }

        Text {
          anchors.centerIn: parent
          visible: !root.player || !root.player.trackArtUrl
          font {
            family: root.font
            pixelSize: 20
          }
          color: theme.colors.color11
          text: ""
        }
      }
    }

    ColumnLayout {
      Text {
        text: {
          if (!root.player || !root.player.trackTitle) return "Not Playing";
          return root.player.trackTitle.length > 16 
            ? root.player.trackTitle.substring(0, 14) + ".." 
            : root.player.trackTitle;
        }
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

        // Clean reactive binding to position
        value: (root.player && root.player.length > 0)
          ? (root.player.position / root.player.length) * 100
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

import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.Appearance
Rectangle {
    id: power
    implicitHeight: 25
    implicitWidth: 25
    color: Colors.palette.surface_bright
    radius: Settings.widgetRadius + 10
    MouseArea {
      anchors.fill: power
      hoverEnabled: true
      cursorShape: Qt.PointingHandCursor
      onClicked: {
        powerMenu.popup(35,640,power)
        powerMenu.open();
      }
    }
    Text {
      text: "⏻"
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
        font {
            pixelSize: Settings.fontpixelSize + 5
            weight: Settings.fontWeight
            family: Settings.fontFamily
        }
      anchors.fill: power
      color: Colors.palette.primary
    }
    Process {
        id: logoutProcess
        command: ["wayland-logout"]
    }
    Process {
        id: rebootProcess
        command: ["systemctl", "reboot"]
    }
    Process {
        id: shutdownProcess
        command: ["systemctl", "poweroff"]
    }

    Menu {
        id: powerMenu
        implicitWidth: 95
        implicitHeight: 120
        popupType: Popup.Native
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        background: Rectangle {
            color: Colors.palette.background
            radius: Settings.widgetRadius
            border.width: 1
            border.color: Colors.palette.surface_bright
        }
        ColumnLayout {
            anchors.fill: parent
            WrapperItem {
                Layout.alignment: Qt.AlignCenter
                Layout.topMargin: 5
                MenuItem {
                    id: logoutItem
                    hoverEnabled: true
                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }
                    contentItem: Label {
                        color: logoutItem.hovered ? Colors.palette.on_primary : "white"
                        text: "Logout"
                        verticalAlignment: Text.AlignVCenter 
                        horizontalAlignment: Text.AlignHCenter 
                        font.pixelSize: Settings.fontpixelSize + 2
                        font.family: Settings.fontFamily
                    }
                    onTriggered: logoutProcess.running = true
                    background: WrapperRectangle {
                        color: parent.hovered ? Colors.palette.on_surface : "transparent"
                        height: logoutItem.height
                        width: logoutItem.width
                        leftMargin: 80
                        radius: Settings.widgetRadius - 5
                    }
                }
            }
            WrapperItem {
                Layout.alignment: Qt.AlignCenter
                MenuItem {
                    id: restartItem
                    hoverEnabled: true
                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }
                    implicitTextPadding: 5
                    contentItem: Label {
                        color: restartItem.hovered ? Colors.palette.on_primary : "white"
                        text: "Restart"
                        verticalAlignment: Text.AlignVCenter 
                        horizontalAlignment: Text.AlignHCenter 
                        font.pixelSize: Settings.fontpixelSize + 2
                        font.family: Settings.fontFamily
                    }
                    onTriggered: rebootProcess.running = true
                    background: WrapperRectangle {
                        color: parent.hovered ? Colors.palette.on_surface : "transparent"
                        height: restartItem.height
                        width: restartItem.width
                        leftMargin: 80
                        radius: Settings.widgetRadius - 5
                    }
                }
            }
            WrapperItem {
                Layout.alignment: Qt.AlignCenter
                MenuItem {
                    id: shutdownItem
                    hoverEnabled: true
                    HoverHandler {
                        cursorShape: Qt.PointingHandCursor
                    }
                    contentItem: Label {
                        color: shutdownItem.hovered ? Colors.palette.on_primary : "white"
                        text: "Shutdown"
                        verticalAlignment: Text.AlignVCenter 
                        horizontalAlignment: Text.AlignHCenter 
                        font.pixelSize: Settings.fontpixelSize + 2
                        font.family: Settings.fontFamily
                    }
                    onTriggered: shutdownProcess.running = true
                    background: Rectangle {
                        color: parent.hovered ? Colors.palette.on_surface : "transparent"
                        height: shutdownItem.height
                        width: shutdownItem.width
                        radius: Settings.widgetRadius - 5
                    }
                }
            }
        }
    }
}

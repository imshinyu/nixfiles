pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import qs.Appearance as Appearance
Variants {
    model: Quickshell.screens
    Scope {
        id: root
        required property ShellScreen modelData
        property bool active: false
        property color backgroundColor: Appearance.Colors.palette.surface
        property int cornerRadius: Appearance.Settings.cornerRadius
        FloatingWindow {
            id: settings
            screen: root.modelData
            visible: root.active
            color: 'transparent'
            Rectangle {
                id: background
                width: settings.width
                height: settings.height
                color: root.backgroundColor
                anchors.centerIn: parent
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Escape) {
                        root.active = false
                    }
                }
                Column {
                    anchors.fill: parent
                    Rectangle {
                        id: list
                        // Layout.alignment: Qt.AlignLeft
                        anchors.verticalCenter: parent.verticalCenter
                        x: 20
                        implicitHeight: parent.height - 50
                        implicitWidth: parent.width / 4
                        radius: root.cornerRadius
                        color: Appearance.Colors.palette.surface_container
                        Rectangle {
                            id: search
                            anchors.alignWhenCentered: top
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 5
                            implicitHeight: 40
                            implicitWidth: parent.width - 10
                            radius: root.cornerRadius - 5
                            color: Appearance.Colors.palette.surface_bright
                        }
                        ListView {
                            focus: true
                            id: appView
                            width: parent.width - 16
                            height: parent.height
                            model: 15
                            y: 60
                            spacing: 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            clip: true
                            delegate: Rectangle {
                                    id: delegated
                                    property bool isSelected: ListView.isCurrentItem
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: parent.width
                                    height: 30
                                    color: Appearance.Colors.palette.surface_bright
                                    radius: root.cornerRadius - 5
                                    Image {
                                        id: icon
                                        anchors.verticalCenter: delegated.verticalCenter
                                        x: 50
                                        source: "~/Pictures/a black and white drawing of a girl with long hair wearing a collared shirt.jpg"
                                        width: 20
                                        height: 20
                                    }
                                    Text {
                                        id: text
                                        anchors.verticalCenter: delegated.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        x: 40
                                        color: Appearance.Colors.palette.on_surface
                                        text: "System Settings"
                                        clip: true
                                        font {
                                            family: Appearance.Settings.fontFamily
                                            pixelSize: Appearance.Settings.fontpixelSize
                                            weight: Appearance.Settings.fontWeight
                                        }
                                    }
                                }
                        }
                    }
                }
                
            }
        }
        IpcHandler {
            target: "settings"
            function openclosesettings() {
                if (root.active == true) {
                    return root.active = false;
                }
                else if (root.active == false) {
                    return root.active = true;
                }
            }
        }
    }   
}

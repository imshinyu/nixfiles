import Quickshell
import Quickshell.Widgets
pragma ComponentBehavior: Bound
import Quickshell.Io
import qs.Appearance
import qs.Appearance as Appearance
import qs.Services
import qs.Services.Niri
import qs.Services.Mango
import QtQuick
import QtQuick.Layouts

WrapperRectangle {
    id: root
    property var workspaces: detectCompositor()
    property ShellScreen screen
    color: Appearance.Colors.palette.inverse_on_surface
    radius: Appearance.Settings.widgetRadius
    function detectCompositor(){
        if (Quickshell.env("XDG_CURRENT_DESKTOP")=="niri") return Niri.workspaces
        else if (Quickshell.env("XDG_CURRENT_DESKTOP")=="mango") return Mango.tags
    }
    ColumnLayout {
        id: workCol
        anchors.fill: root
        spacing: 0
        Repeater {
            id:workspacePill
            model: root.workspaces
            delegate: Rectangle {
                id: pill
                required property var modelData 
                visible: modelData.isFocused || modelData.containsWindow
                color: (modelData.isFocused==true) ? Colors.palette.primary : 'transparent';
                implicitWidth: 25
                implicitHeight: 25
                radius: Appearance.Settings.widgetRadius
                MouseArea {
                    anchors.fill: pill
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton
                    onClicked: changeWorkspace.running = true
                }
                Process {
                    id: changeWorkspace
                    command:
                        if (root.detectCompositor()==Mango.tags) 
                            return ["mmsg","-t",pill.modelData.workspaceId];
                        else
                            return ["niri", "msg", "action", "focus-workspace",pill.modelData.workspaceId];
                }
                Text {
                    id: workNum
                    anchors.centerIn: pill
                    color: (pill.modelData.isFocused==true) ? Appearance.Colors.palette.on_primary : Appearance.Colors.palette.on_surface
                    font {
                        family: Appearance.Settings.fontFamily
                        pixelSize: Appearance.Settings.fontpixelSize
                        weight: Appearance.Settings.fontWeight
                    }
                    text: pill.modelData.workspaceId
                }
            }
        }
    }
}

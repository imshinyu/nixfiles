// pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls
import qs.Appearance as Appearance
import "./Fuzzy/fuzzysort.js" as FuzzySort
Variants {
    model: Quickshell.screens
    Scope {
        id: root
        required property ShellScreen modelData
        property bool active: false
        property color backgroundColor: Appearance.Colors.palette.surface
        property int cornerRadius: Appearance.Settings.cornerRadius
        // PanelWindow {
        //     anchors {
        //         top: true
        //         bottom: true
        //         right: true
        //     }
        //     // focusable: true
        //     aboveWindows: true
        //     implicitWidth: 0
        //     color: 'transparent'
        // }
        LazyLoader {
            id: loader
            active: root.active
            PanelWindow {
                id: launcher
                screen: root.modelData
                visible: root.active
                WlrLayershell.keyboardFocus: (root.active) ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
                WlrLayershell.layer: WlrLayer.Top
                exclusionMode: ExclusionMode.Normal
                focusable: true
                aboveWindows: true
                anchors: {
                    top: true
                    bottom: true
                    right: true
                    left: true
                }
                implicitWidth: 550
                implicitHeight: 400
                color: 'transparent'
                Keys.onPressed: (event) => {
                    if (event.key === Qt.Key_Escape) {
                        root.active = false
                    }
                }
                RectangularShadow {
                    anchors.fill: background
                    spread: 2.5
                    radius: Appearance.Settings.cornerRadius
                    blur: 3
                    color: Qt.rgba(0.0, 0.0, 0.0, 0.61)
                }
                Rectangle {
                    id: background
                    width: launcher.width - 10
                    height: launcher.height - 10
                    color: backgroundColor
                    anchors.centerIn: parent
                    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Escape) {
                            root.active = false
                      }
                    }
                    radius: cornerRadius
                    // focus: true
                    ColumnLayout {
                        id: col
                        // anchors.top: background.top
                        anchors.fill: background
                        Rectangle {
                            id: search
                            width: background.width - 25
                            height: 35
                            radius: cornerRadius - 5
                            Layout.topMargin: 10
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            color: Appearance.Colors.palette.surface_container
                            TextInput {
                                id: entry
                                focus: true
                                anchors.verticalCenter: parent.verticalCenter
                                x: 8
                                property bool searching: text.length > 0
                                property bool notSearching: text.length === 0
                                property string content: entry.text
                                property var current: appView.currentIndex
                                onTextChanged: appView.forceLayout()
                                Keys.onReturnPressed: {
                                    const list = appView.model;
                                    if (searching) {
                                    console.log(list);
                                    if (list.length > 0) {
                                        list[current].execute();
                                        root.active = false;
                                        clear()
                                    }}
                                    if (notSearching) {
                                        list[current].execute()
                                        root.active = false;
                                        clear()
                                    }
                                }
                                Keys.onDownPressed: {
                                    // appView.incrementCurrentIndex()
                                    appView.currentIndex = (appView.currentIndex + 1 + appView.count) % appView.count
                                }
                                Keys.onUpPressed: {
                                    appView.currentIndex = (appView.currentIndex - 1 + appView.count) % appView.count
                                }
                                Keys.onEscapePressed: {
                                    root.active = false
                                    clear()
                                }
                                Text {
                                    color: Appearance.Colors.palette.primary
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: 'Search for something..'
                                    visible: entry.notSearching
                                }
                                color: Appearance.Colors.palette.on_surface
                                font: {
                                    family: Appearance.Settings.fontFamily
                                    pixelSize: Appearance.Settings.fontpixelSize
                                    weight: Appearance.Settings.fontWeight
                                }
                            }
                        }
                        Rectangle {
                            id: appListBackground
                            width: background.width - 25
                            implicitHeight: parent.height - 80
                            radius: cornerRadius - 5
                            color: Appearance.Colors.palette.surface
                            Layout.topMargin: 10
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                            ListView {
                                focus: true
                                id: appView
                                width: parent.width - 16
                                height: parent.height
                                model: entry.searching?  DesktopEntries.applications : FuzzySort.go(entry.text, DesktopEntries.applications.values, {
                                    all: true,
                                    keys: ["name","genericName","icon"]
                                }).map(a => a.obj)
                                y: 8
                                spacing: 8
                                anchors.horizontalCenter: parent.horizontalCenter
                                clip: true
                                function launchModelData(): void {
                                    if (currentItem == currentItem.modelData) {
                                        currentItem.modelData.execute()
                                        root.active = false;
                                    }
                                }
                                delegate: Rectangle {
                                    id: delegated
                                    property bool isSelected: ListView.isCurrentItem
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    width: parent.width
                                    height: 32
                                    color: Appearance.Colors.palette.surface_bright
                                    radius: cornerRadius / 1.5
                                    states: [
                                        State {
                                            name: "selected"
                                            when: delegated.isSelected

                                            PropertyChanges {
                                                target: delegated
                                                color: Appearance.Colors.palette.primary
                                            }
                                            PropertyChanges {
                                                target: text 
                                                color: Appearance.Colors.palette.surface_container
                                                weight: 900
                                                textWidth: 120

                                            }

                                        }
                                    ]
                                    transitions: [
                                        Transition {
                                            from: ""; to: "selected"
                                            reversible: true
                                            ColorAnimation {
                                                properties: "color"; duration: 300; easing.type: Easing.OutQuad;
                                            }
                                            NumberAnimation {
                                                properties: "x, weight, textWidth"; duration: 300; easing.type: Easing.OutQuad
                                            }
                                        }
                                    ]
                                    Image {
                                        id: appIcon
                                        anchors.verticalCenter: parent.verticalCenter
                                        x: 4
                                        width: 25
                                        height: 25
                                        source: {
                                            const ic = modelData?.icon ?? "";
                                            if (!ic) return "";
                                            if (ic.startsWith("/")) return ic;
                                            return Quickshell.iconPath(ic);
                                        }
                                    }
                                    Text {
                                        id: text
                                        anchors.verticalCenter: parent.verticalCenter
                                        x: 35
                                        font.variableAxes: {
                                            "wght": weight,
                                            "wdth": textWidth
                                        }
                                        font.family: Appearance.Settings.fontFamily
                                        property int weight: 500
                                        property int textWidth: 100
                                        property real fontSize: 12
                                        font.pointSize: fontSize
                                        text: modelData.name
                                        color: Appearance.Colors.palette.primary
                                    }
                                    MouseArea {
                                        id: handler
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: {
                                            modelData.execute()
                                            root.active = false
                                        }
                                        onEntered: {
                                            appView.currentIndex = index
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        IpcHandler {
            target: "launcher"
            function opencloselauncher() {
                if (root.active == true) {
                    entry.clear();
                    return root.active = false;
                }
                else if (root.active == false) {
                    return root.active = true;
                }
            }
        }
    }   
}

import Quickshell.Widgets
import QtQuick
import qs.Services
import qs.Appearance
WrapperRectangle {
    id: wrapperItem
    color: Colors.palette.surface_bright
    radius: Settings.widgetRadius
    margin: 1
    Text {
        text: Time.time
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Colors.palette.primary
        font {
          pixelSize: Settings.fontpixelSize
          family: Settings.fontFamily
          weight: Settings.fontWeight
        }
    }
}

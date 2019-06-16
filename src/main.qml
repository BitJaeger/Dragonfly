import QtQuick 2.12
import QtQuick.Window 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12

Window {
    id: window
    width: 1024
    height: 600
    visible: true

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    Rectangle {
        id: bigWindow
        anchors.fill: parent

        Map {
            id: map
            anchors.fill: parent
            plugin: mapPlugin
            center: QtPositioning.coordinate(52.960713, 4.793730) // Berghaven
            zoomLevel: 14
        }
    }

    Rectangle {
        id: smallWindow
        width: 160 * 2
        height: 90 * 2

        x: 20
        y: parent.height - height - menu.height - 20
        z: 0

        color: "black"

        Rectangle {
            id: videoWindow
            color: "#000000"
            anchors.fill: parent

            Text {
                x:20
                y:20
                id: noVideoLabel
                text: qsTr("NO VIDEO")
                font.family: "Roboto Black"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                color: "#FFFFFFFF"
            }
        }

        MouseArea {
            id: switchWindowArea
            anchors.fill: parent
            onClicked: {
                if (map.parent == smallWindow) {
                    map.parent = bigWindow
                    videoWindow.parent = smallWindow
                    map.z = switchWindowArea - 1
                } else {
                    map.parent = smallWindow
                    videoWindow.parent = bigWindow
                }
            }
        }

        DropShadow {
            anchors.fill: smallWindow
            horizontalOffset: 3
            verticalOffset: -3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: smallWindow
        }
    }

    Rectangle {
        id: menu
        width: parent.width
        height: 75
        gradient: Gradient {
            GradientStop {
                position: 0.309
                color: "#2e2d2d"
            }

            GradientStop {
                position: 0.315
                color: "#2e2d2d"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }

        }
        border.width: 0
        border.color: "#00000000"
        x: 0
        y: parent.height - height


        Rectangle {

            property var smallHeight: 75
            property var mediumHeight: 150
            property var largeHeight: 300

            id: biggerMenu
            color: "red"
            width: 50
            height: smallHeight

            Image {
                id: biggerMenuImage
                source: "file"
            }

            MouseArea {
                id: biggerMenuArea
                anchors.fill: parent
                onClicked: {
                    if(menu.height == smallHeight) {
                        menu.height = mediumHeight
                    } else if (menu.height == mediumHeight) {
                        menu.height = largeHeight
                    }

                }
            }
        }


        DropShadow {
            anchors.fill: menu
            horizontalOffset: 0
            verticalOffset: -3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: menu
        }
    }
}

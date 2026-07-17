import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

import QtQuick.Controls


ApplicationWindow
{
    visible: true

    width: 1100
    height: 900

    title: "Lehra"

    color: "#2D3033"
    property bool darkMode: true
    property color bgColor: darkMode ? "black" : "white"
    property color textColor: darkMode ? "white" : "black"
    property color cardColor: darkMode ? "black" : "white"
    property color borderColor: darkMode ? "#2979FF" : "#2979FF"

    Rectangle
    {
        width:1100
        height:700

        anchors.centerIn: parent
        color: cardColor
        radius: 80
        border.width:5
        border.color: borderColor

        Row {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 20
            spacing: 8

            Text {
                text: darkMode ? "🌙 Dark Mode" : "☀ Light Mode"
                color: darkMode ? "white" : "black"
                font.pixelSize: 20
            }

            Switch {
                checked: darkMode

                onCheckedChanged: darkMode = checked
            }
        }
        Timer {
            id: loadingTimer

            interval: 1500
            repeat: false

            onTriggered: loadingIndicator.visible = false
        }
        BusyIndicator {
            id: loadingIndicator

            anchors.centerIn: parent

            width: 60
            height: 60

            visible: false
            running: visible
        }

        Text {
            text: "Design, Development & Audio Credits\n© 2026 Anish Savkar\nAll Rights Reserved."

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 35
            anchors.bottomMargin: 25

            horizontalAlignment: Text.AlignRight

            font.pixelSize: 12
            opacity: 0.7
            color: darkMode? "white" : "black"
        }


    Column
    {
        anchors.fill: parent
        anchors.margins: 25

        Item {
            width:1
            height:10
        }

        anchors
        {
            fill: parent
            margins: 30
        }

        spacing: 30

        Label
        {

            width: parent.width

            text: "🎵 LEHRA 🎵"

            color: textColor

            font.pixelSize: 42
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
        }


        Item
        {
            width: parent.width
            height: 50

            Row
            {
                anchors.centerIn: parent
                spacing: 20

                Label
                    {

                      width: 70

                     text: "BPM"

                     color: textColor

                     font.pixelSize: 22

                    }

                Slider
                {

                id: bpmSlider

                width: 670
                from: tm.minBPM
                to: tm.maxBPM
                value: tm.defaultBPM

                Component.onCompleted:
                {
                    audioEngine.currentBPM=value
                }

                onPressedChanged:
                {
                    if(!pressed)
                        loadingIndicator.visible = true
                        loadingTimer.restart()
                    audioEngine.currentBPM=value
                }

                background: Rectangle
                {
                    x: bpmSlider.leftPadding
                    y: bpmSlider.topPadding + bpmSlider.availableHeight/2-height/2

                    width: bpmSlider.availableWidth
                    height:6
                    radius:3
                    color:textColor

                    Rectangle
                    {
                        width:bpmSlider.visualPosition *parent.width
                        height: parent.height
                        radius: parent.radius
                        color: "orange"
                    }
                }
                handle: Rectangle
                {
                    width:18
                    height:18
                    radius:9
                    color:textColor
                    x: bpmSlider.leftPadding + bpmSlider.visualPosition * (bpmSlider.availableWidth - width)
                    y: bpmSlider.topPadding + bpmSlider.availableHeight / 2 - height / 2
                }

                }

                Label
                {
                 width:50
                text: Math.round(bpmSlider.value)

                color: textColor

                font.pixelSize: 22
                horizontalAlignment: Text.AlignRight
                }
        }

    }

            Item
            {
                width:1
                height:30
            }

            Row
            {

                  anchors.horizontalCenter: parent.horizontalCenter

                  spacing: 25

                  Repeater
                  {
                      model: tm.BeatCount

                      Rectangle
                      {
                          width: 30
                          height: 30
                          radius: width/2
                          scale: index===audioEngine.currentBeat? 1.3:1.0

                          color: index === audioEngine.currentBeat
                                 ? "#2979FF"
                                 :"red"

                            Behavior on scale
                            {
                                NumberAnimation{duration:80
                            }
                           }
                          Behavior on color
                          {
                              ColorAnimation
                              {
                                  duration: 80
                              }
                          }
                      }
                  }

            }
            Item
            {
                width:1
                height:20
            }
            Row
            {
                anchors.horizontalCenter: parent.horizontalCenter
                ComboBox
                {

                    id:taalBox
                    width:200
                    font.pixelSize: 20
                    font.bold: true
                    model:
                    [
                        "Teentaal",
                        "Jhaptaal",
                        "Rupak",
                        "Ektaal",
                        "Keherwa"
                    ]
                    onCurrentIndexChanged:
                    {
                        audioEngine.stopAudio();
                        tm.setCurrentTaal(currentIndex)
                        bpmSlider.value=tm.defaultBPM
                        audioEngine.currentBPM=tm.defaultBPM

                    }

                    background:Rectangle
                    {
                        radius:20
                        color:"black"
                        border.width:4
                        border.color:"cyan"
                    }

                }
            }
            Item
            {
                width:1
                height:20
            }
            Row
            {
                spacing:20
                anchors.horizontalCenter: parent.horizontalCenter

                Button
                {
                    text: "▶ Play"
                    width:150
                    height:50
                    font.pixelSize: 22
                    onClicked:
                    {
                        loadingIndicator.visible=true
                        loadingTimer.restart()
                        audioEngine.playAudio()
                    }

                    background: Rectangle
                    {
                        radius:18
                        color:"#FF9800"
                        border.width:2
                        border.color:borderColor
                    }
                }
                Button
                {
                    text: "⏸ Pause"
                    width:150
                    height:50
                    font.pixelSize: 22
                    onClicked:
                    {
                        audioEngine.pauseAudio()
                    }

                    background: Rectangle
                    {
                        radius:18
                        color:"blue"
                        border.width:2
                        border.color:borderColor
                    }
                }
                Button
                {
                    text:"⏹ Stop"
                    width:150
                    height:50
                    font.pixelSize: 22
                    onClicked:
                    {
                        audioEngine.stopAudio()
                    }

                    background: Rectangle
                    {
                        radius:18
                        color:"Red"
                        border.width:2
                        border.color:borderColor
                    }

                }

            }

        }
    }
}
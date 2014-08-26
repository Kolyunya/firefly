import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.2
import QtBluetooth 5.3

ApplicationWindow
{

    id: window
    visible: true
    width: 640
    height: 960
    title: qsTr("Firefly")

    BluetoothSocket
    {
        id: bluetoothSocket
        onConnectedChanged:
        {
            console.log(connected)
            if ( connected )
            {
                btnEnableFirefly.enabled = true
                btnDisableFirefly.enabled = true
                sldrChangeFireflyBrightness.enabled = true
                btnColorRed.enabled = true
                btnColorBlue.enabled = true
                btnColorGreen.enabled = true
                btnColorPurple.enabled = true
                btnColorYellow.enabled = true
                btnColorWhite.enabled = true
                btnFindFirefly.enabled = false
                progressBar.visible = false
            }
            else
            {
                btnEnableFirefly.enabled = false
                btnDisableFirefly.enabled = false
                sldrChangeFireflyBrightness.enabled = false
                btnColorRed.enabled = false
                btnColorGreen.enabled = false
                btnColorBlue.enabled = false
                btnColorPurple.enabled = false
                btnColorYellow.enabled = false
                btnColorWhite.enabled = false
                btnFindFirefly.enabled = true
            }
        }
    }

    BluetoothDiscoveryModel
    {
        id: bluetoothExplorer
        running: false
        onServiceDiscovered:
        {
            if ( service.deviceName == "Firefly" )
            {
                bluetoothSocket.service = service
                bluetoothSocket.connected = true
            }
        }
        onErrorChanged:
        {
            switch (bluetoothExplorer.error)
            {
                case BluetoothDiscoveryModel.PoweredOffError:
                    console.log("Error: Bluetooth device not turned on"); break;
                case BluetoothDiscoveryModel.InputOutputError:
                    console.log("Error: Bluetooth I/O Error"); break;
                case BluetoothDiscoveryModel.NoError:
                    break;
                default:
                    console.log("Error: Unknown Error"); break;
            }
        }
    }

    menuBar: MenuBar
    {
        Menu
        {
            title: qsTr("Меню")
            MenuItem
            {
                text: qsTr("Выйти")
                onTriggered: Qt.quit();
            }
        }
    }

    Column
    {

        id: column
        width: parent.width - 40
        antialiasing: true
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20

        Button
        {
            id: btnFindFirefly
            objectName: "btnFindFirefly"
            width: parent.width
            height: 150
            text: qsTr("Поиск")
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked:
            {
                enabled = false
                progressBar.visible = true
                bluetoothExplorer.discoveryMode = BluetoothDiscoveryModel.MinimalServiceDiscovery
                bluetoothExplorer.running = true
            }
            style: ButtonStyle
            {
                label: Text
                {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Calibri"
                    font.pointSize: 20
                    color: "#333333"
                    text: control.text
                }
            }

            ProgressBar
            {
                id: progressBar
                width: parent.width
                height: parent.height
                indeterminate: true
                visible: false
                opacity: 0.5
            }

        }

        Button
        {
            id: btnEnableFirefly
            width: parent.width
            height: 150
            text: qsTr("Включить")
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: false
            onClicked:
            {
                bluetoothSocket.sendStringData("BRIGHTNESS:"+sldrChangeFireflyBrightness.value)
                bluetoothSocket.sendStringData("ON")
            }
            style: ButtonStyle
            {
                label: Text
                {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Calibri"
                    font.pointSize: 20
                    color: "#333333"
                    text: control.text
                }
            }
        }

        Button
        {
            id: btnDisableFirefly
            width: parent.width
            height: 150
            text: qsTr("Выключить")
            anchors.horizontalCenter: parent.horizontalCenter
            enabled: false
            onClicked:
            {
                bluetoothSocket.sendStringData("OFF")
            }
            style: ButtonStyle
            {
                label: Text
                {
                    renderType: Text.NativeRendering
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.family: "Calibri"
                    font.pointSize: 20
                    color: "#333333"
                    text: control.text
                }
            }
        }

        Grid
        {
            width: parent.width
            columns: 3
            spacing: 20

            Button
            {
                id: btnColorRed
                width: parent.width / 3 - 40 / 3
                height: 150
                text: "Красный"
                enabled: false
                style: ButtonStyle
                {
                    label: Text
                    {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Calibri"
                        font.pointSize: 15
                        color: "#CC4921"
                        text: control.text
                    }
                }
                onClicked:
                {
                    bluetoothSocket.sendStringData("COLOR:CC4921")
                }
            }

            Button
            {
                id: btnColorGreen
                width: parent.width / 3 - 40 / 3
                height: 150
                text: "Зеленый"
                enabled: false
                style: ButtonStyle
                {
                    label: Text
                    {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Calibri"
                        font.pointSize: 15
                        color: "#69CC41"
                        text: control.text
                    }
                }
                onClicked:
                {
                    bluetoothSocket.sendStringData("COLOR:69CC41")
                }
            }

            Button
            {
                id: btnColorBlue
                width: parent.width / 3 - 40 / 3
                height: 150
                text: "Синий"
                enabled: false
                style: ButtonStyle
                {
                    label: Text
                    {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Calibri"
                        font.pointSize: 15
                        color: "#58A0DB"
                        text: control.text
                    }
                }
                onClicked:
                {
                    bluetoothSocket.sendStringData("COLOR:58A0DB")
                }
            }

            Button
            {
                id: btnColorYellow
                width: parent.width / 3 - 40 / 3
                height: 150
                text: "Желтый"
                enabled: false
                style: ButtonStyle
                {
                    label: Text
                    {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Calibri"
                        font.pointSize: 15
                        color: "#D1D14F"
                        text: control.text
                    }
                }
                onClicked:
                {
                    bluetoothSocket.sendStringData("COLOR:D1D14F")
                }
            }

            Button
            {
                id: btnColorPurple
                width: parent.width / 3 - 40 / 3
                height: 150
                text: "Фиолетовый"
                enabled: false
                style: ButtonStyle
                {
                    label: Text
                    {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Calibri"
                        font.pointSize: 15
                        color: "#B12BF0"
                        text: control.text
                    }
                }
                onClicked:
                {
                    bluetoothSocket.sendStringData("COLOR:B12BF0")
                }
            }

            Button
            {
                id: btnColorWhite
                width: parent.width / 3 - 40 / 3
                height: 150
                text: "Белый"
                enabled: false
                style: ButtonStyle
                {
                    label: Text
                    {
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: "Calibri"
                        font.pointSize: 15
                        color: "#333333"
                        text: control.text
                    }
                }
                onClicked:
                {
                    bluetoothSocket.sendStringData("COLOR:333333")
                }
            }

        }

        Slider
        {
            id: sldrChangeFireflyBrightness
            width: parent.width
            height: 150
            tickmarksEnabled: false
            value: 30
            stepSize: 1
            orientation: 1
            maximumValue: 100
            enabled: false
            onValueChanged:
            {
                if ( bluetoothSocket.connected )
                {
                    bluetoothSocket.sendStringData("BRIGHTNESS:"+value)
                }
            }
        }

    }

}

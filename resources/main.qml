import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1

import com.nearce.HullRenderer 1.0

ColumnLayout {

  HullRenderer {
    id: renderer
    objectName: "renderer"
    Layout.preferredHeight: 600

    Layout.fillWidth: true
    Layout.fillHeight: true

    Timer {
      interval: speed_slider.value * 2000; running: true; repeat: true
      onTriggered: renderer.advance()
    }
  }

  RowLayout {
    id: control_box
    Layout.alignment: Qt.AlignHCenter

    ColumnLayout {
      Layout.preferredWidth: 300
      Layout.alignment: Qt.AlignHCenter | Qt.Top

      Text {
        Layout.alignment: Qt.AlignHCenter

        text: "Algorithm"
      }

      ComboBox {
        id: algorithm_box
        objectName: "algorithm_box"
        Layout.preferredWidth: 280
        Layout.alignment: Qt.AlignHCenter
        model: ListModel {
            ListElement { text: "Graham Scan" }
            ListElement { text: "Jarvis March" }
        }
      }
    }

    ColumnLayout {
      Layout.preferredWidth: 600
      Layout.alignment: Qt.AlignHCenter | Qt.Top

      Text {
        Layout.alignment: Qt.AlignHCenter

        text: "Properties"
      }

      RowLayout {
        Text {
          id: speed_label
          text: "Speed"
        }

        Slider {
          id: speed_slider
          activeFocusOnPress: true
          updateValueWhileDragging: true
          width: parent.parent.width - speed_label.width - (parent.spacing * 4)
          minimumValue: .01
          maximumValue: 1
          value: .5
        }
      }
    }

    ColumnLayout {
      Layout.preferredWidth: 300
      Layout.alignment: Qt.AlignHCenter | Qt.Top

      Text {
        Layout.alignment: Qt.AlignHCenter

        text: "Actions"
      }

      RowLayout {
        Layout.alignment: Qt.AlignHCenter | Qt.Top

        Button {
          objectName: "process_hull"
          Layout.alignment: Qt.AlignHCenter

          text: "Process Hull"

          onClicked: {
            hull_solver.algorithm = algorithm_box.currentText;
            hull_solver.calculate();
          }

        }

        Button {
          objectName: "load_data"
          Layout.alignment: Qt.AlignHCenter

          text: "Load Dataset"

          onClicked: {
            hull_solver.input = "Random Point";
            hull_solver.repollData();
          }
        }

        Button {
          objectName: "save_data"
          Layout.alignment: Qt.AlignHCenter

          text: "Save Result"
        }
      }
    }

    SequentialAnimation {
        running: true
        NumberAnimation {
          target: control_box
          property: "opacity"
          from: 0
          to: 1.0
          duration: 800
        }
    }
  }
}

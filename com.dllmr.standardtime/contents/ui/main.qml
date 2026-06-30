/*
 *  Copyright (c) 2024 Mike Dillamore (GitHub: @dllmr)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick
import QtMultimedia
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore

WallpaperItem {

    // Name of the 24-hour Standard Time video, expected alongside this file.
    readonly property string videoFileName: "st24.mov"

    Video {
        id: player
        anchors.fill: parent
        source: Qt.resolvedUrl("./" + videoFileName)
        loops: MediaPlayer.Infinite
        fillMode: VideoOutput.PreserveAspectFit
        volume: 0.0

        // A missing or unreadable video surfaces here as a resource error.
        onErrorOccurred: (error, errorString) => {
            errorMessage.visible = true
        }
    }

    Text {
        id: errorMessage
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Math.round(parent.height * 0.08)
        horizontalAlignment: Text.AlignHCenter
        color: "white"
        font: PlasmaCore.Theme.defaultFont
        text: "The Standard Time video (" + videoFileName + ") could not be loaded.\n"
              + "Please ensure it is installed alongside this wallpaper."
    }

    function getMillisecondsSinceMidnight() {
        var now = new Date();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();
        var milliseconds = now.getMilliseconds();

        return (hours * 3600000) + (minutes * 60000) + (seconds * 1000) + milliseconds;
    }

    function play() {
        player.position = getMillisecondsSinceMidnight();
        player.play();
    }

    Timer {
        id: startTimer
        interval: 1000
        onTriggered: {
            play()
        }
    }

    Component.onCompleted: {
        startTimer.start()
    }
}

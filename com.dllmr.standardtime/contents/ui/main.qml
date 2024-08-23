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

WallpaperItem {

    Video {
        id: player
        anchors.fill: parent
        source: Qt.resolvedUrl("./st24.mov")
        loops: MediaPlayer.Infinite
        fillMode: VideoOutput.PreserveAspectFit
        volume: 0.0
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

#!/bin/bash
i3-msg '[class="^URxvt$" instance="^music$"] scratchpad show' || urxvt -name "music" -e bash -c "ncmpcpp"

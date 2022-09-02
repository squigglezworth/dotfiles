#!/bin/bash
i3-msg '[class="^URxvt$" instance="^top$"] scratchpad show' || urxvt -name "top" -e bash -c "top"

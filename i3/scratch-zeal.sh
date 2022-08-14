#!/bin/bash
export QT_STYLE_OVERRIDE=gtk2

i3-msg '[class="^Zeal$"] scratchpad show' || zeal

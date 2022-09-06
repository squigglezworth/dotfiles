#!/usr/bin/python
import i3ipc, subprocess

i3 = i3ipc.Connection()
i3.on('workspace::focus', lambda self,e : subprocess.run('mpc sendmessage refresh_art 1', shell=True))
i3.main()

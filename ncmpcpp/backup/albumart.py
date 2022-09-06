#!/usr/bin/python3

import i3ipc, mpd, os, glob, re, time, subprocess, threading

MUSIC_DIR = '/mnt/multi/media/music/sorted/'
DEFAULT_ART = '/home/squigz/cats.png'
HOST = 'localhost'
PORT = '6600'
FONTH = 15
FONTW = 8

def refresh_image():
    global mpd

    PANE_WIDTH = int(subprocess.run(['tput cols'], shell=True, stdout=subprocess.PIPE).stdout.rstrip().decode('utf-8'))
    PANE_HEIGHT = int(subprocess.run(['tput lines'], shell=True, stdout=subprocess.PIPE).stdout.rstrip().decode('utf-8'))
    PANE_X = int(subprocess.run(["tmux display -p -t music:0.1 '#{pane_left}'"], shell=True, stdout=subprocess.PIPE).stdout.rstrip().decode('utf-8'))
    PANE_Y = int(subprocess.run(["tmux display -p -t music:0.1 '#{pane_top}'"], shell=True, stdout=subprocess.PIPE).stdout.rstrip().decode('utf-8'))
    X = PANE_X * FONTW
    Y = PANE_Y * FONTH
    WIDTH = PANE_WIDTH * FONTW
    HEIGHT = PANE_HEIGHT * FONTH

    CURRENT_ALBUM = mpd.currentsong()['album']
    CURRENT_SONG = mpd.currentsong()['file']
    CURRENT_DIR = MUSIC_DIR + os.path.dirname(CURRENT_SONG)

    FILE = None
    ## Find the album image
    for root, dirs, files in os.walk(CURRENT_DIR):
        # print('Searching for cover in: ' + CURRENT_DIR)
        for file in files:
            # print(file)
            if re.match('(cover|folder|artwork|front).*[.](jpe?g|png|gif|bmp)', file):
                # print('Found cover!')
                FILE = CURRENT_DIR + '/' + file
                ## Stop looping through the files when we find one
                break
        # FILE = DEFAULT_ART if FILE is None else FILE
        ## Only search in the top level dir
        break

    if FILE is None:
        return 0

    ## Execute w3mimagedisplay
    W3M_COMMAND = '0;1;{};{};{};{};;;;;{}\n4;\n3;\n'.format(X, Y, WIDTH, HEIGHT, FILE)
    W3M_COMMAND_BYTES = W3M_COMMAND.encode('utf-8')
    # print('w3m command: ' + W3M_COMMAND)
    p = subprocess.Popen('/usr/lib/w3m/w3mimgdisplay', stdin=subprocess.PIPE)
    p.stdin.write(W3M_COMMAND_BYTES)
    p.stdin.close()
    p.wait()

mpd = mpd.MPDClient()
mpd.connect(HOST, PORT)

mpd.subscribe('refresh_art')
mpd.send_idle('message')
while 1:
    mpd.fetch_idle()
    mpd.readmessages()
    refresh_image()
    mpd.send_idle('message')

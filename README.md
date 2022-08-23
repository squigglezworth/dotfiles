<div align=center>
  <img width=500 src='https://user-images.githubusercontent.com/20311086/186057854-255040f7-320c-43b9-b617-0871bfbc75a5.png' />
  <br>
<span><span><span style="color:#ED4A46;">p</span><span style="color:#70B433;">r</span><span style="color:#DBB32D;">e</span><span style="color:#368AEB;">t</span><span style="color:#EB6EB7;">t</span><span style="color:#3FC5B7;">y&nbsp;</span></span><span><span style="color:#E67F43;">c</span><span style="color:#A580E2;">o</span><span style="color:#FF87B2;">n</span><span style="color:#F4E06D;">f</span><span style="color:#FF87B2;">i</span><span style="color:#A580E2;">g&nbsp;</span></span><span><span style="color:#E67F43;">f</span><span style="color:#3FC5B7;">i</span><span style="color:#EB6EB7;">l</span><span style="color:#368AEB;">e</span><span style="color:#DBB32D;">s</span></span></span>
  <hr>

<sup><i>Original: <a href="https://github.com/squigglezworth/dotfiles"><code>squigglezworth/dotfiles</code></a> — Mirror for easier fetching: <a href='https://github.com/squigzy/squigzy.github.io/'><code>squigzy/squigzy.github.io</code></a></i></sup>
</div>

The major steps to installing these are...[^1]
- Preseeding
  - <a href="https://wiki.debian.org/DebianInstaller/Preseed">Preseed</a> a Debian installation with <a href='.preseed'>`.preseed`</a> (served at <a href="https://squigzy.github.io/.preseed">`squigzy.github.io/.preseed`</a>)<br>
  - The preseed fetches this repo, enables <a href="systemd/autologin.conf">autologin</a>, installs <a href='bash/bashrc'>`~/.bashrc`</a>, and creates a blank `~/.init` file<br>
  - After OS installation, on the first login, <a href='bash/bashrc'>`~/.bashrc`</a> will see `~/.init` and call <a href='.setup/init.sh'>`.setup/init.sh`</a>, which will orchestrate installation & configuration<br>
- Installing
  - The first script <a href='.setup/init.sh'>`init.sh`</a> calls is <a href='.setup/install.sh'>`.setup/install.sh`</a>, which installs various packages with `apt`, and runs some software-specific install scripts, such as for <a href='i3/install.sh'>i3-gaps</a>
- Configuring
  - After installation, <a href='.setup/init.sh'>`init.sh`</a> calls <a href='.setup/config.sh'>`.setup/config.sh`</a>, which symlinks various config files to their appropriate locations, and handles things like creating/removing directories or restarting services when appropriate
- Final Steps & Cleanup
  - Temporary files such as for building are stored in `/tmp` and should be cleaned up by the OS
  - Before exiting, <a href='.setup/init.sh'>`init.sh`</a> will prompt the user to run a further backup script to restore sensitive files (i.e., SSH keys)
  - Once the above scripts have finished, `~/.init` is removed by <a href='bash/bashrc'>`~/.bashrc`</a>
  - Finally, the script will prompt the user to reboot

[^1]:...which you really shouldn't do unless you know what you're doing.

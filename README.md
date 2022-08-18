<div align=center>
  <img src='https://user-images.githubusercontent.com/20311086/185320227-c2793470-0610-491a-9407-cc734ab33f23.svg' />
  <br>
  pretty config files
  <hr>

<sup><i>Original: <a href="https://github.com/squigglezworth/dotfiles"><code>squigglezworth/dotfiles</code></a> — Mirror for easier fetching: <a href='https://github.com/squigzy/squigzy.github.io/'><code>squigzy/squigzy.github.io</code></a></i></sup>
</div>

### To install these on a new system... [^1]

- <a href="https://wiki.debian.org/DebianInstaller/Preseed">Preseed</a> a Debian installation with <a href='https://squigzy.github.io/.preseed'>`https://squigzy.github.io/.preseed`</a><br>
- The preseed fetches this repo, enables <a href="systemd/autologin.conf">autologin</a>, installs <a href='bash/bashrc'>`.bashrc`</a>, and creates a blank `~/.preseed` file<br>
- On the first login, <a href='bash/bashrc'>`.bashrc`</a> will see `~/.preseed` and call <a href='.setup/init.sh'>`init.sh`</a>, which will orchestrate the installation & configuration of everything else<br>

[^1]:...which you really shouldn't do unless you know what you're doing.

<div align=center>
  <img src='https://user-images.githubusercontent.com/20311086/184478726-37ad298d-eea1-4340-8175-4462f62e6a68.png' />
  <br>
  pretty config files
  <hr>

<p>

<sup><i>Original: <a href="https://github.com/squigglezworth/dotfiles">`squigglezworth/dotfiles`</a> — Mirror for easier fetching: <a href='https://github.com/squigzy/squigzy.github.io/'>`squigzy/squigzy.github.io`</a></i></sup>

</p>
</div>
<h3>To install these on a new system...</h3>

- <a href="https://wiki.debian.org/DebianInstaller/Preseed">Preseed</a> a Debian installation with <a href='https://squigzy.github.io/.preseed'>`https://squigzy.github.io/.preseed`</a><br>
- The preseed fetches this repo, enables <a href="systemd/autologin.conf">autologin</a>, installs <a href='bash/bashrc'>`.bashrc`</a>, and creates a blank `~/.preseed` file<br>
- On the first login, <a href='bash/bashrc'>`.bashrc`</a> will see `~/.preseed` and call <a href='.setup/init.sh'>`init.sh`</a>, which will orchestrate the installation & configuration of everything else<br>

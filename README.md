<div align=center>
  <img src='https://user-images.githubusercontent.com/20311086/184478726-37ad298d-eea1-4340-8175-4462f62e6a68.png' />
  <br>
  pretty config files
  <hr>
</div>

<sup><i>This repo is mirrored at <a href='https://github.com/squigzy/squigzy.github.io/'>`squigzy/squigzy.github.io`</a></i></sup>
<h3>To install these on a new system...</h3>

- <a href="https://wiki.debian.org/DebianInstaller/Preseed">Preseed</a> a Debian installation with <a href='.preseed'>`squigzy.github.io/.preseed`</a><br>
- The preseed fetches this repo, installs the <a href='bash/bashrc'>`.bashrc`</a> file, and creates a blank `~/.preseed` file<br>
- On the first login, <a href='bash/bashrc'>`.bashrc`</a> will see `~/.preseed` and call <a href='.setup/init.sh'>`init.sh`</a>, which will orchestrate the installation & configuration of everything else<br>

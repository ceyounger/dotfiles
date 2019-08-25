#!/usr/bin/env bash

###############################################################################
# Install brew and brew cask apps                                             #
###############################################################################

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install more recent versions of some macOS tools.
brew install vim 
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
#brew install aircrack-ng
#brew install bfg
#brew install binutils
#brew install binwalk
#brew install cifer
#brew install dex2jar
#brew install dns2tcp
#brew install fcrackzip
#brew install foremost
#brew install hashpump
#brew install hydra
#brew install john
#brew install knock
#brew install netpbm
brew install nmap
#brew install pngcheck
#brew install socat
#brew install sqlmap
#brew install tcpflow
#brew install tcpreplay
#brew install tcptrace
#brew install ucspi-tcp # `tcpserver` etc.
#brew install xpdf
#brew install xz

# Install Java for dependencies
brew cask install java

# Install other useful binaries.
declare -a brew_cli_tools=(
  'ack'
  'autojump'
# Install Bash 4.
  'bash'
  'bash-completion2'
  'bat'
  'composer'
#  'exiv2'
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
  'findutils'
  'ffmpeg'
  'fzf'
  'git'
  'git-lfs'
# Install GnuPG to enable PGP-signing commits.
  'gnupg'
# Install GNU `sed`, overwriting the built-in `sed`.
  'gnu-sed'
  'gradle'
  'htop'
  'hugo'
	'kompose'
#  'imagemagick --with-webp'
#  'lua'
#  'lynx'
  'mas'
# Install some other useful utilities like `sponge`.
  'moreutils'
  'p7zip'
#  'parallel'
  'pigz'
  'pv'
  'rename'
  'rlwrap'
  'sbt'
  'ssh-copy-id'
  'tldr'
  'tree'
  'vbindiff'
  'wget'
  'youtube-dl'
  'zopfli'
  'zsh'
  'zsh-syntax-highlighting'
  'zsh-autosuggestions'
)

for tool in "${brew_cli_tools[@]}"; do
  brew install "$tool"
done

# Add older versions cask repository because of 1Password subscription based business model change from v6 to v7

brew tap homebrew/cask-versions

declare -a brew_cask_apps=(
  '1password6'
  'appcleaner'
#  'bartender'
#  'betterzip'
#  'caffeine'
#  'contexts'
#  'colorpicker-skalacolor'
  'docker'
  'dropbox'
#  'google-backup-and-sync'
  'google-chrome'
  'istat-menus'
  'iterm2'
#  'java'
#  'jetbrains-toolbox'
#  'noti'
  'paragon-ntfs'
#  'postman'
#  'qlcolorcode'
#  'qlmarkdown'
#  'qlstephen'
#  'qlvideo'
#  'quicklook-json'
  'rocket'
#  'sequel-pro'
#  'sketchbook'
  'slack'
#  'spotify'
  'sourcetree'
  'suspicious-package'
  'the-unarchiver'
  'tuntap'
#  'transmit'
#  'transmission'
#  'visualvm'
  'visual-studio-code'
  'vlc'
#  'webpquicklook'
#  'whatsapp'
)

for app in "${brew_cask_apps[@]}"; do
  brew cask install "$app"
done

###############################################################################
# Install Mac App Store apps                                                  #
###############################################################################

declare -a mas_apps=(
#  '409183694' # Keynote
#  '540348655' # Monosnap
#  '1278508951' # Trello
#  '441258766' # Magnet
#  '408981434' # iMovie
#  '715464874' # Disk Map
#  '587512244' # Kaleidoscope
  '1450038993' # Microsoft Office 365
  '784801555' # OneNote
  '1043270657' # GIF Keyboard
  '1295203466' # Microsoft Remote Desktop 10
  '1153157709' # Speedtest by Ookla
  '926036361' # LastPass
  '404010395' # TextWrangler
#  '409789998' # Twitter
  '1226444549' # Phiewer
)

for app in "${mas_apps[@]}"; do
  mas install "$app"
done

###############################################################################
# Configure installed apps                                                    #
###############################################################################

# Set ZSH as the default shell
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Run the Paragon NTFS installer
open /usr/local/Caskroom/paragon-ntfs/15/FSInstaller.app

# Fix gettext
brew link --force gettext

###############################################################################
# Install other apps (WIP)                                                    #
###############################################################################

# Fonts (WIP)

# Remove outdated versions from the cellar.
brew cleanup

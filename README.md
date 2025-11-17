# G's-Dotfiles

G's installation and configuration scripts for MacOS and Linux.

![Logo](logo.png)

Heavily influenced by [Omakub](https://omakub.org/).

## What this be

This is a curated collection of app installation and configuration scripts for MacOS and Linux (coming soon).

It is designed to provide a simple and aesthetic experience for users of all kinds, and to provide the best (opinionated) choices for any environment.

It is also designed to provide most of the [Omakub](https://omakub.org/) functionality, without the restrictions of requiring Ubuntu Gnome.  It also  contains many of my own personal touches, from App choices, to MacOS configurations, and more.

## How it do

1. Open your terminal
1. Run the following script:<br>

```bash
./install.sh
```

1. Follow the prompts.
1. You're done!
1. Restart your machine just to be safe.

## Application highlights

1. Brave - the best privacy-oriented browser of late. Also includes Chrome and Firefox.  Yes Brave Tor links, which is why I didn't include the Tor browser.
1. Libreoffice - Free and open source office suite.
1. Alacritty - A fantastic terminal emulator replacement for whatever came with your OS.<br>
[Learn to use the terminal](https://a.co/d/bwIR32o)
1. Zellij - The session manager inside of Alacritty. Like tmux, but better. Sessions, panes, tabs, etc.
1. Lazyvim - A curated Neovim with all the best plugins and configurations. A powerful text editor and IDE.<br>
  **Learn Lazyvim** with [this fantastic book](https://lazyvim-ambitious-devs.phillips.codes/).
1. Visual Studio Code - the other most popular IDE out there. For us filthy casuals who haven't learned Neovim yet. The main reasons to use this other than the plugins and language servers and built in terminal are the MULTIPLE CURSORS.
1. Obsidian - An incredibly powerful knowledge database. Organize information, take notes, manage projects, etc.  You can do A LOT with this, this is a very deep rabbit hole.
1. Signal - the best messenger ever. Open source and end-to-end encrypted.
1. Discord - You know what this is.
1. Element - an open source, privacy focused Discord alternative. E2E encrypted and runs on the distrubted Matrix network.  Comes pre-baked with better E2E encryption than even Signal.
1. Alfred - A spotlight replacement that is easily the most powerful launcher out there.  I recommend paying for a full PowerPack license to unlock the amazing tools and automation this thing has.<br>
In particular, I cannot imagine life without its clipboard history manager.
1. Rectangle - The best MacOS window manager. Comes with great default keymaps and a wide assortment of window tiling options.
1. Spotify - you know what this is too.
1. Many of the hot new terminal apps. btop, zoxide, lazygit, lazydocker, etc.
1. Steam - it's for games.
1. Furnace - a free and open source chiptune music tracker. Supports nearly every game system and chipset out there.
1. Nerd fonts - Some of my favorites are included. These are for your terminal, IDE, and system fonts.  I configured everything to use `JetBrainsMono Nerd Font Mono` by default. Because it's the best one.

And much, much more! To see everything this is installing, open the various `Brewfile-*` files under the `install.d/[your os]` folder.

### MacOS: Use Alfred instead of spotlight and pay for the PowerPack

Clear your Spotlight keyboard shortcut, and set the Alfred keyboard shortcut to `Command+Space`.

Buy the PowerPack. It is a very powerful launcher that goes far beyond launching apps and doing basic searches.  It has powerful automation and custom tooling and workflows for power users.

It also has a clipboard history manager, which is a major life improvement if you've never used one before. If you have the Powerpack, go to Settings -> Features -> Clipboard History, set a good keyboard shortcut, and give it a spin.

#### Homebrew

This is using [Homebrew](https://brew.sh/) to install all of these apps. You're using Homebrew for installing and updating apps now, so learn to use it. You do this in the terminal. See below.

```bash
brew update
brew upgrade
```

Figure out how to install your favorite apps by Google-ing "homebrew myapp".

## What is this configuring?

Great question, I love your diligence and enthusiasm. The configuration scripts are any file with an `.sh` extension under the `install.d/` folder, and `install.d/[your os]`. Everything in the script will be commented to tell you what it is doing. Review these files before running the `install.sh` script.

If you see something you don't want, DON'T DELETE IT! Insert a `#` in front of the line(s) you don't want to be run, and it will disable them. This allows you to control what the script is doing, but also keep the lines there just in case you change your mind later.

#### GNU Stow

This is using GNU Stow to create sylinks to config dotfiles here in the repository.  However you probably already have a few of these on your system.

That is why `stow` is `adopt`-ing any of these files you have first. Look it up.  Then it will `stow restow` to cleanly install the dotfiles.

Anyway your config files are in this repo now, now the question is, which of these do you want to keep? Because if you want MY configs, you need to blow these out by `git rebasing`. The script will prompt you when it's time to do this. If you don't have your own dotfiles or know what a dotfile is, just choose `yes` when it asks you.

This is creating symbolic links from the system locations to this repository, so make sure you cloned it somewhere you won't lose it.

## What else is this doing?

Gosh, um:

1. Creating a list of handy folders under you `$HOME` directory. The list is found in the `install.d/directories.sh` script.
1. Changes your desktop wallpaper (optional) - I'm sure you like yours, but I think mine is better. In the future I'm going to include different wallpapers for different theme choices, but that is not ready yet. Right now you get my wallpaper and `Tokyo Night`, and you're going to LIKE IT.
1. Installs Oh-My-Zsh with plugins to make your shell experience real nice.
1. Uses `mise` to install and manage programming languages.
1. Gives me a lot of agitation to maintain. I hate complicated Bash scripting, it is seriously heartburn inducing. I did this all for you, so you can thank me with beer and Prilosec.

## TODO

1. Add Linux. Debian systems first, specifically Kubuntu and Kali (Gnome only), since that's what I'm rocking.
1. I just found out Homebrew for linux doesn't support casks (GUI applications) so I'm probably going to use Nix or something with cross-compatibility for that.
1. Add theme and font selection.
1. Add a nice after-first-run script for making changes without all the first run nonsense.
1. Add support for selecting and installing databases via docker.
1. Expand devops tooling bigtime. Review recommended lists on youtube.
1. Add more artist/creative apps. Bug Ardour to clean up their complicated installation nonsense so they can be put on Homebrew.
1. I already spoke to TildeArrow (Furnace creator) about getting Furnace on Homebrew for them, so I will work on that.  However it seems like I won't be able to use Homebrew casks to also copy over all the stuff they stuff in the package, like manuals and instruments and demo songs and what-have-you, so I may just leave the code as-is.
1. Fine tune what apps I'm installing and plugins/configs I'm adding.  I'm brand new to Neovim and not sure about some of my choices regarding [Mini.nvim](https://github.com/nvim-mini/mini.nvim)

## License

G's Dotfiles is released under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license.

## Contributing

I would much prefer if this were a community effort to figure out what YOU want on your systems, and I could really use you `bash` wizards out there to help maintain this because this was NOT fun to write (Bash is trash for scripting and you all know it). You know the drill: file an issue for bugs or Feature Requests if there isn't already one there, be respectful, and fork it/open a PR if you have something to fix or add.  Just know that I have a lot on my plate and I don't have a lot of time to keep my eye on this, but I'll do my best. Thank you.

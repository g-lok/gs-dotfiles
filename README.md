# G's-Dotfiles

G's installation and configuration scripts for MacOS and Linux.

![Logo](logo.png)

Heavily influenced by [Omakub](https://omakub.org/).

## What this be

This is a curated collection of app installation and configuration scripts for MacOS and Linux (coming soon).

It is designed to provide a simple and aesthetic experience for users of all kinds, and to provide the best (opinionated) choices for any environment.

It is also designed to provide most of the [Omakub](https://omakub.org/) functionality, without the restrictions of requiring Ubuntu Gnome. It contains many of my own personal touches, from App choices, to MacOS configurations, and more.

## How it do

1. (MacOS)
   1. Open Terminal. Type "git".
   1. Install the Xcode utilities Mac just prompted you. If it didn't, you already have it.
1. Run the following command: <br>

```bash
eval "$(wget -qO- https://raw.githubusercontent.com/g-lok/gs-dotfiles/refs/heads/master/boot.sh)"
```

1. Follow the prompts. Do what I say.
1. You're done!
1. Restart your machine.

## Application highlights

1. [Brave](https://brave.com/)- A privacy-oriented web browser. Also includes Chrome and Firefox.
1. [Libreoffice](https://www.libreoffice.org/)- Free and open source office suite.
1. [Ghostty](https://ghostty.org/)- A fantastic terminal emulator replacement for whatever hot garbage came with your OS.<br>
   [Learn to use the terminal](https://linuxcommand.org/tlcl.php). If you aren't already, start learning, it will dramatically improve your life.
1. [Zellij](https://zellij.dev/)- The session manager inside of Ghostty. Like tmux. Sessions, panes, tabs, etc. Check the hotkeys I set up.
1. [Lazyvim](https://www.lazyvim.org/)- A curated Neovim with all the nice plugins and configurations. A powerful text editor and IDE.<br>
   **Learn Lazyvim** with [this fantastic book.](https://lazyvim-ambitious-devs.phillips.codes/).I held out for a long time, but once I made the switch, I can never go back. Neovim really DOES live up to the hype.
1. [Visual Studio Code](https://code.visualstudio.com/)- For all you filthy casuals. I still use this for multi cursors while I clumsily try to learn neovim.
1. [Obsidian](https://obsidian.md/) - An incredibly powerful knowledge database. Organize information, take notes, manage projects, etc. [Learn how to use it right from the CEO](https://stephango.com/vault).
1. [Signal](https://signal.org/) - the best messenger ever. Open source and end-to-end encrypted.
1. [Discord](https://discord.com/) - You know what this is.
1. [Element](https://element.io/en/app) - an open source, privacy focused Discord alternative. E2E encrypted and runs on the distributed Matrix network.
1. [Alfred](https://www.alfredapp.com/) - A spotlight replacement launcher. I recommend paying for a full PowerPack license to unlock the amazing tools and automation this thing is capable of.
1. [Rectangle](https://rectangleapp.com/) - My favorite window manager. Comes with great default keymaps and a wide assortment of window tiling options.
1. [Spotify](https://open.spotify.com/) - you know what this is too.
1. Many of the hot new terminal apps. btop, zoxide, lazygit, lazydocker, etc. Look at the list and learn some.
1. hledger/ledger - FOSS CLI plaintext accounting tools. Unlock the power.
1. [Steam](https://store.steampowered.com/) - You probably didn't know this, but it's for games.
1. [Furnace](https://tildearrow.org/furnace/) - a free and open source chiptune music tracker. Supports nearly every game system and chipset out there.
1. [Nerd fonts](https://www.nerdfonts.com/) - Some of my favorites are included. These are for your terminal, IDE, and system fonts. I configured everything to use `JetBrainsMono Nerd Font Mono` by default.

And much, much more! To see everything this is installing, open the various `Brewfile-*` files under the `install.d/macos` folder.

#### Homebrew (MacOS)

This is using [Homebrew](https://brew.sh/) to install all of these apps. You're using Homebrew for installing and updating apps now. You do this in the terminal. See below.

```bash
brew update
brew upgrade
```

Figure out how to install your favorite apps by Google-ing "homebrew [whatever app]", or using `brew search [blah]`.

## What is this configuring?

Apps and system configs that MacOS hides from you, mostly.

#### GNU Stow

This is using GNU Stow to manage the various config files by symlinking them into `~/dotfiles`. If you don't know what any of that means, don't worry about it, just hit `ctrl+a` when I tell you to and know I've got you covered.

If you are managing your own dotfiles, I haven't figured out a graceful way to force this to work on anything already symlinked somewhere else. I ended up backing everything up and nuking every symlinked config I could find and brute forcing everything. I'll think of a better way to do this using a real scripting language later, but this should work for now.

Oh you should probably create a private github repo to manage your own dotfiles in that directory. If you don't know git, learn it. [The Primagen's git course on boot.dev](https://youtu.be/rH3zE7VlIMs?si=PtIbL-UPwx6qvv4t)

## What else is this doing?

Gosh, um:

1. Creating a list of handy folders under you `$HOME` directory. The list is found in the `install.d/directories.sh` script.
1. Changes your desktop wallpaper (optional) - I'm sure you like yours, but I think mine is better.
1. Installs Oh-My-Zsh with plugins to make your shell experience real nice.
1. Uses `mise` to install and manage programming languages, tooling, packages, build systems, etc.
1. Includes AI tools like Opencode and Windsurf. I don't feed the clankers though, and I judge humanity for falling for this obvious trap.
1. Gives me a lot of agitation to maintain. I HATE complicated Bash scripting, it is seriously heartburn inducing. I did this all for you, so you can thank me later with beer and Prilosec.

## TODO

1. Re-write this ENTIRE thing in Python and Textual or some nifty TUI library. Seriously, Bash scripting is THE WORST, ESPECIALLY on jank ass MacOS. EVERYTHING ELSE on this list becomes SO MUCH EASIER in a real programming language.
1. Fix the GNU Stow/dotfile issues with some fancy python and templating.
1. Add Linux. Debian systems first, specifically Kubuntu and Kali (Gnome only), since that's what I'm rocking.
1. I just found out Homebrew for Linux doesn't support casks (GUI applications) so I'm probably going to use Nix or something with cross-compatibility for linux GUI apps.
1. Add theme and font selection.
1. Add a nice after-first-run app for making changes without all the first run nonsense.
1. Add support for selecting and installing databases via docker.
1. Expand devops tooling bigtime. Review recommended lists on youtube.
1. Add more artist/creative apps. Bug Ardour to clean up their complicated installation nonsense so they can be put on Homebrew.
1. Add more games? I dunno I'm not really into free games, Minecraft etc.
1. Fine tune what apps I'm installing and plugins/configs I'm adding.

## License

G's Dotfiles is released under the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) license.

## Contributing

I would much prefer if this were a community effort to figure out what YOU want on your systems, and I could really use you `bash` wizards out there to help fix it up while I plan out the refactor, because this was NOT fun to write (Bash is trash for scripting and you all fucking know it). You know the drill: file an issue for bugs or Feature Requests if there isn't already one there, be respectful, and fork it/open a PR if you have something to fix or add.

Just know that I have a lot on my plate and I don't have a lot of time to keep my eye on this, but I'll do my best.

Also, it pains me that I have have to say this, but NO AI SLOP PLEASE. This is a no-clanker, artisinal, hand crafted coding zone here.

Thank you.

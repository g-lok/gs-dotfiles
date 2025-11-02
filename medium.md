# G's Dotfiles

## Dotfiles and Installation scripts across MacOS and Linux Envs

### Inspired by Omakub

Well I had a new programming project to tackle (more on that later), but it required an x86 system to compile, which meant my older inteli x86 MBP, which meant I had to get it up to date with my new development environment.  This was a good a reason as any to update my dotfiles and installation scripts.

I'm going to be reverse engineering Omakub for inspiration, along with several other sources and my own little magic, to make this more customizable and applicable across multiple OSes (starting with Kubuntu and Kali linux, and aiming for Arch down the road).

## Breaking down Omakub

[Omakub](https://github.com/basecamp/omakub)
is an Omakse-inspired development environment tailored specifically for Gnome.  It is "chef's choice" so-to-speak, in that it is extremely opinionated, highly curated, and beautiful.  We're going to do something similar, but more customizable so my non-dev friends can still use this. I also have a lot of different systems for different use cases, so I want this to be able to install and configure different packages depending on what I need.

Omakub's development environment centers itself around gnome's desktop and tooling, including desktop tools and applications for windows management and the app dock and things like that. It comes with a bevy of fantastic desktop apps like Spotify, Signal, and Obsidian, etc, but the stars of the show are Alacritty and Zellij for its terminal emulator and tumx-style multiplexer (think modern sessions and panels and tabs, etc.), along with lazyvim as its IDE.  Lazyvim is a pre-configured Neovim with the Lazy package manager, and a its own preconfigured plugins and what-have-you. It also has VSCode if that's more your thing.

I've always wanted to learn neovim/lazyvim so I'm using this as an excuse to start my journey. I'm using this book: [Lazyvim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes/) to learn lazyvim and googling whatever comes up along the way. I'm VERY excited about this.

Omakub splits its installation scripts into terminal apps and desktop apps, with subdivisions in each category. We'll do the same.  It tends to install things via apt, or directly using curl/wget, which we will NOT be doing.

It is also "direct" in how it manages the config files, typically just copying things around via `cd`.  Again, we are not doing that.  In order to keep this simple but also maintain our dev environment across all devices, we will be using GNU Stow, which basically takes the folders and files in your dotfiles git project, and reproduces the folder structure and files on your system by creating symlinks to the git directory.  This makes syncing things in the future really, really easy, and prevents drift between all your devices.

### Gum and our package manager - HomeBrew

If you look at the Omakub installation scripts, it's using [Gum](https://github.com/charmbracelet/gum) to make things pretty and take in user input.

That's what we're going to use. Omakub uses shell scripts to directly install this but I'd rather use a package manager.  In this case gum supports [Homebrew](https://brew.sh/), which we can use for both linux and MacOS. I already use Homebrew for MacOS so it's easier to adapt my existing Brewfiles. Also I had a lot of problems using apt as my package manager in kali and kubuntu when hacked Omakub to get it working on them, so hopefully I'll fare better with Homebrew.

Yes I'm aware that Nix exists and maybe (probably) is superior, but Homebrew has served me well and I already have the Brewfiles.

The fact Omakub uses Gum is a funny coincidence, since my buddy showed me the [Charm Bracelet Site](https://charm.land/) a few months ago, and my response was "God I wish I had something like this for shell scripts and Python. Too bad it's only for Go..." and now we're here. I should look more carefully at these things.

```bash
## Install Homebrew
if [[ $(command -v brew) == "" ]]; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >/dev/null
else
  echo "Homebrew is already installed. Updating..."
  brew update
  brew upgrade
fi

## Temporarily load Homebrew's config and PATH and whatnot

command -v brew >/dev/null || export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin" >/dev/null
command -v brew >/dev/null && eval "$(brew shellenv)" >/dev/null

## Install gum
if [[ $(command -v gum) == "" ]]; then
  brew install gum >/dev/null
else
  echo "Gum already installed"
fi
```

### Script organization

We're going to start with a main installation script in the home folder that will gather system and user information, install base dependencies like Homebrew and Gum, and launch installation and configuration scripts depending on the system and user choices.

Because of the way `gum spin` works I can't source scripts nicely or have too many layers running, since it can't take user input and won't display errors. I also didn't like how complicated Omakub's script organization was, so I will try to keep things more centralized and simple.

I would like to keep as many scripts as universal as possible between all the systems to avoid drift and duplication, but that may be a pipe dream. I'll attempt it anyway.

#### Omakub script organization

Installation scripts are under the `install` folder. Configs are in the `configs` folder. All the gum installation scripts are under the `bin` folder.

## My Game Plan

Before I dive in, let's get a basic game plan for the MacOS portion so I'm not completely freewheeling this from the get:

1. Basic sanity checks and variable assignments.
1. Start a sudo session with `sudo --validate` so it will hopefully be cached for any commands that require it, because these scripts will be run under `gum spin` and `gum spin` hides prompts and won't allow user input.
1. Install Homebrew and gum. Temporarily add appropriate Homebrew bin locations to `$PATH` so we can use gum, git, and anything else the scripts are going to need.
1. Start the Gum scripts. Make it look NICE. My logo was generated at an [Ascii Art Generator](https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type+Something+&x=none&v=4&h=4&w=80&we=false).
1. Get all the user input and options.
1. Create all the home folders I use (if they're not already there).
1. Install all the gnu terminal apps MacOS doesn't come with by default. Make them the default in the system by giving their path the priority.
1. Install the rest of the cool default terminals apps.
1. Install the desktop apps.
1. Install optional dev stuff, devops tools, dbs, etc.
1. Install Oh-My-Zsh and chosen plugins.
1. Run all the MacOS config scripts. Update them for Tahoe one of these days.
1. Use Stow to symlink the dotfiles and configs. This may require different files and folders than our linux stuff but try to keep MacOS and Linux as linked as possible.
1. Is there a way to automatically add virtual desktops to MacOS and configure their keyboard shortcuts? Or am I just a dreaming fool?
1. Does lazy automatically install stuff from your config files or do I have to git clone stuff? I may have to do that for all the [mini.nvim](https://github.com/nvim-mini/mini.nvim) suite of plugins. No it grabs them for you, I'm thinking of [Oh-My-Zsh](https://github.com/andyfleming/oh-my-zsh). You do have to git clone some stuff for that. Thankfully I already have a script handy for that.

## Getting to it

Let's do this.

### Shebangs

Don't forget to use a shebang that looks for the environment bash and not whatever hard linked one you may be using.

```bash
#!/usr/bin/env bash
```

### Verbosity

My original scripts set verbose output. I tested this and it is clear I definitely DO NOT want verbose output.  I'll set things to whatever Omakub sets it to:

```bash
set -e
```

### Ascii Art

I used one of those ascii art websites with the Graffiti font to generate my banner:

```bash

ascii_art='  _______/\        ________          __    _____.__.__                 
 /  _____)/ ______ \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \   |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
 \______  /____  > /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/          \/                                \/     \/ '

```

I can't figure out how to paste this in lazyvim without everything getting screwed up.  Even the original string I copied that looked fine in the script looks completely mangled when I echo it to the terminal.  I need to figure out how to copy/display that string correctly.

UPDATE! I fixed this using a `here document`:

```bash
cat <<"EOF"
  _______/\        ________          __    _____.__.__                 
 /  _____)/ ______ \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \   |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
 \______  /____  > /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/          \/                                \/     \/
EOF

```

The Omakub scripts has this in their boot.sh script, which is the first script that launches everything.  It also has a script devoted entirely to making the banner colored and pretty, but that script never appears to be called by anything else, so I don't know how it works or why it's there. That's a problem for later, I'll just copy Omakub if need be.

### sudo --validate

Because `gum spin` doesn't notify the user of any prompts, I need to cache a `sudo` session for any commands that may require it down the road.

### Launch Gum Scripts and Get User Choices

So [here's](https://github.com/charmbracelet/gum?tab=readme-ov-file#commands) what Gum can do, in a nutshell. We need to figure out what options we're giving the user, the actions being taken, and how to make this look good along the way. We also need to figure out how to organize the scripts and how we're running/sourcing them.

Speaking of running/sourcing scripts, I recently learned the hard way that actually running scripts from other scripts isn't the greatest idea, and if alacritty or zellij detect an exit code from something like a script it will close the panel the exit code came from. So instead of that, `source` your scripts from other scripts, and if you need to exit under some condition use `return` instead of exiting.

Unfortunately trying this with things like gum spinner didn't work, it wants an executable, so I had to run the scripts directly in those cases.

### The Colors, Man

During testing I noticed that the colors of my style messages and whatnot, um, sucked.  Rather than set them each time they're called, you can set environment variables like `$BACKGROUND` and `$FOREGROUND` using a 3 digit hex color.

```bash
export FOREGROUND="#FF0"
export BACKGROUND="#0BB"
export BORDER_FOREGROUND="212"

## Let's get started
gum style \
  --border double \
  --align center --width 50 --margin "1 2" --padding "2 4" --bold "Gs-Dotfiles" "Let's get started!"
```

To my surprise and delight, I discovered that lazyvim automatically displays the actual color the string is coding for directly in the editor.  Very handy!

### Get user input

We're going to use `gum` to gather the user input required for the rest of the scripts. Here is what we will need:

1. Full name.
1. Email.
1. Password. This is so we can pipe it into any commands that aren't respecting the `sudo` session up there.
1. Optional App installation categories
1. Whether they want their desktop background replaced.
1. TODO: What theme they want to use.

### App installation Choices

I don't really want to give the user choices of installing this app or that, I'd rather stick to larger collections they can choose to install or not, like developer tools or artist tools.

```bash
## Get installation choices
OPTIONAL_CATEGORIES=("Developer Tools" "DevOps tools" "Artist Tools")
export APP_CATEGORIES=$(gum choose "${OPTIONAL_CATEGORIES[@]}" --no-limit --header "Select optional application categories to install.")
```

I probably want to dial in questions about what mise programming languages or databases to install if the user selected Developer Tools, but I'll worry about that later. Right now they're getting all the languages *I* want, and no dbs for now.

We'll have to split up the script between Linux and Darwin again. This time I'm going to run a OS specific script that does all my installation duty stuff through `gum spin`.

In order to split my scripts up I'm going to modify that code block I already wrote up there, and set a variable that determines whether I'm on MacOS, Linux (GUI), or Linux (Headless).

```bash
case "$OS" in
"Linux")
  # Add Linux-specific commands here
  if [ -n "$DISPLAY" ]; then
    echo "Running on Linux (GUI)"
    export SCRIPT_OS="linux_gui"
  else
    echo "Running on Linux Headless"
    export SCRIPT_OS="linux_headless"
  fi
  ;;
"Darwin")
  echo "This script is running on macOS."
  export SCRIPT_OS="MacOS"
  ## Add macOS-specific commands here
  ## Install XCode Tools (required for Homebrew)
  if pkgutil --pkg-info=com.apple.pkg.CLTools_Executables >/dev/null 2>&1; then
    echo "Command Line Tools are installed"
  else
    echo "Command Line Tools are not installed"
    xcode-select --install >/dev/null
  fi
  ;;
*)
  echo "This script is running on an unknown operating system: $OS"
  # Add commands for other systems or error handling
  exit 0
  ;;
esac

```

#### MacOS apps

There's a ton I'm including here and too much to list in this article, but you can check out the Brewfiles in the git repo to see what comes included.  Here are the highlights:

1. GNU terminal apps - MacOS comes with a bunch of terminal apps that aren't the versions used by the rest of the world.  We're not playing that game. Replace all of them with the GNU versions and we'll place the path to them at the top of `$PATH` to bury these charlatan versions.
UPDATE: Homebrew warned me about sourcing the unprefixed versions of these GNU versions to my `$PATH`, and I will respect its warning. They're still getting installed though.
1. Missing terminal apps - MacOS is missing a lot of things you would expect to be on here like `wget`, but alas, they are not.  They will be installed by yours truly.
1. Updated terminal apps - MacOS ships with ancient versions of things we need, like Python, Bash, and Zsh.
1. Speaking of Zsh, I also have a separate script to install Oh My Zsh along with several plugins for stuff like autocomplete, etc.
1. GNU Stow - Because I'll need it for all the dotfile configs later.
1. Improved terminal apps - The hot new stuff replacing the old guard. Apps like `btop`, `bat`, `zoxide`, etc.
1. Fancy terminal app - Stuff like `lazygit`, `lazydocker`, `fastfetch`, and more.
1. Programming languages - Python, Go, Node, Rust, etc. I'm not sure if I should be installing these via Homebrew if I'm using mise for them later but I'll find out soon enough.
1. Neovim/Lazyvim, the bestest text editor and IDE.
1. Visual Studio Code - Also a very good IDE
1. Alacritty w/ Zellij - Omakub (and my) terminal emulator and modern tmux-style sessioin manager/workspace of choice.
1. Some of my favorite [Nerdfonts](https://www.nerdfonts.com/). Typically monospace, clean but distinct looking, and with all the nerd ligatures you need for LazyVim and Alacritty.
1. Obsidian - An absurdly powerful knowledge database. For organizing information, notes, projects, all kinds of stuff. I've been meaning to get into this too but it is a DEEP rabbit hole.
1. The Browsers - Brave, Firefox, Chrome, Tor.
1. The password manager - Omakub uses 1Password.  I prefer KeepassXC, because it's free and open source.
1. The messaging apps - Signal, Discord, Element (like discord but for the distributed Matrix network and pre-baked with stronger E2E encryption than even Signal).
1. Rectangle - pretty sweet windows manager with good default keyboard shortcuts and lots of options for window placement.
1. Libreoffice - Because what else am I supposed to use?  LOL j/k I pay for a Google Business account.
1. Artist tools like Gimp and Krita. I really want to find a decent free DAW for music, but none of the ones I could find are available via package managers or Github. However, I DID find something really cool...

##### Installing Furnace

One of the best apps I have on my list is a free, open source, cross platform chiptune music tracker called [Furnace](https://tildearrow.org/furnace/). It supports nearly every video game system and music tracker chipset in existence in a very handy tracker DAW editor, my preferred way of making music. It is bonafide RAD.

Unfortunately, it isn't on Homebrew and they expect you to install it via packages on their Github releases like a filthy casual.  I put in a request for them to get with the times but I'll need to install this manually in my scripts for now.

This is a challenge because in order to mount a package in MacOS I need to use `hdiutil`, which doesn't respect the `sudo` session we already established earlier. And as we already mentioned, `gum spin` will not let us know that something is prompting for user input.

Therefore, I need to get the user's password earlier in the script and export it as an environment variable, because `hdiutil attach` has a `-stdinpass` option that will take the password from stdin. Wonderful!  Unfortunately `hdiutil detach` does NOT have that option, so I can't unmount it once we're done.  Nice one Apple, real smooth.

Dear Furnace maintainers: please get yourselves on some package managers for cripe's sake.  And keep them up to date while you're at it. Thank you.

I'm going to separate the installation of `Furnace` into its own function so I can keep the other installation sections of the script relatively clean.

```bash
## Function to install Furnace
install_furnace() {
  OWNER="tildearrow"
  REPO="furnace"
  if [[ $CHIPSET == "ARM64" ]]; then
    ASSET_NAME="mac-arm64"
  else
    ASSET_NAME="mac-intel"
  fi

  ## Fetch the latest release and extract the browser_download_url for the macOS asset
  curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/latest" |
    jq -r ".assets[] | select(.name | contains(\"$ASSET_NAME\")) | .browser_download_url" |
    xargs -I {} curl -L -o "furnace_latest_mac_release.dmg" {}
<ScrollWheelDown>
  printf "$PASSWORD" | hdiutil attach -stdinpass "furnace_latest_mac_release.dmg"
  printf "$PASSWORD" | sudo -S cp -R "/Volumes/Furnace/Furnace.app" "/Applications/"
  mkdir -p "$HOME/Documents/Furnace"
  printf "$PASSWORD" | sudo -S cp "/Volumes/Furnace/manual.pdf" "$HOME/Documents/Furnace/"
  printf "$PASSWORD" | sudo -S cp -R "/Volumes/Furnace/demos/" "$HOME/Documents/Furnace/"
  printf "$PASSWORD" | sudo -S cp -R "/Volumes/Furnace/instruments/" "$HOME/Documents/Furnace/"
  printf "$PASSWORD" | sudo -S cp -R "/Volumes/Furnace/wavetables/" "$HOME/Documents/Furnace/"
  rm "furnace_latest_mac_release.dmg"
}
```

### MacOS Configuration

One of the main reasons I originally created this repo was because the default MacOS experience is ATROCIOUS, and needs to be rectified immediately.  Thankfully you can configure just about anything via the command line, which is what we're going to do.

I stole most of my configs from [La Clementine](https://medium.com/@laclementine/dotfile-for-mac-efe082ad0d6a). I went through them and commented out some things I didn't want, but most of them are there. Note that these were made for Sequoia. They still work, but there's probably some newer Tahoe stuff I need to add.

I also included some of my own, such as

1. Dramatically increasing the keyboard speed.
1. Setting up a screenshots folder.
1. Changing dock behavior.  I used to set this up to hide all apps unless they were opened, because I use a launcher to launch apps. However I'm considering using scripts to add specific apps similar to what is on Omakub's dock.
1. I also set my desktop background, which has served me well for the last 10+ years, and I think is a much nicer and unobtrusive choice compared to Omakub. It's a Victorian style black and white wallpaper pattern that sits nicely in the background, and matches just about any app or theme.

### The Dotfiles

Ok, we're at the final stretch. Everything should be installed and MacOS is configured. Now we need to configure our apps. Most of these apps use dotfiles, which are basically just text configuration files in TOML or similar formats.  There's also the zsh and bash configuration scripts we'll need for setting up `$PATH`, aliases, prompt, etc.

These all go into a folder that needs to represent the destination they're going to be symlinked to by GNU Stow.  This will be the user's `$HOME` folder.

I also create a `.shellrc` folder that contains scripts with double digit numerical prefixes, which will be sourced by whatever shell the user is using.  This allows us to source shell scripts in a particular order. The code that calls these scripts looks like:

```bash
## Load shell scripts
if [ -t 1 ]; then
  if [ -d $HOME/.shellrc/ ]; then
    for file in $HOME/.shellrc/*.sh; do
      [ -e "$file" ] || break
      source "$file"
    done
  fi
fi
```

Some of these scripts are for setting up bash specific things like a nice terminal prompt, which is handled in zsh by `Oh My Zsh`, so those scripts will `return` out if being sourced by zsh:

```bash
if [ ! -n "$BASH_VERSION" ]; then
  return
fi
```

The two main scripts I'm using for bash that I either don't want `zsh` loading, or may break something, are the Sexy Bash Prompt and Sensible Bash scripts I copied ages ago.  They still work so I'm keeping them.

I noticed while compiling these together that most of the dotfiles are going to be the same between MacOS and Linux, so I'm going to move these out into a shared folder.

The main difference is that the `zsh` config has a different filename on each system. MacOS uses `~/.zshrc` and Linux uses `.zprofile`. I'm not sure how to address this cleanly using `stow` but I'll figure it out later when I add all the linux stuff.

### Themes

Omakub comes with several themes that are applied to numerous application configuration files, along with a desktop image to go along with it.  These are found in the `themes/` folder. I'm going to just copy this over and figure out how to apply different themes later. You're all getting `Tokyo Night` and my wallpaper for now.

### Wrapping up

There's still a major bug with application choices I need to fix, but I'm going to wrap this up for now and get to testing.  `README.md` has been completely re-written, with some choice Ascii art if I say so myself.

Lots of little things were attended to, like pinning apps to the dock:

```bash
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/YourAppHere.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
```

### Testing

How the heck do I test this on a new MacOs installation? I can't afford to buy another one.

That's where `UTM` comes in. It's one of the virtual machine managers I included with the developer tools. It will use your current mac credentials to authorize new MacOs virtual machines. Very handy.

## Ascii Art

What kind of project would this be without some ascii art?
I went to this [ascii art](https://fsymbols.com/text-art/) website that generates ascii art text AND has stock art of cats and memes and stuff.  I took one of their stock art pieces along with generated text split in two (so it would fit). I used VSCode to superimpose the text on the stock art line by line, and extend the background using multiple cursors.

Github cut the text off at the edge, so I figured I'd use a screenshot instead. And if I'm taking a screenshot, I might as well add some color. I used the [gradient string](https://github.com/bokub/gradient-string) node package for generating text with nice color gradients. Here's my code for that:

```node
import { retro, vice, atlas } from 'gradient-string';

var ascii = `
░░░░░░░░░░░░░▄▄▄████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░▄▄█████████████░░░░▄███░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░▄████████████████▄▄████▀░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░▀████████████████████▀░░░░░░░░░░░░░░░░██████╗░██╗░██████╗░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░███████████████▀░█▀░░░░░░░░░░░░░░░░░░██╔════╝░╚█║██╔════╝░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░▀█░░░░▀▀▀▀▀░░░░░░░▀▄░░░░░░░░░░░░░░░░░██║░░██╗░░╚╝╚█████╗░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░█░░░░░░░░▀▀▀▄░░░░▀█▄░░░░░░░░░░░░░░░░██║░░╚██╗░░░░╚═══██╗░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░░█░░░░░▄▄▀██▀█░▄▀▀█▀█░░░░░░░░░░░░░░░░╚██████╔╝░░░██████╔╝░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░░▄█▄░░░░▀▄░░░▄▀░░▀▄▄▄▀░░░░░░░░░░░░░░░░░╚═════╝░░░░╚═════╝░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░█▄▄▄░░░░░░███▄▄▄▄░░░█▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
░░░░░░░░▀▄█▄░░░░░░▄▀░░░░▀▀▀▀░░▀▄░░░░██████╗░░█████╗░████████╗███████╗██╗██╗░░░░░███████╗░██████╗░░░
░░░░░░░░▄▄█░░░░░░█░░░░░░░░░░░░░░█░░░██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██║██║░░░░░██╔════╝██╔════╝░░░
░░░░░░░████░░░░░█░░▄▀▄▀▄▀▄▀▄▀▄▀▄█░░░██║░░██║██║░░██║░░░██║░░░█████╗░░██║██║░░░░░█████╗░░╚█████╗░░░░
░░░▄▄█████░░░░░░▀▄▀░░░░░░▄█░░░░░░░░░██║░░██║██║░░██║░░░██║░░░██╔══╝░░██║██║░░░░░██╔══╝░░░╚═══██╗░░░
▄█████████▄░░░░░░░░░░░░▄█░░░░░░░░░░░██████╔╝╚█████╔╝░░░██║░░░██║░░░░░██║███████╗███████╗██████╔╝░░░
██████████▀▀▄▄▄░░░░░▄███▄░░░░░░░░░░░╚═════╝░░╚════╝░░░░╚═╝░░░╚═╝░░░░░╚═╝╚══════╝╚══════╝╚═════╝░░░░
██████████░░░░▀▀▀▀▀▀▀░████▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
███████████▄▄▄▄▄▄▄▄▄▄▄██████▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
██████████░░░░░░░░░░░░█████▄░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
`
console.log(atlas(ascii));

```

## Where the heck do I find this?

[Get it while it's hot!](https://github.com/g-lok/gs-dotfiles)
Signing off for now...

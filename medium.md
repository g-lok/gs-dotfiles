# G's Dotfiles

## Dotfiles and Installation scripts across MacOS and Linux Envs

### Inspired by Omakub

Well I had a new programming project to tackle (more on that later), but it required an x86 system to compile, which meant my older inteli x86 MBP, which meant I had to get it up to date with my new development environment.  This was a good a reason as any to update my dotfiles and installation scripts.

I'm going to be reverse engineering Omakub for inspiration, along with several other sources and my own little magic, to make this more customizable and applicable across multiple OSes (starting with Kubuntu and Kali linux, and aiming for Arch down the road).

## Breaking down Omakub

[Omakub](https://github.com/basecamp/omakub)
is an Omakse-inspired development environment tailored specifically for Gnome.  It is "chef's choice" so-to-speak, in that it is extremely opinionated, highly curated, and beautiful.  We're going to do something similar, but more customizable so my non-dev friends can still use this. I also have a lot of different systems for different use cases, so I want this to be able to install and configure different packages depending on what I need.

Omakub's development environment centers itself around gnome's desktop and tooling, including desktop tools and applications for windows management and the app dock and things like that. It comes with a bevy of fantastic desktop apps like Spotify, Signal, and Obsidian, etc, but the stars of the show are Alacritty and Zellij for its terminal emulator and tumx-style multiplexer (think modern sessions and panels and tabs, etc.).  The recommended IDE is lazyvim, a pre-configured Neovim with the Lazy package manager, and a its own preconfigured plugins and what-have-you. It also has VSCode if that's more your thing.

I've always wanted to learn neovim/lazyvim so I'm using this as an excuse to start my journey. I'm using this book: [Lazyvim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes/) to learn lazyvim and googling whatever comes up along the way. I'm VERY excited about this.

Omakub splits its installation scripts into terminal apps and desktop apps, with subdivisions in each category. We'll do the same.  It tends to install things directly using curl/wget, which we will NOT be doing.

I think it is also "direct" in how it manages the config files.  Again, we are not doing that.  In order to keep this simple but also maintain our dev environment across all devices, we will be using GNU Stow, which basically takes the folders and files in your dotfiles git project, and reproduces the folder structure and files on your system by creating symlinks to the git directory.  This makes syncing things in the future really, really easy, and prevents drift between all your devices.

### Gum and our package manager - HomeBrew

If you look at the Omakub installation scripts, it's using [Gum](https://github.com/charmbracelet/gum) to make things pretty and take in user input.

That's what we're going to use. Omakub uses shell scripts to directly install this but I'd rather use a package manager.  In this case gum recommends [Homebrew](https://brew.sh/), which we can use for both linux and MacOS. I already use Homebrew for MacOS so it's easier to adapt my existing Brewfiles. Also I had a lot of problems using apt as my package manager in kali and kubuntu when I was hacking Omakub to get it working on them, so hopefully I'll fare better with Homebrew.

Yes I'm aware that Nix exists and maybe is superior, but Homebrew has served me well and I already have the brewfiles.

The fact Omakub uses Gum is a funny coincidence, since my buddy showed me the [Charm Bracelet Site](https://charm.land/) a few months ago, and my response was "God I wish I had something like this for shell scripts and Python. Too bad it's only for Go..." and now we're here. I should look more carefully at these things.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install gum
```

### Script organization

I would like to use folders, subfolders, and shell scripts with numbered prefixes to control what gets executed and when. Some scripts should be run on both MacOS and Linux, but some should only be run by their respective OSes.

#### Omakub script organization

Installation scripts are under the *install* folder. Configs are in the *configs* folder. All the gum installation scripts are under the *bin* folder. This isn't that complicated, thankfully.

## My Game Plan

Before I dive in, let's get a basic game plan for the MacOS portion so I'm not completely freewheeling this from the get:

1. Basic sanity checks and variable assignments.
1. Figure out if we're in bash or zsh. Design scripts to work with both, but we're installing a fresh zsh and slapping oh-my-zsh on that mug later.
1. Install Homebrew and gum. Source homebrew config in `.zprofile` and `.bashrc` so paths are working.
1. Start the Gum scripts. Make it look NICE. My logo was generated at <https://patorjk.com/software/taag/#p=display&f=Graffiti&t=Type+Something+&x=none&v=4&h=4&w=80&we=false>
1. Get all the user input and options.
1. Create all the home folders I use (if they're not already there). Maybe this should be one of those options, in case friends don't want these.
1. Install XCode. Or maybe only do this for dev installs.
1. Run all the MacOS config scripts. Update them for Tahoe one of these days.
1. Install all the gnu terminal apps MacOS doesn't come with by default. Make them the default in the system by giving their path the priority.
1. Install the rest of the cool default terminals apps.
1. Install the desktop apps.
1. Install optional dev stuff, devops tools, dbs, etc.
1. Install Oh-My-Zsh and chosen plugins.
1. Use Stow to symlink the dotfiles and configs. This may require different files and folders than our linux stuff but try to keep MacOS and Linux as linked as possible.
1. Is there a way to automatically add virtual desktops and configure their keyboard shortcuts? Or am I just a dreaming fool?
1. Does lazy automatically install stuff in your config files or do I have to git clone stuff? I may have to do that for the mini suite of plugins? No it gets them for you, I'm thinking of oh-my-zsh. You do have to git clone some stuff for that.

## Getting to it

Let's do this.

### Shebangs

Don't forget to use a shebang that looks for the environment bash and not whatever hard linked one you may be using.

```bash
#!/usr/bin/env bash
```

### Verbosity

My original scripts set verbose output. I'm not sure I want or need that anymore.

```bash
set -x
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

The Omakub scripts has this in their boot.sh script, which is the first script that launches everything.  It also has a script devoted entirely to making the banner colored and pretty, but that script never appears to be called by anything else, so I don't know how it works. That's a problem for later, I'll just copy Omakub if need be.

### Get username and relevant info

I used to do this because I was having the user run this as sudo and I wanted to make sure the scripts were doing their thing for the user and not root, but I don't know if that is actually necessary. Better safe than sorry I suppose.

```bash
export dotfiles_usr=$(env | grep SUDO_USER | cut -d= -f 2)
export dotfiles_usr_home=$(sudo -u $dotfiles_usr echo $HOME)
export dotfiles_wd=$(sudo -u $dotfiles_usr pwd)
```

### Sanity check: Exit if not being run as sudo

Can't be having that can we?

```bash
if [ "$EUID" -ne 0 ]; then
  echo "The script needs to run as root" && exit 1
fi
```

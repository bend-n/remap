# Input remapping tool

[![version](https://img.shields.io/badge/4.x-blue?logo=godot-engine&logoColor=white&label=godot&style=for-the-badge)](https://godotengine.org "Made with godot")
<a href='https://ko-fi.com/bendn' title='Buy me a coffee' target='_blank'><img height='28' src='https://storage.ko-fi.com/cdn/brandasset/kofi_button_red.png' alt='Buy me a coffee'> </a>

A tool that allows the remapping of `InputMap` actions in godot4.

## Features

[![image](https://raw.githubusercontent.com/bend-n/remap/main/.github/screen.png)](_blank "Some themage required")

Supports:

- Multiple joypad types:
  - Xbox
  - Nintendo switch
  - Playstation
  - Fallback icons for a generic controller.
- Keyboard
- Mouse

> **Warning** The Switch, Playstation icons are not tested, as I do not have them.

> **Note** Nintendo switch does not have a guide button--the xbox or ps button--so beware.

## Usage

```gdscript
const RemapButton = preload("res://addons/remap/RemapButton.gd")
var label = RemapButton.new()
label.action = "ui_left"
label._name = "left"
add_child(label)
```

## Installation

<details open>
  <summary>With the Godot Package Manager</summary>

> **Note** The information here may not be up to date. For most up to date information, see [you-win/gpm#using-packages](https://github.com/you-win/godot-package-manager#using-packages-quickstart)

> **Warning** This addon is not compatible with being used as a sub addon(a addon to another addon), as it uses classes.

This addon is installable via the [gpm](https://github.com/you-win/godot-package-manager).
To install, create a `godot.package` file.
It should look something like this.

```json
{
  "packages": {
    "@bendn/remap": "1.0.0"
  }
}
```

Change `1.0.0` to whatever version you want to use.
Then, clone the repo(`git clone --depth 1 https://github.com/you-win/godot-package-manager`),
move the `./godot-package-manager/addons/godot-package-manager` folder to your `addons` folder(`mkdir addons && mv ./godot-package-manager/addons/godot-package-manager adons/`).

Downloading addons:

- For godot4:
  Open the terminal, and run this:

  ```bash
  godot --headless -s ./addons/godot-package-manager/cli.gd --update
  ```

  Ignore any errors produced, as long as it says "Finished".

- For godot3:
  Open the godot editor, and click on the godot-package-manager tab, then press update.

</details>
<details>
  <summary>Manually</summary>

- Clone the repo(`git clone --depth 1 https://github.com/bend-n/remap`).
- Move the `remap/addons/remap` folder into your `addons` folder(`mkdir addons && mv remap/addons/remap addons/`)

</details>

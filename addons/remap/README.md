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

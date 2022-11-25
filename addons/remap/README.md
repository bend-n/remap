# godot cli parser

A utility for parsing command line arguments for godot.

## Usage

```gdscript
const RemapButton = preload("res://addons/remap/RemapButton.gd")
var label = RemapButton.new()
label.action = "ui_left"
label._name = "left"
add_child(label)
```

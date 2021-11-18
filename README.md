# Protect the central diamond

Diamond is a neon style arcade survival. Draw lines of the right colors to protect your diamond.
Ranked #8 during the [VGL Game Jam](https://itch.io/jam/vgl-game-jam-2021).

Use arrow keys while holding 'w' or 'z' to create a red or blue line, then release the key to shoot at enemies of the same color.
Keys

    - Arrow keys: move cursor
    - Hold W: draw a red line
    - Hold X: draw a blue line
    - Release W or X: shoot
    - C: cancel line

## Custom Level (Windows version only)

The "Patterns" folder contains the patterns used in-game.

To create a custom set of patterns you can create a new "Level" folder or used an existing one. Inside a "Level" folder, you can create a pattern file. The format is as follow:

```
<delay (in seconds)> <r|b> (<TR|TL|BR|BL|L|R|T|B>, ...)
# TR: Top-Right, TL: Top-Left,  BR: Bottom-Right, BL: Bottom-Left, L: Left, R: Right, T: Top, B: Bottom
```

You can read the other pattern files if you want to be sure how it's done.

The game will read the Level folders and patterns files in alphanumerical order. Once the game hits the last level, it will replay the pattern from this level faster and in random order.

## Credits

### Fonts

- Polentical Neon - https://www.1001fonts.com/polentical-neon-font.html (CC BY-SA)

### BGM

- Digital Age by Scott Holmes Music - https://freemusicarchive.org/music/Scott_Holmes/media-music-mix/digital-age (CC BY-NC)

### ENGINE

- Godot Engine - https://godotengine.org (https://godotengine.org/license)

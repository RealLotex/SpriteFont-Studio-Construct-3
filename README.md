# SpriteFont Studio

Browser-based sprite font generator and pixel editor for Construct 3.

[Open SpriteFont Studio](https://spritefont-studio.rosichmarcos.chatgpt.site)

1. Generate glyphs from an installed font or a TTF, OTF, WOFF or WOFF2 file, or start in **Draw** mode. The pixel editor lets you paint, erase, undo and restore generated glyphs. Desktop Chrome or Edge can list installed fonts with browser permission.
2. Set the cell size and character set. A blank maximum font size uses the cell height. The minimum font size can be set up to 512 px, and cells expand when needed to fit it. An atlas can contain up to 512 characters and measure up to 4096 px on each side.
3. Choose fixed or proportional spacing and override the advance of individual characters in the pixel editor. Set a fill color, outline thickness and drop shadow offsets, blur and opacity. Each layer supports a two-color linear gradient with its own angle.
4. Download the PNG or copy it into the Sprite Font object's image editor. Paste **Character width**, **Character height**, **Character set** and **Spacing data** into the object's properties. Set **Character spacing** to 0 to use the exported advances.

**Export project** saves an editable JSON backup with artwork, glyph retouches, advances and effects. Imported projects include rasterized glyphs, so you can continue editing on a computer without the original font. To generate fresh glyphs at a new font size, select a font again. Font processing and project storage take place in your browser.

The interface follows the browser language for Spanish and defaults to English otherwise. You can change it in the header.

## Run locally

Open `SpriteFont-Studio.html` in a browser. On Windows, run `Abrir-en-Windows.cmd` to use a local address with Chrome or Edge. The app has no build step.

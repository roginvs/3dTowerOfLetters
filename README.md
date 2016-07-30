# 3dTowerOfLetters
Openscad file for generating 3d (stl) model of pencil holder with letters wrapped around. Was inspired by 'Tower of Pi' from Thingiverse

# Render and slice
```bash
rm TowerOfLetters.stl
rm TowerOfLetters.gcode
./render.sh && ./slice.sh
```
Render proccess can easily take more then 12 hours.

# Customization
* To change text change content variable in TowerOfLetters.scad AND ALSO \_text\_x. In perfect world _text_x can be calculated automatically, and, in theory, openscad can do this. Now we have to change it manually. This value must not be greater then generated sequence of letters. To check this value remove last block in scad file and uncomment a block before - you will see a long unwrapped text line with roof above it. This value controls length of this roof.
* To add a solidwall change text\_backplane\_deep=1




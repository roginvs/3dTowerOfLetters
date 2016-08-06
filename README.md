# 3dTowerOfLetters
Openscad file for generating 3d (stl) model of pencil holder with letters wrapped around. Was inspired by 'Tower of Pi' from Thingiverse

# Render
```bash
rm TowerOfLetters.stl
openscad -o TowerOfLetters.stl TowerOfLetters.scad && echo 'Render done at '`date` | mail -s 'Openscad render finished' vasya@rogin.ru
```
Render proccess can easily take 24 hours or more.
Then, fix model with [netfabb](netfabb.azurewebsites.net) and slice with Cura 15. I used Cura instead of Slic3r because Slic3r generates strange supports.

# Customization
* To change text change content variable in TowerOfLetters.scad AND ALSO \_text\_x. In perfect world _text_x can be calculated automatically, and, in theory, openscad can do this. Now we have to change it manually. This value must not be greater then generated sequence of letters. To check this value remove last block in scad file and uncomment a block before - you will see a long unwrapped text line with roof above it. This value controls length of this roof.
* To add a solidwall change text\_backplane\_deep=1

# TODO
* Stand is bad, need to add more faces to cylinder
* Fix stand image, maybe to make image lines to be more bold.
* Change 0x to 0X in text (maybe no need)
* Check printing speed or small perimeters speed
* Reduce diameter to 80 mm, maybe this will need to reduce letters height
* Add a normal text

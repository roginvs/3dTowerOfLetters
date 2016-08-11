# 3dTowerOfLetters
Openscad file for generating 3d (stl) model of pencil holder with letters wrapped around. Was inspired by 'Tower of Pi' from Thingiverse

![Photo](blob/master/IMG_5811.JPG?raw=true "Photo")

# Render
```bash
rm TowerOfLetters.stl
openscad -o TowerOfLetters.stl TowerOfLetters.scad && echo 'Render done at '`date` | mail -s 'Openscad render finished' vasya@rogin.ru
```
Render proccess can easily take 24 hours or more.
Then, fix model with [netfabb](https://netfabb.azurewebsites.net) and slice with Cura 15. I used Cura instead of Slic3r because Slic3r generates strange supports.

# Customization
* To change the text change `content` variable in TowerOfLetters.scad. Generated text line is automatically resized to fit `content_spiral_length` (in mm), so after changing the text you have to check that letters are not too wide or narrow. To check change 'true' to 'false' in the only 'if' and look at generated stl file. If something is wrong, then change `content` or `content_spiral_length` variables.
* To add a solidwall change `text_backplane_deep=1`

# TODO
* Add a normal text

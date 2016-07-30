#!/bin/bash
if [ -e TowerOfLetters.gcode ]; then
    echo "Error, file TowerOfLetters.gcode exists!"
    exit 1
fi
echo `date`" Running slic3r"
slic3r --load my-slic3r-config.ini TowerOfLetters.stl -o TowerOfLetters.gcode
echo `date`" Done"

echo 'Slicing done at '`date` | mail -s 'Slic3r finished' vasya@rogin.ru

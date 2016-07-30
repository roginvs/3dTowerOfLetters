#!/bin/bash
if [ -e TowerOfLetters.stl ]; then
    echo "Error, file TowerOfLetters.stl exists!"
    exit 1
fi
echo `date`" Running openscad"
openscad -o TowerOfLetters.stl TowerOfLetters.scad
echo `date`" Done"

echo 'Render done at '`date` | mail -s 'Openscad render finished' vasya@rogin.ru

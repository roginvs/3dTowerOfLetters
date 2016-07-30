#!/bin/bash
echo `date`" Running openscad"
openscad -o TowerOfLetters.stl TowerOfLetters.scad
echo `date`" Done"

echo 'Render done at '`date` | mail -s 'Openscad render finished' vasya@rogin.ru

#!/bin/bash
echo `date`" Running openscad"
openscad -o TowerOfLetters.stl TowerOfLetters.scad
ecgi `date`" Done"

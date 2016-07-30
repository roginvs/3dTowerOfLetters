'use strict';
const vectorizeText = require("vectorize-text");
const cad = require('jscad');

var Canvas = require('canvas');
var canvas = new Canvas(1000, 1000); //TODO: What will happen if not enought?
var ctx = canvas.getContext('2d');

let complex = vectorizeText("Hello Мир", {
//  textBaseline: "hanging",
    triangles: true,
canvas:canvas,
context:ctx,
font:"LiberationSans",
//size:1000,
textBaseline: "hanging",
//width:500,
});

//console.info(complex);
let polygons = [];
let size = 100;
for (let c of complex.cells) {
    polygons.push(
            [[-1 * complex.positions[c[0]][0]*size,complex.positions[c[0]][1]*size],
             [-1 * complex.positions[c[1]][0]*size,complex.positions[c[1]][1]*size],
             [-1 * complex.positions[c[2]][0]*size,complex.positions[c[2]][1]*size]]);
};
//polygons = [polygons[0]];
//console.info(polygons);
let min_x;
let min_y;
let max_x;
let max_y;
for (let p of complex.positions) {
    if (! min_x || min_x > p[0]) {
        min_x = p[0];
    };
    if (! min_y || min_y > p[1]) {
        min_y = p[1]
    };
    if (! max_x || max_x < p[0]) {
        max_x = p[0];
    };
    if (! max_y || max_y < p[1]) {
        max_y = p[1];
    }
};
console.info(min_x,min_y,max_x,max_y);
cad.renderFile(
        union(polygons.map((poly) => {
                                 return linear_extrude({ height: 10 },polygon(poly))
                                                                        }))
        
        ,'test.stl');


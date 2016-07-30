'use strict';
const vectorizeText = require("vectorize-text");
const cad = require('jscad');

const text = 'ПРИШЛО ВРЕМЯ ПЕРЕУСТАНАВЛИВАТЬ ШINDOWS ШINDOWS САМ НЕ ПЕРЕУСТАНОВИТСЯ ПЕРЕУСТАНОВИ ЕГО ПЕРЕУСТАНОВИ ЕГО ЕЩЕ РАЗ ЗАЧЕМ МНЕ НУЖЕН LINUX У МЕНЯ НЕТ ВРЕМЕНИ ЧТОБЫ ЕБАТЬСЯ С НИМ ЛУЧШЕ ЕЩЕ РАЗ ПЕРЕУСТАНОВИТЬ ШINDOWS Я ПЕРЕУСТАНАВЛИВАЮ ШINDOWS ПО 3 РАЗА В ДЕНЬ КАЖДАЯ ПЕРЕУСТАНОВКА ЗАНИМАЕТ ДВАДЦАДЬ МИНУТ Я ЖИВУ АКТИВНОЙ И ПОЛНОЦЕННОЙ ЖИЗНЬЮ Я УСПЕШЕН И ПОЭТОМУ ЦЕЛЫЙ ДЕНЬ ИГРАЮ В ИГРЫ А ПОСЛЕ ЭТОГО ПЕРЕУСТАНАВЛИВАЮ ШINDOWS ТУПЫЕ ЛИНУКСОИДЫ ОДЕРЖИМЫ КОМПИЛЯЦИЕЙ ВЕДРА А Я СВОБОДНЫЙ ОТ ЗАДРОТСТВО ЧЕЛОВЕК СКОЧАТЬ БЕЗПЛАТНО И БЕЗ РЕГИСТРАЦИИ МОКРЫЕ ПИСЕЧКИ КРЯК УЛЬТИМАТ КЕЙГЕН РАЗБЛОКИРУЙ ВЕНДУ ЛУЧШЕ Я ПЕРЕУСТАНОВЛЮ ЕЩЕ РАЗ ШINDOWS И КРЯКНУ ЕЕ, СТАБИЛЬНОСТЬ НЕ НУЖНАЯ НЕ ПЕРЕУСТАНАВЛИВАЛ ШINDOWS НЕДЕЛЮ ПОЙДУ ПЕРЕУСТАНОВЛЮ В ШINDOWSE ВСЕ ПРОСТО И ПОНЯТНО ААААААААААА ОШИБКА STOP 0x00000001 ЭТО ЖЕ ОЧЕВИДНО КАК ЕЕ РЕШИТЬ ПРИШЛО ВРЕМЯ ПЕРЕУСТАНАВИТЬ ШINDOWS ККОКОКОКОКОКОКО ЖМУ/ПИНУС ШВАБОДКА ПИТУХИ КОКОКОКОКОКОКО КОКОКОКОКОКОКО';

var Canvas = require('canvas');
var canvas = new Canvas(1000, 1000); //TODO: What will happen if not enought?
var ctx = canvas.getContext('2d');

let complex = vectorizeText(text, {
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
let size = 10;
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

let i = 0;
let polyObjs = polygons.map((poly) => {
    i++;
    console.info(`Working on ${i} poly of ${polygons.length}`);
                                     return linear_extrude({ height: 10 },polygon(poly))});

console.info('Union');
let obj = union(polyObjs);
console.info('Render');
cad.renderFile(obj,'test.stl');


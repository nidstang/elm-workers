'use string';
let Calc        = require("./source/Calc.elm").Calc;
let brain       = Calc.worker();


//receive data from main.js and pass it on to Calc elm program
self.addEventListener('message', function (event) {
    brain.ports.receiveInput.send(event.data);
});

//send data from Calc elm program to the main.js
brain.ports.sendResult.subscribe(function (result) {
    self.postMessage(result);
});
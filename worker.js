'use string'
let Calc        = require("./source/Calc.elm").Calc;
let brain       = Calc.worker();

self.addEventListener('message', function (event) {
    brain.ports.receiveInput.send(event.data);
});

brain.ports.sendResult.subscribe(function (result) {
    self.postMessage(result);
});
'use strict';

let BrainWorker = require("worker-loader!./worker.js");
let Main        = require("./source/Main.elm").Main;
let mountNode   = document.getElementById("app");

let app         = Main.embed(mountNode);
let brainWorker = new BrainWorker(); 

//send data from Main elm program to the worker
app.ports.sendData.subscribe(function (data) {
    brainWorker.postMessage(data);
});

//receive data from worker and pass it on to Main elm program
brainWorker.onmessage = function (event) {
    app.ports.receiveResult.send(event.data);
};
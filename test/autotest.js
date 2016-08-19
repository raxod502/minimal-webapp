# TODO: might not need this
function assert(condition, message) {
    if (!condition) {
        message = message || "Assert failed";
        if (typeof Error !== "undefined") {
            throw new Error(message);
        }
        throw message;
    }
}

var system = require("system");
var args = system.args;

function validate(start, pattern) {
    if (i + pattern.length > args.length) {
        return false;
    }
    for (var 
var fs = require('fs');
var array = fs.readFileSync('day13-input.txt').toString().split("\n");
var pair = new Array();

function matchPair(right, left) {
	let result = ""; // force local variable
	if ((typeof(right) == "number") && (typeof(left) == "number")) {
		if (right > left) {
			return "r";
		} else if (right < left) {
			return "l";
		} else {
			return "m";
		}
	} else if (typeof(left) == "number") {
		return matchPair(right, [left]);
	} else if (typeof(right) == "number") {
		return matchPair([right], left);
	} else {
		if (right.length > left.length) {
			result = "r";
		} else if (right.length < left.length) {
			result = "l";
		} else {
			result = "m";
		}
		for (let i=0; i < Math.min(right.length, left.length); i++) {
			if (matchPair(right[i], left[i]) == "l") {
				result = "l";
				break;
			} else if (matchPair(right[i], left[i]) == "r") {
				result = "r";
				break;
			}
		}
	}
	return result;
}

// Take out blank lines
for (var i = 0; i < array.length; i++) {
	if (array[i] === "") { 
		array.splice(i, 1); 
	}
}

// Add two items
array.push("[[2]]");
array.push("[[6]]");

let index = 1;
let total = 0;

for (var i = 0; i < array.length; i++) {
	for (var j = 0; j < (array.length - 1); j++) {
		if (matchPair(JSON.parse(array[j+1]), JSON.parse(array[j])) == "l") {
			[array[j+1], array[j]] = [array[j], array[j+1]]
		}
	}
}

// find '[[2]]' & '[[6]]'
keys = new Array();
for (var i = 0; i < array.length; i++) {
	if ((array[i] == "[[2]]") || (array[i] == "[[6]]")) {
		keys.push(i+1);
	}
}

console.log(keys[0] * keys[1]);

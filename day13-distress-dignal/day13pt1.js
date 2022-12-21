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

let index = 1;
let total = 0;

for(i in array) {
	let result = "";
	if (array[i] == "") {
		result = matchPair(pair[1], pair[0]);
		//console.log("length: ", pair[1].length, pair[0].length);
		pair = new Array();
		//console.log("Result: ", result);
		if (result == "r") {
			total = total + index;
			//console.log("total: ", total, index);
		}
		index++;
	} else {
		//console.log(JSON.parse(array[i]));
		pair.push(JSON.parse(array[i]));
	}
}

console.log("Part 1: ", total);

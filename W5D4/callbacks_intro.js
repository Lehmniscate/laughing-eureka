function Clock() {
  let time = new Date();
  printTime = function() {
    console.log(time.toTimeString().slice(0,8));
  }
  function _tick() {
    time = new Date(time.getYear(), time.getMonth(), time.getDate(), time.getHours(), time.getMinutes(), time.getSeconds() + 1);
    printTime();
  }

  printTime();
  setInterval(_tick, 1000);
}

// const clock = new Clock();


const readline = require("readline");

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, callback) {
  if (numsLeft > 0) {
    reader.question("number?", function (numStr) {
      const thisNumber = parseInt(numStr);
      sum += thisNumber;
      console.log("Partial sum: " + sum);
      addNumbers(sum, numsLeft - 1, callback);
    });
  } else {
    callback(sum);
  }
}

addNumbers(0, 3, function (sum) {
  console.log("Total Sum: " + sum);
  reader.close();
});

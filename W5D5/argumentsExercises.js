// --------------------------------------------------------------------
//                    Sums
// --------------------------------------------------------------------
function sum1(...numbers) {
  let acc = 0;
  numbers.forEach(num => acc += num);
  console.log(acc);
}

// sum1(1,2,3,4);
// sum1(1,2,3,4,5);

function sum2() {
  let args = Array.from(arguments);
  let acc = 0;
  args.forEach(num => acc += num);
  console.log(acc);
}

// sum2(1,2,3,4);
// sum2(1,2,3,4,5);


// --------------------------------------------------------------------
//                    MyBind Function
// --------------------------------------------------------------------

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}
const markov = new Cat("Markov");
const breakfast = new Cat("Breakfast");

// ~~~~~ using arguments ~~~~~~

Function.prototype.myBind1 = function() {
  let args = Array.from(arguments);
  return (...callTimeArgs) => this.call(...args.concat(callTimeArgs));
};

// markov.says.myBind1(breakfast, "meow", "Kush")();
// markov.says.myBind1(breakfast)("meow", "a tree");
// markov.says.myBind1(breakfast, "meow")("Markov");
// const notMarkovSays = markov.says.myBind1(breakfast);
// notMarkovSays("meow", "me");

// ~~~~~~ using ... in the arguments ~~~~~

Function.prototype.myBind2 = function(...bindArgs) {
  return (...callTimeArgs) => this.call(...bindArgs.concat(callTimeArgs));
};

// markov.says.myBind2(breakfast, "meow", "Kush")();
// markov.says.myBind2(breakfast)("meow", "a tree");
// markov.says.myBind2(breakfast, "meow")("Markov");
// const notMarkovSays = markov.says.myBind2(breakfast);
// notMarkovSays("meow", "me");

// --------------------------------------------------------------------
//                    curriedSum
// --------------------------------------------------------------------
function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

sumThree(4, 20, 6); // == 30

// ~~~~~ curriedSum ~~~~~

function curriedSum(numArgs) {
  let array = [];

  const _curriedSum = function(num){
    array.push(num);
    if(array.length === numArgs){
      let acc = 0;
      array.forEach( el => acc += el);
      return acc;
    } else {
      return _curriedSum;
    }
  }

  return _curriedSum;
}

// const sum = curriedSum(4);
// console.log(sum(5)(30)(20)(1)); // => 56

// ~~~~~ curry metaprogramming nonsense ~~~~~~

Function.prototype.curry = function(numArgs) {
  let array = [];

  const _curry = (arg) => {
    array.push(arg);
    if(array.length === numArgs) {
      // return this(...array);
      return this.apply(null, array);
    } else {
      return _curry;
    }
  }

  return _curry;

}

let f1 = sumThree.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
f1 = f1(4); // [Function]
f1 = f1(20); // [Function]
f1 = f1(6); // = 30
console.log(f1);
// let thing = sum1.curry(3); // tells `f1` to wait until 3 arguments are given before running `sumThree`
// thing = thing(4); //  === thing = sum1.curry(2)(4)
// thing = thing(20); // [Function] === thing = sum1.curry(1)(4, 20)
// thing = thing(6); // = 30 === thing = sum1.curry(0)(4, 20, 6)  => sum1(4, 20, 6)

// or more briefly:
console.log(sumThree.curry(3)(4)(20)(6));

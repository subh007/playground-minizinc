enum MOVES;

int: timebound;

array[MOVES] of int: power;
array[MOVES] of int: duration;

var set of MOVES: occur;

constraint sum(i in occur) (duration[i]) <= timebound; 

solve maximize sum(i in occur) (power[i]);

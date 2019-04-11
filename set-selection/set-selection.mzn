%variable
int: nSpots;
set of int: SPOT = 1..nSpots;
array[SPOT] of int: damage;

% this represent of set of related points/ attack group
enum SYMBOL;
array[SYMBOL] of set of SPOT: group; 

% solution
var set of SPOT: attacks;
var int: totalDamage = sum(p in attacks) (damage[p]);

% constraint
constraint forall(s in SYMBOL) (card(attacks intersect group[s]) <= 1);


% objective
solve maximize totalDamage;  
output ["show: \(attacks) total damage : \(totalDamage)\n"];
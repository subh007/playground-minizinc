% This model will solve the problem to optimize cloud constraint solution

% enum
enum COMPUTE;
enum VMTYPE;

% varialbe
%array[COMPUTE] of int: compute;
%array[VMTYPE] of int: vmtype;

array[COMPUTE] of int: avail_cpu;
array[COMPUTE] of int: avail_ram;

array[VMTYPE] of int: req_cpu;
array[VMTYPE] of int: req_ram;

% solution
array[COMPUTE, VMTYPE] of var int: placement;

% constraint
%% there should be one or more vms
constraint forall(c in COMPUTE) (forall(v in VMTYPE) (placement[c,v] >= 0));

%% compute should have sufficient cpu
%constraint forall(c in COMPUTE) (forall(v in VMTYPE) (req_cpu[v] <= avail_cpu[c]));
constraint forall(c in COMPUTE) (sum(v in VMTYPE) (placement[c, v] * req_cpu[v]) <= avail_cpu[c]);

%% compute should have sufficient ram
%constraint forall(c in COMPUTE) (forall(v in VMTYPE) (req_ram[v] <= avail_ram[c]));
constraint forall(c in COMPUTE) (sum(v in VMTYPE) (placement[c, v] * req_ram[v])<= avail_ram[c]);

% objective
solve maximize sum(c in COMPUTE) (sum(v in VMTYPE) (placement[c, v]));

% output
%output ["placement: ", show(placement)];

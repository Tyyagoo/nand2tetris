// File name: projects/1/BadXor.tst

load BadXor.hdl,
output-file BadXor.out,
compare-to Xor.cmp,
output-list a b out;

set a 0,
set b 0,
eval,
output;

set a 0,
set b 1,
eval,
output;

set a 1,
set b 0,
eval,
output;

set a 1,
set b 1,
eval,
output;

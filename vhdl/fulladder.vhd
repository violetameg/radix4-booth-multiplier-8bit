library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fulladder is
	PORT(a,b:in std_logic;
	     cin:in std_logic;
	     s:out std_logic;
	     cout:out std_logic);   
end fulladder;
--orismos aplou full adder
architecture my_arch of fulladder is 
signal c1: std_logic;
signal c2: std_logic;
signal c3: std_logic;
begin
	c1<=a xor b;
	s<=c1 xor cin;
	c2<=a and b;
	c3<=c1 and cin;
	cout<=c3 or c2;
end my_arch;      




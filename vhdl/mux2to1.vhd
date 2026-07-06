library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2to1 is
	port(a,b:in std_logic;--orizw shmata eisodou
	     s:in std_logic;
	     y:out std_logic
	     );   
end mux2to1;

architecture my_arch of mux2to1 is 
signal c1: std_logic; --eswtrika shmata gia na vohthisoun th logikh
signal c2: std_logic;
begin-- ylopoiw thn eksiswsh tou mux y=(a*s')+(b*s)
	c1<=a and (not s);
	c2<=b and s;
	y<=c1 or c2;
end my_arch;      




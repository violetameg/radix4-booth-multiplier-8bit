library ieee;
use ieee.std_logic_1164.all;

entity boothselector is --kyklwma booth selector 1 bit
	port( --orismos i/o
	yn, yn1: in std_logic; --y(n) kai y(n-1)
	single, double, neg: in std_logic; --eisodoi elegxou apo ton booth decoder
	pp: out std_logic --partial product
	);
end boothselector;

architecture arc of boothselector is
signal s1: std_logic;
begin   --ylopoihsh me vash to schematic
	s1 <= (yn1 and single) nor (yn and double);
	pp <= (not s1) xor neg;	
end arc;

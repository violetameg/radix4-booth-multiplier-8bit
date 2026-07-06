library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity boothencoder is --kyklwma booth encoder me eisodo 3 bit
	port( --orismos i/o
	a: in std_logic_vector(2 downto 0);
	neg, single, double: out std_logic
	);	
end boothencoder;

architecture arc of boothencoder is
signal s1, s2: std_logic;
begin   --ylopoihsh symfwna me to schematic
	single <= a(0) xor a(1);
	s1 <= ((a(0) and a(1)) nand (not a(2)));
	s2 <= ((not a(0)) and (not a(1))) nand a(2);
	double <= s1 nand s2;
	neg <= a(2);
end arc;

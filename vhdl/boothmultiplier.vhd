library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity boothmultiplier is
	port(
	x, y: in std_logic_vector(7 downto 0); --pollaplasiasteoi
	s: out std_logic_vector(15 downto 0) --ginomeno
	);
end boothmultiplier;

architecture arc of boothmultiplier is
component ppgenerator --xrhsh component partial product generator
	port( 
	x: in std_logic_vector(7 downto 0);
	y: in std_logic_vector(7 downto 0);
	a, b, c, d: out std_logic_vector(7 downto 0)
	);
end component;

component partialproductadder --xrhsh component partial product adder
	port( 
	a:in std_logic_vector (15 downto 0);
	b:in std_logic_vector (13 downto 0);
	c:in std_logic_vector (11 downto 0);
	d:in std_logic_vector (9 downto 0);
	s:out std_logic_vector (15 downto 0)
	);   
end component;

signal s1, s2, s3, s4: std_logic_vector(7 downto 0);
signal a: std_logic_vector(15 downto 0);
signal b: std_logic_vector (13 downto 0);
signal c: std_logic_vector (11 downto 0);
signal d: std_logic_vector (9 downto 0);
signal temp: std_logic_vector(15 downto 0);
begin
	U1: ppgenerator port map(x, y, s1, s2, s3, s4);
	a <= s1(7) & s1(7) & s1(7) & s1(7) & s1(7) & s1(7) & s1(7) & s1(7) & s1;
	b <= s2(7) & s2(7) & s2(7) & s2(7) & s2(7) & s2(7) & s2;
	c <= s3(7) & s3(7) & s3(7) & s3(7) & s3;
	d <= s4(7) & s4(7) & s4;
	U2: partialproductadder port map(a, b, c, d, temp);

s <= temp;
end arc;

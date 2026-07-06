library ieee;
use ieee.std_logic_1164.all;

entity ppgenerator is
	port( --orismos i/o
	x: in std_logic_vector(7 downto 0);
	y: in std_logic_vector(7 downto 0);
	a, b, c, d: out std_logic_vector(7 downto 0)
	);
end ppgenerator;

architecture arc of ppgenerator is
component boothcomplete --xrhsh component ypologismoy partial product
	port( 
	x: in std_logic_vector(2 downto 0); --3 bit gia encoder
	y: in std_logic_vector(7 downto 0); --pollaplasiasths
	pp: out std_logic_vector(7 downto 0) --partial product
	);
end component;

signal temp: std_logic_vector(8 downto 0);
begin
	temp <= x & '0'; --x[-1]=0
	U1: boothcomplete port map(temp(2 downto 0), y, a); --ginetai 16 bits me sign extension
	U2: boothcomplete port map(temp(4 downto 2), y, b); --ginetai 14 bits me sign extension
	U3: boothcomplete port map(temp(6 downto 4), y, c); --ginetai 12 bits me sign extension
	U4: boothcomplete port map(temp(8 downto 6), y, d); --ginetai 10 bits me sign extension
end arc;

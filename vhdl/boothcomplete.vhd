library ieee;
use ieee.std_logic_1164.all;

entity boothcomplete is
	port( --orismos i/o
	x: in std_logic_vector(2 downto 0); --3 bit gia encoder
	y: in std_logic_vector(7 downto 0); --pollaplasiasths
	pp: out std_logic_vector(7 downto 0) --partial product 
	);
end boothcomplete;

architecture arc of boothcomplete is
component boothselector --xrhsh component booth selector 1 bit
	port(
	yn, yn1: in std_logic; --y(n) kai y(n-1)
	single, double, neg: in std_logic; --eisodoi elegxou apo ton booth decoder
	pp: out std_logic --partial product
	);
end component;

component boothencoder --xrhsh component booth encoder me eisodo 3 bit
	port( 
	a: in std_logic_vector(2 downto 0);
	neg, single, double: out std_logic
	);	
end component;

component adder --xrhsh component adder
  generic (n :integer :=7);
	port(
	a,b:in std_logic_vector (n downto 0);
	cinn:in std_logic;
	s:out std_logic_vector (n downto 0);
	cout:out std_logic
	);   
end component;

signal s, n, d: std_logic; --signals gia single, double, neg
signal yin: std_logic_vector(8 downto 0);
signal temp, sum, b: std_logic_vector(7 downto 0);
signal cout: std_logic;
begin
	encoding: boothencoder port map(x, n, s, d);

	yin <= y & '0';
	gen_pp: for i in 0 to 7 generate
		U: boothselector port map(yin(i), yin(i+1), s, d, n, temp(i)); --pp se sumplhrwma ws pros 1
	end generate gen_pp;

	b <= "00000000";
	add: adder generic map(7) port map(temp, b, n, sum, cout); --pp se sumplhrwma ws pros 2

pp <= sum;
end arc;

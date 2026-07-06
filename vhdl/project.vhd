library ieee;
use ieee.std_logic_1164.all;

entity project is
	port(
	x, y: in std_logic_vector(7 downto 0); --pollaplasiasteoi
	clk, rst: std_logic;
	s: out std_logic_vector(15 downto 0) --ginomeno
	);
end project;

architecture arc of project is
component QD --xrhsh component register
	generic (n:integer:=4);
	port(
	d:in std_logic_vector(n-1 downto 0);
	clk,rst: in std_logic;
	q:out std_logic_vector(n-1 downto 0)
	);
end component;


component boothmultiplier -- xrhsh component booth multiplier
	port(
	x, y: in std_logic_vector(7 downto 0); 
	s: out std_logic_vector(15 downto 0) 
	);
end component;

signal tempx, tempy: std_logic_vector(7 downto 0);
signal tempo: std_logic_vector(15 downto 0);
begin
	U1: QD generic map(8) port map(x, clk, rst, tempx);
	U2: QD generic map(8) port map(y, clk, rst, tempy);
	U3: boothmultiplier port map(tempx, tempy, tempo);
	U4: QD generic map(16) port map(tempo, clk, rst, s); 
end arc;


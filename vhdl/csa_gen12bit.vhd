library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--csa me block twn 4 fulladder

entity csa_gen12bit is
	generic (n :integer :=11);
	port(a,b:in std_logic_vector (n downto 0);--orizw shmata eisodou
	     cin:in std_logic;
	     s:out std_logic_vector (n downto 0);
	     cout:out std_logic
	     );   
end csa_gen12bit;


architecture spuro of csa_gen12bit is

--kalo san component to mux 2 se 1 tou enos bit, to mux 2 se 1 twn n bits 
--kai ton adder gia n=3 dld 4 bit etsi opws ton exw ulopoihsei
component mux2to1
	port ( a: in  std_logic;
  	       b: in  std_logic;
  	       s: in  std_logic;
  	       y: out std_logic);
end component;

component muxnbit
	generic (n: integer:=4);
	port(a,b:in std_logic_vector (n-1 downto 0);
	     s:in std_logic;
	     y:out std_logic_vector (n-1 downto 0));
end component;

component adder
	generic (n :integer :=7);
	port(a,b:in std_logic_vector (n downto 0);
	     cinn:in std_logic;
	     s:out std_logic_vector (n downto 0);
	     cout:out std_logic
	     );   
end component;

--eswterika shmata gia na me vohthisoun sth logikh
signal s0: std_logic_vector (n downto 4); --sums twn athristwn pou perimenoun to carry
signal s1: std_logic_vector (n downto 4);

signal c: std_logic_vector (n/4 downto 0);--ta carry pou proxwrane sta muc
signal c0: std_logic_vector (n/4 downto 1);--ta carry pou vgainoun apo toys adder4 me carry in 0
signal c1: std_logic_vector (n/4 downto 1);--ta carry pou vgainoun apo toys adder4 me carry in 1



begin 


	U1: adder generic map (n=>3) port map (a(3 downto 0),b(3 downto 0),cin,s(3 downto 0),c(0));
	--akolouthw th logikh apo to arxeio csa.vhd sto lab3 askhsh apla to kanw me for generate
	--ftiaxnw generic mhkous csa 
	generate_label:
	for i in 1 to n/4 generate
		adder_i0: adder generic map (n=>3) port map (a(4*i+3 downto 4*i),b(4*i+3 downto 4*i),'0',s0(4*i+3 downto 4*i),c0(i));
		adder_i1: adder generic map (n=>3) port map (a(4*i+3 downto 4*i),b(4*i+3 downto 4*i),'1',s1(4*i+3 downto 4*i),c1(i));
		mux4bit_i: muxnbit port map (s0(4*i+3 downto 4*i),s1(4*i+3 downto 4*i),c(i-1),s(4*i+3 downto 4*i));
		mux2to1_i: mux2to1 port map (c0(i),c1(i),c(i-1),c(i));
	end generate;
	cout<=c(n/4);

end spuro;


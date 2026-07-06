library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--auto pou allazw einai ton adder na ton kanw 2bito kai ta mux epishs 

entity csa_gen10and14bit is
	generic (n :integer :=13);
	port(a,b:in std_logic_vector (n downto 0);--orizw shmata eisodou
	     cin:in std_logic;
	     s:out std_logic_vector (n downto 0);
	     cout:out std_logic
	     );   
end csa_gen10and14bit;


architecture spuro of csa_gen10and14bit is

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
signal s0: std_logic_vector (n downto 2); --sums twn athristwn pou perimenoun to carry
signal s1: std_logic_vector (n downto 2);

signal c: std_logic_vector (n/2 downto 0);--ta carry pou proxwrane sta muc
signal c0: std_logic_vector (n/2 downto 1);--ta carry pou vgainoun apo toys adder4 me carry in 0
signal c1: std_logic_vector (n/2 downto 1);--ta carry pou vgainoun apo toys adder4 me carry in 1



begin 


	U1: adder generic map (n=>1) port map (a(1 downto 0),b(1 downto 0),cin,s(1 downto 0),c(0));
	--akolouthw th logikh apo to arxeio csagen12bit
	generate_label:
	for i in 1 to n/2 generate
		adder_i0: adder generic map (n=>1) port map (a(2*i+1 downto 2*i),b(2*i+1 downto 2*i),'0',s0(2*i+1 downto 2*i),c0(i));
		adder_i1: adder generic map (n=>1) port map (a(2*i+1 downto 2*i),b(2*i+1 downto 2*i),'1',s1(2*i+1 downto 2*i),c1(i));
		mux2bit_i: muxnbit generic map (n=>2)port map (s0(2*i+1 downto 2*i),s1(2*i+1 downto 2*i),c(i-1),s(2*i+1 downto 2*i));
		mux2to1_i: mux2to1 port map (c0(i),c1(i),c(i-1),c(i));
	end generate;
	cout<=c(n/2);

end spuro;


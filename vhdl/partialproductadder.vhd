library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--auto pou allazw einai ton adder na ton kanw 2bito kai ta mux epishs 

entity partialproductadder is
	port(a:in std_logic_vector (15 downto 0);--orizw shmata eisodou
		 b:in std_logic_vector (13 downto 0);
		 c:in std_logic_vector (11 downto 0);
		 d:in std_logic_vector (9 downto 0);
	     s:out std_logic_vector (15 downto 0)
	     );   
end partialproductadder;

architecture spuro of partialproductadder is
--kalw ta components twn carry select adders

component csa_gen10and14bit 
	generic (n :integer :=13);
	port(a,b:in std_logic_vector (n downto 0);
	     cin:in std_logic;
	     s:out std_logic_vector (n downto 0);
	     cout:out std_logic
	     );   
end component;

component csa_gen12bit 
	generic (n :integer :=11);
	port(a,b:in std_logic_vector (n downto 0);
	     cin:in std_logic;
	     s:out std_logic_vector (n downto 0);
	     cout:out std_logic
	     );   
end component;

--eswterika shmata gia na perasw apo ta prwta duo csa ta apotelesmata sto 3o csa
signal adder_u1_out : std_logic_vector(13 downto 0); -- for n=>13
signal adder_u2_out : std_logic_vector(9 downto 0);  -- for n=>9

signal final_csa_in_a : std_logic_vector(11 downto 0);
signal final_csa_in_b : std_logic_vector(11 downto 0);


begin --ulopoiw to block diagram ths anaforas
	s(0)<=a(0);
	s(1)<=a(1);
	--agnow ta carry eksodou twn csa opws ekshgeite sthn anafora giati xrhsimopoiw sumplhrwma ws pros 2 kai exw eksodo 16 bit pou einai to
	--megisto egkuro apotelesma pou vgazei o booth multiplier mou
	U1: csa_gen10and14bit generic map (n=>13) port map (a(15 downto 2), b(13 downto 0), '0', adder_u1_out, open);
    	U2: csa_gen10and14bit generic map (n=>9)  port map (c(11 downto 2), d(9 downto 0),  '0', adder_u2_out, open);
	--vgazw ta duo lsb tou prwtou athroismatos sthn eksodo
	s(2) <= adder_u1_out(0);
	s(3) <= adder_u1_out(1);
	--vazw ta duo lsb tou tritou merikou ginomenou sto eswtriko shma gia to teliko csa
	final_csa_in_a <= adder_u1_out(13 downto 2);
	final_csa_in_b <= adder_u2_out(9 downto 0) & c(1) & c(0);
	--kanw ton teliko csa pou tha vgalei to apotelesma
	V1: csa_gen12bit generic map (n=>11) port map (final_csa_in_a, final_csa_in_b, '0', s(15 downto 4), open);
end spuro;

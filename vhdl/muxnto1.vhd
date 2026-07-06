library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity muxnbit is
	generic (n: integer:=4); 
	port(a,b:in std_logic_vector (n-1 downto 0); --shmata eisodou
	     s:in std_logic;
	     y:out std_logic_vector (n-1 downto 0)
	     );   
end muxnbit;

architecture spuro of muxnbit is

component mux2to1 --klhsh component mux 1 bit
	port ( a: in  std_logic;
  	       b: in  std_logic;
  	       s: in  std_logic;
  	       y: out std_logic);
end component;

begin --ylopoihsh n-1 muxes 
	gen_muxes: for i in 0 to n-1 generate
        MUX_INST: mux2to1 port map (
            a=> a(i),
            b=> b(i),
            s=> s,  
            y=> y(i)
        );
    end generate gen_muxes;
end spuro;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is --orizw eisodous
  generic (n :integer :=7);
	port(a,b:in std_logic_vector (n downto 0);
	     cinn:in std_logic;
	     s:out std_logic_vector (n downto 0);
	     cout:out std_logic
	     );   
end adder;

architecture my_arch of adder is 
--kalw component full adder
component fulladder
  port( a,b,cin:in std_logic;
        s,cout: out std_logic
);
end component;

signal c: std_logic_vector(n downto 0);

begin
  --ftiaxnw to prwto full adder kai meta me for generate tous upoloipous
  U1: fulladder port map (a(0),b(0),cinn,s(0),c(0));
    generate_label:
    for i in 1 to n generate
      fulladder_i: fulladder port map (a(i), b(i), c(i-1),s(i),c(i));
    end generate;
  cout<=c(n);--vazw to cout

end my_arch;      


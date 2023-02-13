--puerta NOT
library IEEE;
use IEEE.std_logic_1164.all;

entity not1 is
	port (y0 :out std_logic;
		x0 :in std_logic);
end entity not1;

architecture not1_a of not1 is
	begin
		y0 <= not x0;
end architecture not1_a;


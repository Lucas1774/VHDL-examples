library IEEE;
use IEEE.std_logic_1164.all;

entity funcFG is
	port (F, G: out std_logic;
	x, y, z : in std_logic);
end entity funcFG;

architecture Comp of funcFG is
	begin
	F <= (not x and z) or (x and y);
	G <= (not x and not y) or (not x and z);
end architecture Comp;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bp_funcFG is
	constant DELAY :time := 50 ps;
end entity bp_funcFG;

architecture bp_funcFG_a of bp_funcFG is
	signal F, G :std_logic;
	signal x, y, z :std_logic;
	component funcFG is
		port (F, G :out std_logic;
			x, y, z : in std_logic);
	end component funcFG;
	begin
		UUT :component funcfg port map (F, G, x, y, z);
		vec_test :process is
			variable valor :unsigned (2 downto 0);
		begin
		for i in 0 to 7 loop
			valor := to_unsigned (i,3);
			x <= std_logic (valor(2));
			y <= std_logic (valor(1));
			z <= std_logic (valor(0));
			wait for DELAY;
		end loop;
		wait;
	end process vec_test;
end architecture bp_funcFG_a;


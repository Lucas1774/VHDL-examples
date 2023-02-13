library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sumyres is
	generic (N: integer :=4);
	port (
		signo : out std_logic;
		cero : out std_logic;
		res : inout std_logic_vector (N - 1 downto 0);
		desbordamiento : inout std_logic;
		a : in std_logic_vector (N - 1 downto 0);
		b: in std_logic_vector (N - 1 downto 0);
		cin : in std_logic_vector(0 downto 0));
end sumyres;
architecture sumyres of sumyres is
	begin
	signo <= res (N - 1) xor desbordamiento;
	cero <= '1' when unsigned(res) = 0 and desbordamiento = '0' else '0';
	res <= std_logic_vector (signed(a) + signed(b) + signed("0" & cin));
	desbordamiento<= (res(N-1) and not a(N-1) and not b(N-1))
		or (not res(N-1) and a(N-1) and b(N-1));
	end sumyres;


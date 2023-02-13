library IEEE;
use IEEE.std_logic_1164.all;

architecture Bajo_Nivel of funcFG is
	signal xn, yn: std_logic;
	signal sF1, sF2, sG1, sG2: std_logic;
	component and2 is
		port (y0 :out std_logic;
			x0, x1 :in std_logic);
	end component and2;
	component or2 is
		port (y0 :out std_logic;
			x0, x1 :in std_logic);
	end component or2;
	component not1 is
		port (y0 :out std_logic;
			x0 :in std_logic);
	end component not1;
	begin
		N1 :component not1 port map (xn, x);
		N2 :component not1 port map (yn, y);
		A1 :component and2 port map (sF1, xn, z);
		A2 :component and2 port map (sF2, x, y);
		A3 :component and2 port map (sG1, xn, yn);
		A4 :component and2 port map (sG2, xn, z);
		O1 :component or2 port map (F, sF1, sF2);
		O2 :component or2 port map (G, sG1, sG2);
end architecture Bajo_Nivel;

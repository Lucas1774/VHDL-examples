library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bp_sumyres is
	constant DELAY :time := 50 ps;
	constant N : integer := 4;
end entity bp_sumyres;

architecture bp_sumyres_a of bp_sumyres is
	signal signo : std_logic;
	signal cero : std_logic;
	signal res : std_logic_vector (N - 1 downto 0);
	signal desbordamiento : std_logic;
	signal a : std_logic_vector (N - 1 downto 0);
	signal b : std_logic_vector (N - 1 downto 0);
	signal cin : std_logic_vector (0 downto 0);

	component sumyres is
	generic (N : integer := N);
	port (
	signo : out std_logic;
	cero : out std_logic;
	res : inout std_logic_vector (N - 1 downto 0);
	desbordamiento : inout std_logic;
	a : in std_logic_vector (N - 1 downto 0);
	b: in std_logic_vector (N - 1 downto 0);
	cin : in std_logic_vector(0 downto 0));
	end component sumyres;
	
	procedure check_sumyres
	(i, j, k : in integer;
	actual_signo : in std_logic;
	actual_cero : in std_logic;
	actual_res : in std_logic_vector (N - 1 downto 0);
	actual_desbordamiento : in std_logic;
	error_count : inout integer ) is
	variable expected_signo : std_logic;
	variable expected_cero : std_logic;
	variable expected_res : integer;
	variable expected_desbordamiento : std_logic;
	begin
	expected_res := (i + j + k);
	if  (to_integer(to_signed(i,N)) +to_integer(to_signed(j,N)) + k < 0) then expected_signo := '1'; else expected_signo := '0';
	end if;
	if (to_integer(to_signed(i,N)) +to_integer(to_signed(j,N)) + k = 0) then expected_cero := '1'; else expected_cero := '0';
	end if;
	if (to_integer(to_signed(i,N)) +to_integer(to_signed(j,N)) + k) >= (2** (N - 1))
	or ( to_integer(to_signed(i,N)) +to_integer(to_signed(j,N)) + k < - 1 * (2** (N - 1))) then
	expected_desbordamiento := '1'; else expected_desbordamiento := '0';
	end if;
	expected_res := to_integer(to_signed(expected_res,N));
	assert (expected_signo = actual_signo and expected_cero = actual_cero and expected_res =
		to_integer(signed(actual_res)) and expected_desbordamiento = actual_desbordamiento)
		report "ERROR. Operacion: " & integer' image(to_integer(to_signed(i,N))) & "+ " & integer' image (to_integer(to_signed(j,N))) &
		"+ " & integer' image (k) & " resultados esperados (en orden signo, cero, resultado, desbordamiento: " & std_logic'image(expected_signo)
		& ", " & std_logic'image (expected_cero) & ", " & integer'image (expected_res) & ", " & std_logic'image(expected_desbordamiento)
		& " resultado actual " & std_logic'image(actual_signo)
		& ", " & std_logic'image (actual_cero) & ", " & integer'image (to_integer(signed(actual_res))) & ", " & std_logic'image(actual_desbordamiento);
	if (expected_signo /= actual_signo or expected_cero /= actual_cero or expected_res /=
		to_integer(signed(actual_res)) or expected_desbordamiento /= actual_desbordamiento) then
		error_count := error_count + 1;
	end if;
	end procedure check_sumyres;
	
	begin
	UUT : component sumyres 
	generic map (N)
	port map (signo, cero, res, desbordamiento, a, b, cin);
	main : process is
		variable error_count : integer := 0;
		begin
		report "comienza la simulacion";
		for i in (-1*(2**(N-1))) to ((2**N) -1)loop
			for j in (-1*(2**(N-1))) to ((2**N) -1)loop
				for k in 0 to 1 loop
				a <= std_logic_vector (to_signed(i,N));
				b <= std_logic_vector (to_signed(j,N));
				cin <= std_logic_vector(to_unsigned(k,1));
				wait for DELAY;
				check_sumyres(i,j,k,signo, cero, res, desbordamiento, error_count);
			end loop;
			end loop;
		end loop;
		if (error_count= 0) then 
		report "Finaliza la simulación sin errores"; 
		else 
		report "Finaliza la simulación: " & integer ' image (error_count) & " errores "; 
		end if; 
		wait;
	end process main;
end architecture bp_sumyres_a;
	
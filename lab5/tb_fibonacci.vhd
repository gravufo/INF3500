-------------------------------------------------------------------------------
--
-- banc d'essai de fibonacci
-- Lab5, INF3500
-- Benjamin O'Connell-Armand
-- Christian Artin
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity tb_fibonacci is
	port(
		signal clk : in std_logic;
		signal reset : in std_logic
		);
end tb_fibonacci;

architecture meh of tb_fibonacci is 
							
	signal go :std_logic;
	signal entree : unsigned( 15 downto 0 );
	signal Fn : unsigned( 15 downto 0 );
	signal sortieValide : std_logic;
	type INT_ARRAY is array (integer range <>) of integer;
	signal vecteur_test : INT_ARRAY(1 to 10) := (1, 1, 2, 3, 5, 8, 13, 21, 34, 55);
	
	component fibonacci is
		generic (
				W : positive := 16
			);
		port(
			clk, reset, go : in STD_LOGIC;
			entree : in unsigned(W - 1 downto 0); -- n
			Fn : out unsigned(W - 1 downto 0);
			sortieValide : out std_logic
			);
	end component;

begin
	UUT: fibonacci
	generic map( w => 16 )
	port map(
		clk           => clk,
		reset         => reset,
		go            => go,
		entree        => entree,
		Fn            => Fn,
		sortieValide  => sortieValide
	);
	process
		variable n : integer := 1;
	begin  
		while(n <= 10) loop
			entree <= conv_unsigned(n, 16);
			go <= '1';
			
			wait until sortieValide = '1';
			go <= '0';
			
			assert Fn = conv_unsigned(vecteur_test(n), 16)
			report "Erreur" severity FAILURE;
			
			n := n + 1;
		end loop;
		
		assert false
		report "Fin de la simulation" severity FAILURE;
	end process;
end meh;
library ieee;
use ieee.std_logic_1164.all;

entity LSFR_tb is
generic
(
	REG_WIDTH	: integer := 8
);
end entity;

architecture behaviour of LSFR_tb is

	component LSFR is
	generic 
	(
		REG_WIDTH	: integer
	);
	port 
	(
		clk				: in std_logic;
		rst				: in std_logic;
		i_new_nmbr		: in std_logic;
		
		random_number	: out std_logic_vector(REG_WIDTH-1 downto 0)
	);
	end component;
	
	signal rst				: std_logic;
	signal clk				: std_logic := '0';
	signal i_new_nmbr		: std_logic;
   signal random_number	: std_logic_vector(REG_WIDTH-1 downto 0);

begin

	clk <= not clk after 5ns;--100MHz clk

	LSFR_using: LSFR 
	generic map
	(
		REG_WIDTH	=> REG_WIDTH
	)
	port map
	(
		clk				=>clk,
		rst				=>rst,
		i_new_nmbr		=>i_new_nmbr,
		random_number	=>random_number
	);


	Test_process: process
	begin
		i_new_nmbr		<= '0';
		rst				<= '1';
		wait for 50ns;
		rst				<= '0';
		wait for 50ns;
		
		wait until rising_edge(clk);
		i_new_nmbr	<= '1';
		wait until rising_edge(clk);
		i_new_nmbr	<= '0';
		wait for 20ns;
		wait until rising_edge(clk);
		i_new_nmbr	<= '1';
		wait until rising_edge(clk);
		i_new_nmbr	<= '0';
		wait for 20ns;
		wait until rising_edge(clk);
		i_new_nmbr	<= '1';
		wait until rising_edge(clk);
		i_new_nmbr	<= '0';
		wait for 20ns;
		wait until rising_edge(clk);
		i_new_nmbr	<= '1';
		wait until rising_edge(clk);
		i_new_nmbr	<= '0';
		wait for 20ns;
		wait until rising_edge(clk);
		i_new_nmbr	<= '1';
		wait until rising_edge(clk);
		i_new_nmbr	<= '0';
		wait for 20ns;
		wait until rising_edge(clk);
		i_new_nmbr	<= '1';
		wait until rising_edge(clk);
		i_new_nmbr	<= '0';
		
		wait;
	end process;

end behaviour;
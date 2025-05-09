library ieee;
use ieee.std_logic_1164.all;

entity Shift_Register_tb is
generic
(
	REG_WIDTH	: integer := 8
);
end entity;

architecture behaviour of Shift_Register_tb is

	component Shift_Register is
		generic
		(
			REG_WIDTH	: integer
		);
		port
		(
			clk	: in std_logic;
			rst	: in std_logic;
			ready	: in std_logic;
			feedback_bit	: in std_logic;
	
			shifted_reg		: out std_logic_vector(REG_WIDTH-1 downto 0)
		);
	end component;
	
	signal clk				: std_logic := '0';			
	signal rst				: std_logic;
	signal ready			: std_logic;
	signal feedback_bit	: std_logic;
	signal shifted_reg	: std_logic_vector(REG_WIDTH-1 downto 0);
	
begin

	clk <= not clk after 5ns;--100MHz clk
	Sh_Reg: Shift_Register 
	generic map
	(
		REG_WIDTH	=> REG_WIDTH
	)
	port map
	(
		clk				=>clk,
		rst				=>rst,
		ready				=>ready,
		feedback_bit	=>feedback_bit,
		shifted_reg		=>shifted_reg			
	);

	Test_process: process
	begin
		rst	<= '1';
		wait for 50ns;
		rst	<= '0';
		ready <= '0';
		feedback_bit	<= (shifted_reg(1) xor shifted_reg(2)) xor (shifted_reg(3) xor shifted_reg(REG_WIDTH-1));
		wait for 50ns;
		ready				<= '1';
		feedback_bit	<= (shifted_reg(1) xor shifted_reg(2)) xor (shifted_reg(3) xor shifted_reg(REG_WIDTH-1));
		wait for 20ns;
		ready				<= '0';
		feedback_bit	<= (shifted_reg(1) xor shifted_reg(2)) xor (shifted_reg(3) xor shifted_reg(REG_WIDTH-1));
		wait for 20ns;
		ready				<= '1';
		feedback_bit	<= (shifted_reg(1) xor shifted_reg(2)) xor (shifted_reg(3) xor shifted_reg(REG_WIDTH-1));
		wait for 20ns;
		ready				<= '0';
		feedback_bit	<= (shifted_reg(1) xor shifted_reg(2)) xor (shifted_reg(3) xor shifted_reg(REG_WIDTH-1));
		
		wait;	
	end process;

end behaviour;
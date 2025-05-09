library ieee;
use ieee.std_logic_1164.all;

entity Shift_Register is
	generic (
		REG_WIDTH	: integer := 8
	);
	port (
		clk				: in std_logic;
		rst				: in std_logic;
		ready				: in std_logic;
		feedback_bit	: in std_logic;

		shifted_reg		: out std_logic_vector(REG_WIDTH-1 downto 0)
	);
end entity;

architecture Behaviour of Shift_Register is
	
	signal shifting_reg	: std_logic_vector(REG_WIDTH-1 downto 0)	:= "01111101";
	
begin
	
	main_process : process(rst, clk)
	begin
		if rst = '1' then
			shifting_reg	<= "01111101";
		elsif rising_edge(clk) then
			if ready = '1'  then
				shifting_reg	<= shifting_reg(shifting_reg'left - 1 downto 0) & feedback_bit;
			end if;
		end if;
	end process;
	
	shifted_reg		<= shifting_reg;

end Behaviour;
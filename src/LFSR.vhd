library ieee;
use ieee.std_logic_1164.all;

entity LSFR is
	generic (
		REG_WIDTH	: integer := 8
	);
	port (
		clk				: in std_logic;
		rst				: in std_logic;
		i_new_nmbr		: in std_logic;
		
		random_number	: out std_logic_vector(REG_WIDTH-1 downto 0)
	);
end entity;

architecture behavioral of LSFR is

	signal LSFR_out				: std_logic_vector(REG_WIDTH-1 downto 0);
	signal ready					: std_logic := '0';
	signal temp_reg1				: std_logic_vector(1 downto 0):= "00";
	signal feedback_bit			: std_logic:= '0';
	
	type state_type is (BEKLE, RD_ET, SH_ET);
	signal state: state_type:= BEKLE;

	
	component Shift_Register is
	port (
		clk				: in std_logic;
		rst				: in std_logic;
		ready				: in std_logic;
		feedback_bit	: in std_logic;

		shifted_reg		: out std_logic_vector(REG_WIDTH-1 downto 0)
	);
	end component;

begin

	S_reg: Shift_Register 
	port map
	(
		clk				=> clk,
		rst				=> rst,
		ready				=> ready,
		feedback_bit	=> feedback_bit,

		shifted_reg		=> LSFR_out
	);
	
	
	Main_Process : process (clk, rst)
	begin
		if rst = '1' then
			ready <= '0';
			
		elsif rising_edge(clk)then
			
			CASE STATE is
				when BEKLE =>
					ready	<= '0';
					if i_new_nmbr = '1' then 	
						state		<= RD_ET;
						temp_reg1				<= (LSFR_out(1) xor LSFR_out(2)) & (LSFR_out(3) xor LSFR_out(REG_WIDTH-1));
					end if;
					
				when RD_ET =>
					feedback_bit			<= temp_reg1(1) xor temp_reg1(0);
					state <= SH_ET;
					
				when SH_ET =>
					ready	<= '1';
					state <= BEKLE;
					
				when others =>
					state <= BEKLE;
					
			end case;
		end if;
	end process;
	
	random_number	<= LSFR_out;

end architecture behavioral;
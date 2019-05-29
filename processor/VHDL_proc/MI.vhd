----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:35 05/21/2019 
-- Design Name: 
-- Module Name:    MI - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MI is
    Port ( 	Adr : in STD_LOGIC_VECTOR (2 downto 0);
				CLK : in STD_LOGIC;
				Alea : in STD_LOGIC;
				Instru : out  STD_LOGIC_VECTOR (31 downto 0)
	 );
end MI;

architecture Behavioral of MI is
type Tab_type is array(7 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
signal tab : Tab_type; 
begin

	process
	begin
		tab <= (others => x"00000000");
		
		tab(1) <= (x"0603000F");		--AFC 000F to R3
		
		tab(2) <= (x"06040003");		--AFC 0003 into R4
		
		tab(3) <= (x"08000104");		--STORE R4 at Addr 0001
		
		tab(4) <= (x"07030001");		--LOAD Addr 0001 into R3

		wait until CLK'event and CLK='1';
		if Alea='0' then
			Instru <= tab(to_integer(unsigned(Adr)));
		else
			Instru <= (x"00000000");
		end if;
	end process;
end Behavioral;


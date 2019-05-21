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
    Port ( 	Adr : in STD_LOGIC_VECTOR (7 downto 0);
				CLK : in STD_LOGIC;
				Instru : out  STD_LOGIC_VECTOR (31 downto 0)
	 );
end MI;

architecture Behavioral of MI is
type Tab_type is array(7 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
signal tab : Tab_type; 
begin

	process
	begin
		tab <= (others => x"06031111");
		--test, we gave the instruction x"06031111" to every case of the array
		--this means AFC, R3, x"1111"
		--affect the value x"1111" (4369) to the third register
		wait until CLK'event and CLK='1';
		Instru <= tab(to_integer(unsigned(Adr)));
	end process;
end Behavioral;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:07:01 05/21/2019 
-- Design Name: 
-- Module Name:    MD - Behavioral 
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

entity MD is
    Port ( Adr : in  STD_LOGIC_VECTOR (15 downto 0);
           DataIN : in  STD_LOGIC_VECTOR (15 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DataOUT : out  STD_LOGIC_VECTOR (15 downto 0));
end MD;

architecture Behavioral of MD is
type Tab_type is array(7 downto 0) of STD_LOGIC_VECTOR (15 downto 0);
signal tab : Tab_type;
begin
	process
	begin
		wait until CLK'event and CLK='1';
		if RST = '0' then
			tab <= (others => (others => '0'));
		elsif RW = '1' then
			tab(to_integer(unsigned(Adr))) <= DataIN;
		else
			DataOUT <= tab(to_integer(unsigned(Adr)));
		end if;
	end process;
end Behavioral;


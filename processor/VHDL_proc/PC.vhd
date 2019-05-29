----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:07:39 05/28/2019 
-- Design Name: 
-- Module Name:    PC - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port ( CLK : in  STD_LOGIC;
           Alea : in  STD_LOGIC;
           IP : out  STD_LOGIC_VECTOR (2 downto 0));
end PC;

architecture Behavioral of PC is
signal count : STD_LOGIC_VECTOR (2 downto 0);
begin
	IP <= count;
	process
	begin
		wait until CLK'event and CLK='1';
		if Alea='0' then
			count <= count + 1;
		end if;
	end process;
end Behavioral;


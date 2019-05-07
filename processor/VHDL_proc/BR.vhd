----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:16 05/07/2019 
-- Design Name: 
-- Module Name:    BR - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BR is
    Port ( AFR : in STD_LOGIC_VECTOR (4 downto 0);
           ASR : in STD_LOGIC_VECTOR (4 downto 0);
			  AWR : in STD_LOGIC_VECTOR (4 downto 0);
			  WRI : in STD_LOGIC_VECTOR (7 downto 0);
           FRO : out STD_LOGIC_VECTOR (7 downto 0);
           SRO : out STD_LOGIC_VECTOR (7 downto 0));
end BR;

architecture Behavioral of BR is
type Tab_type is array(4 downto 0) of STD_LOGIC_VECTOR (7 downto 0);
signal tab : Tab_type;
begin
	FRO<=tab(AFR);
	SRO<=tab(ASR);
	process
	begin
		tab(AWR)<=WRI;
	end process;
end Behavioral;


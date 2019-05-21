----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:28:25 05/13/2019 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
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

entity Pipeline is
	 generic(NB : natural := 16);
    Port ( OPi : in  STD_LOGIC_VECTOR (((NB/2)-1) downto 0);
           Ai : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Bi : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Ci : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  
			  OPo : out  STD_LOGIC_VECTOR (((NB/2)-1) downto 0);
           Ao : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Bo : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Co : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  
			  CLK : in STD_LOGIC);
end Pipeline;

architecture Behavioral of Pipeline is
begin
	process
	begin
		wait until CLK'event and CLK='1';
		OPo<=Opi;
		Ao<=Ai;
		Bo<=Bi;
		Co<=Ci;
	end process;
end Behavioral;


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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BR is
	 generic(NB : natural := 16);
    Port ( AFR : in STD_LOGIC_VECTOR (3 downto 0); --address first register
           ASR : in STD_LOGIC_VECTOR (3 downto 0); --address second register
           FRO : out STD_LOGIC_VECTOR ((NB-1) downto 0); --first register OUT
           SRO : out STD_LOGIC_VECTOR ((NB-1) downto 0); --second register OUT
			  
			  AWR : in STD_LOGIC_VECTOR (3 downto 0); --address writing register
			  WRI : in STD_LOGIC_VECTOR ((NB-1) downto 0); --writing register IN
			  
			  MODE : in STD_LOGIC; --1 : write, 0 : read
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC );
			  
end BR;

architecture Behavioral of BR is
type Tab_type is array(3 downto 0) of STD_LOGIC_VECTOR ((NB-1) downto 0);
signal tab : Tab_type;
begin
	FRO<=tab(to_integer(unsigned(AFR)));
	SRO<=tab(to_integer(unsigned(ASR)));
	process
	begin --implementer clock et if avec le mode
		wait until CLK'event and CLK='1';
		if RST = '0' then
			tab <= (others => (others => '0'));
		elsif MODE = '1' then
			tab(to_integer(unsigned(AWR)))<=WRI;
--			if (AWR = AFR) then
--				FRO<=WRI;
--			elsif (AWR = ASR) then
--				SRO<=WRI;
--				end if;
		end if;
	end process;
end Behavioral;


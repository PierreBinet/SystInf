----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:28:57 05/13/2019 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( Instru : in  STD_LOGIC_VECTOR (31 downto 0);
           OP : out  STD_LOGIC_VECTOR (7 downto 0);
           A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           C : out  STD_LOGIC_VECTOR (15 downto 0));
end Decoder;

architecture Behavioral of Decoder is
	signal OPtmp : std_logic_vector(7 downto 0);
begin
	OPtmp<=Instru(31 downto 24);
	OP<=OPtmp;
	A<=Instru(23 downto 8) when (OPtmp = x"8") else
		Instru(23 downto 16);

	B<=Instru(7 downto 0) when  (OPtmp = x"8") else
		Instru(16 downto 0) when ((OPtmp = x"7") or (OPtmp = x"6")) else
		Instru(15 downto 8);
		
	C<=x"0000" when ((OPtmp = x"8")or(OPtmp = x"7")or(OPtmp = x"6")or(OPtmp = x"5")) else
		Instru(7 downto 0);
end Behavioral;


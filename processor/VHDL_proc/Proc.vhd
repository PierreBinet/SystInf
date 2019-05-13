----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:20 05/13/2019 
-- Design Name: 
-- Module Name:    Proc - Structural 
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

entity Proc is
end Proc;

architecture Structural of Proc is
	 COMPONENT Decoder
	 PORT( Instru : in  STD_LOGIC_VECTOR (31 downto 0);
			 OP : out  STD_LOGIC_VECTOR (7 downto 0);
			 A : out  STD_LOGIC_VECTOR (15 downto 0);
			 B : out  STD_LOGIC_VECTOR (15 downto 0);
			 C : out  STD_LOGIC_VECTOR (15 downto 0));
	 END COMPONENT;		 
	 
	 COMPONENT ALU
    GENERIC(NB : natural := 16);
    Port( A : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
          B : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
          OP : in  STD_LOGIC_VECTOR (3 downto 0);
          S : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
			 C : out  STD_LOGIC;
			 N : out  STD_LOGIC;
		    Z : out  STD_LOGIC);
    END COMPONENT;
	 
	 COMPONENT BR
	 GENERIC(NB : natural := 16);
    PORT(  AFR : in STD_LOGIC_VECTOR (3 downto 0); --address first register
           ASR : in STD_LOGIC_VECTOR (3 downto 0); --address second register
           FRO : out STD_LOGIC_VECTOR ((NB-1) downto 0); --first register OUT
           SRO : out STD_LOGIC_VECTOR ((NB-1) downto 0); --second register OUT
			  
			  AWR : in STD_LOGIC_VECTOR (3 downto 0); --address writing register
			  WRI : in STD_LOGIC_VECTOR ((NB-1) downto 0); --writing register IN
			  
			  MODE : in STD_LOGIC; --1 : write, 0 : read
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC);
    END COMPONENT;

	 COMPONENT Pipeline
	 GENERIC(NB : natural := 16);
    PORT ( OPi : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Ai : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Bi : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Ci : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  
			  OPo : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Ao : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Bo : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Co : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  
			  CLK : in STD_LOGIC);
	 END COMPONENT;
	 
	 signal A, B, C: STD_LOGIC_VECTOR (15 downto 0);
begin
	

end Structural;


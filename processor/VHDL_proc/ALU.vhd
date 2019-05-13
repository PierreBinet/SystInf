----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:08:09 05/07/2019 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity ALU is
	 generic(NB : natural := 16);
    Port ( A : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           B : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           OP : in  STD_LOGIC_VECTOR (3 downto 0);
           S : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  C : out  STD_LOGIC;
			  N : out  STD_LOGIC;
			  Z : out  STD_LOGIC);
			  
end ALU;

 --          O : out  STD_LOGIC; implementer overflow
 --          

architecture Behavioral of ALU is
	signal Sadd : std_logic_vector(NB downto 0);
	signal Smult : std_logic_vector((2*NB-1) downto 0);
	signal Stmp : std_logic_vector(NB-1 downto 0);
begin
--operations
--addition
	Sadd<=('0'&A)+('0'&B);
	Smult<=A*B;
	
	Stmp<=Sadd((NB-1) downto 0) 	when OP=x"1" else
		Smult((NB-1) downto 0)	when OP=x"2" else
		A-B 					when OP=x"3" else
		(others => '0');
	
	S <= Stmp;
	
--flag treatment
	C <= Sadd(NB);
	
	N <= Stmp(NB-1);

	Z <= '1' when Stmp = x"0000" else
		  '0';
	

end Behavioral;


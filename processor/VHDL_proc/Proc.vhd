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
	Port (CLK: in STD_LOGIC;
			IP: in STD_LOGIC_VECTOR (2 downto 0)
	);
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
          OP : in  STD_LOGIC_VECTOR (7 downto 0);
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
    PORT ( OPi : in  STD_LOGIC_VECTOR (((NB/2)-1) downto 0);
           Ai : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Bi : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Ci : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  
			  OPo : out  STD_LOGIC_VECTOR (((NB/2)-1) downto 0);
           Ao : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Bo : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
           Co : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  
			  CLK : in STD_LOGIC);
	 END COMPONENT;
	 
	 COMPONENT MD
    PORT ( Adr : in  STD_LOGIC_VECTOR (15 downto 0);
           DataIN : in  STD_LOGIC_VECTOR (15 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           DataOUT : out  STD_LOGIC_VECTOR (15 downto 0));
	 END COMPONENT;
	 
	 COMPONENT MI
    PORT ( Adr : in  STD_LOGIC_VECTOR (2 downto 0);
           CLK : in  STD_LOGIC;
			  Instru : out  STD_LOGIC_VECTOR (31 downto 0));
	 END COMPONENT;
	 
	 signal Instru: STD_LOGIC_VECTOR (31 downto 0);
	 signal Ainst, Binst, Cinst: STD_LOGIC_VECTOR (15 downto 0);
	 signal OPinst: STD_LOGIC_VECTOR (7 downto 0);
	 signal A1, B1, C1: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP1: STD_LOGIC_VECTOR (7 downto 0);
	 signal B1bis, B1ter: STD_LOGIC_VECTOR (15 downto 0);
	 signal A2, B2, C2: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP2: STD_LOGIC_VECTOR (7 downto 0);
	 signal A3, B3, C3: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP3: STD_LOGIC_VECTOR (7 downto 0);
	 signal A4, B4, C4: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP4: STD_LOGIC_VECTOR (7 downto 0);
	 
begin

	Mem_Instru : MI port map(IP,CLK,Instru);
	Decoder_Instru : Decoder port map(Instru,OPinst,Ainst,Binst,Cinst);
	
	LIDI : Pipeline port map(OPinst,Ainst,Binst,Cinst,OP1,A1,B1,C1,CLK);
	
	BRW : BR port map(B1(3 downto 0),x"0",B1bis,open,A4(3 downto 0),B4,'1','1',CLK);
	B1ter <= B1bis 	when (OP1=x"05") else
			B1; --MUX, choosing B from BR if instruction is COP, or else from last pipeline
	
	DIEX : Pipeline port map(OP1,A1,B1ter,C1,OP2,A2,B2,C2,CLK);
	
	EXMem : Pipeline port map(OP2,A2,B2,C2,OP3,A3,B3,C3,CLK);
	
	MemRE : Pipeline port map(OP3,A3,B3,C3,OP4,A4,B4,C4,CLK);
	
	
end Structural;


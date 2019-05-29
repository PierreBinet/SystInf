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
	Port (CLK: in STD_LOGIC
	);
end Proc;

architecture Structural of Proc is

	 COMPONENT PC
	 PORT( CLK : in  STD_LOGIC;
			 Alea : in  STD_LOGIC;
			 IP : out  STD_LOGIC_VECTOR (2 downto 0));
	 END COMPONENT;
	 
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
			  Alea : in STD_LOGIC;
			  Instru : out  STD_LOGIC_VECTOR (31 downto 0));
	 END COMPONENT;
	 
	 signal Instru: STD_LOGIC_VECTOR (31 downto 0);
	 
	 signal IP: STD_LOGIC_VECTOR (2 downto 0);
	 
	 signal Ainst, Binst, Cinst: STD_LOGIC_VECTOR (15 downto 0);
	 signal OPinst: STD_LOGIC_VECTOR (7 downto 0);
	 
	 signal Alea: STD_LOGIC;
	 
	 signal Data_to_write: STD_LOGIC_VECTOR (15 downto 0);
	 
	 signal A1, B1, C1: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP1: STD_LOGIC_VECTOR (7 downto 0);
	 signal B1bis, B1ter, C1bis, C1ter: STD_LOGIC_VECTOR (15 downto 0);
	 signal WE: STD_LOGIC;
	 
	 signal A2, B2, C2: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP2: STD_LOGIC_VECTOR (7 downto 0);
	 signal B2bis, B2ter: STD_LOGIC_VECTOR (15 downto 0);
	 
	 signal A3, B3: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP3: STD_LOGIC_VECTOR (7 downto 0);
	 
	 signal Addr_mem, Data_load: STD_LOGIC_VECTOR (15 downto 0);
	 signal WE_mem: STD_LOGIC;
	 
	 signal A4, B4: STD_LOGIC_VECTOR (15 downto 0);
	 signal OP4: STD_LOGIC_VECTOR (7 downto 0);
	 
begin

	Alea <= '1' when ((OPinst=x"01")or(OPinst=x"02")or(OPinst=x"03")or(OPinst=x"04")or(OPinst=x"05")or(OPinst=x"08")or(OPinst=x"09")or(OPinst=x"0A")or(OPinst=x"0B")or(OPinst=x"0C")or(OPinst=x"0D")or(OPinst=x"0F"))
	and ((B1(3 downto 0)=A2(3 downto 0)) or (B1(3 downto 0)=A3(3 downto 0)) or (B1(3 downto 0)=A4(3 downto 0)) or (C1(3 downto 0)=A2(3 downto 0)) or (C1(3 downto 0)=A3(3 downto 0)) or (C1(3 downto 0)=A4(3 downto 0))) else '0';
	
	Proc_count : PC port map(CLK,Alea,IP);
	
	Mem_Instru : MI port map(IP,CLK,Alea,Instru);
	Decoder_Instru : Decoder port map(Instru,OPinst,Ainst,Binst,Cinst);
	
	LIDI : Pipeline port map(OPinst,Ainst,Binst,Cinst,OP1,A1,B1,C1,CLK);--------------------
	
	--WRITE ENABLE determined with the operation code
	WE <= '1' when ((OP4=x"01")or(OP4=x"02")or(OP4=x"03")or(OP4=x"04")or(OP4=x"05")or(OP4=x"06")or(OP4=x"07")or(OP4=x"09")or(OP4=x"0A")or(OP4=x"0B")or(OP4=x"0C")or(OP4=x"0D")) else
			'0';
			
	Data_to_write <= Data_load when (OP4 = x"07") else B4;	--Take data from memory if LOAD
			
	BRW : BR port map(B1(3 downto 0),C1(3 downto 0),B1bis,C1bis,A4(3 downto 0),Data_to_write,WE,'1',CLK);
	
	--MUX, bypass BRW when operation is AFC, LOAD or JMP
	B1ter <= B1 	when (OP1=x"00")or(OP1=x"06")or(OP1=x"07")or(OP1=x"0E") else
				B1bis; 
	--MUX, bypass BRW when operation is COP, AFC, LOAD, STORE, JMP or JMPC
	C1ter <= C1 	when (OP1=x"00")or(OP1=x"05")or(OP1=x"06")or(OP1=x"07")or(OP1=x"08")or(OP1=x"0E")or(OP1=x"0F") else
				C1bis;
	
	DIEX : Pipeline port map(OP1,A1,B1ter,C1ter,OP2,A2,B2,C2,CLK);--------------------------
	
	UAL : ALU port map(B2,C2,OP2,B2bis,open,open,open);
	
	--MUX: bypass UAL when operation is COP, AFC, LOAD, STORE or JMP
	B2ter <= B2 when (OP2=x"00")or(OP2=x"05")or(OP2=x"06")or(OP2=x"07")or(OP2=x"08")or(OP2=x"0E") else
				B2bis;
				
	EXMem : Pipeline port map(OP2,A2,B2ter,C2,OP3,A3,B3,open,CLK);--------------------------
	
	Addr_mem <= B3 when (OP3=x"07") else A3;
	
	WE_mem <= '1' when (OP3=x"08") else '0';
	
	Mem_Data : MD port map(Addr_mem,B3,WE_mem,'1',CLK,Data_load);
	
	MemRE : Pipeline port map(OP3,A3,B3,x"0000",OP4,A4,B4,open,CLK);------------------------
	
	
end Structural;


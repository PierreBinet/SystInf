--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:46:03 05/10/2019
-- Design Name:   
-- Module Name:   /home/pbinet/Documents/4A/SystInf/processor/VHDL_proc/TestBR.vhd
-- Project Name:  VHDL_proc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BR
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TestBR IS
END TestBR;
 
ARCHITECTURE behavior OF TestBR IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	 
    COMPONENT BR
	 GENERIC(	NB : natural := 16
			  );
    PORT(  AFR : in STD_LOGIC_VECTOR (3 downto 0); --address first register
           ASR : in STD_LOGIC_VECTOR (3 downto 0); --address second register
           FRO : out STD_LOGIC_VECTOR ((NB-1) downto 0); --first register OUT
           SRO : out STD_LOGIC_VECTOR ((NB-1) downto 0); --second register OUT
			  
			  AWR : in STD_LOGIC_VECTOR (3 downto 0); --address writing register
			  WRI : in STD_LOGIC_VECTOR ((NB-1) downto 0); --writing register IN
			  
			  MODE : in STD_LOGIC; --1 : write, 0 : read
			  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal AFR : std_logic_vector(3 downto 0) := (others => '0');
   signal ASR : std_logic_vector(3 downto 0) := (others => '0');
   signal AWR : std_logic_vector(3 downto 0) := (others => '0');
   signal WRI : std_logic_vector((NB-1) downto 0) := (others => '0');
   signal MODE : std_logic := '0';
	signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal FRO : std_logic_vector((NB-1) downto 0);
   signal SRO : std_logic_vector((NB-1) downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BR PORT MAP (
          AFR => AFR,
          ASR => ASR,
          FRO => FRO,
          SRO => SRO,
          AWR => AWR,
          WRI => WRI,
          MODE => MODE,
			 RST => RST,
          CLK => CLK
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
			RST <='0';
			MODE<='1';
			AWR<=x"1";
			WRI<=x"000F";
			
      wait for 100 ns;
			RST <='1';
			MODE<='1';
			AWR<=x"1";
			WRI<=x"000F";

      wait for CLK_period*10;
			MODE<='0';
			AFR<=x"1";
			ASR<=x"2";
			
		
      wait for CLK_period*10;
			MODE<='1';
			AWR<=x"3";
			WRI<=x"000A";
			AFR<=x"3";

      -- insert stimulus here 

      wait;
   end process;

END;

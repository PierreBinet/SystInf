--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:08:35 05/10/2019
-- Design Name:   
-- Module Name:   /home/pbinet/Documents/4A/SystInf/processor/VHDL_proc/TestALU.vhd
-- Project Name:  VHDL_proc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY TestALU IS
END TestALU;
 
ARCHITECTURE behavior OF TestALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    generic(	NB : natural := 16
			  );
    Port ( A : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           B : in  STD_LOGIC_VECTOR ((NB-1) downto 0);
           OP : in  STD_LOGIC_VECTOR (3 downto 0);
           S : out  STD_LOGIC_VECTOR ((NB-1) downto 0);
			  C : out  STD_LOGIC;
			  N : out  STD_LOGIC;
			  Z : out  STD_LOGIC
			);
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal OP : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal C : std_logic;
   signal N : std_logic;
   signal Z : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          OP => OP,
          S => S,
          C => C,
          N => N,
          Z => Z
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		
		A<=x"EFFF";
		B<=x"1000";
		OP<=x"1";

      wait for 100 ns;
		
		A<=x"FFFF";
		B<=x"0001";
		OP<=x"1";

      -- insert stimulus here 

      wait;
   end process;

END;

-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TestProc IS
END TestProc;

ARCHITECTURE behavior OF TestProc IS 
	-- Component Declaration
	COMPONENT Proc
	Port (CLK: in STD_LOGIC);
	END COMPONENT;
	
   signal CLK : std_logic := '0';
	
	-- Clock period definitions
	constant CLK_period : time := 10 ns;
BEGIN

	-- Component Instantiation
	uut: Proc PORT MAP(
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

END;

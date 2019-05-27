-- TestBench Template 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY TestProc IS
END TestProc;

ARCHITECTURE behavior OF TestProc IS 
	-- Component Declaration
	COMPONENT Proc
	Port (CLK: in STD_LOGIC;
			IP: in STD_LOGIC_VECTOR (2 downto 0));
	END COMPONENT;

	SIGNAL IP :  std_logic_vector(2 downto 0) := "000";
   signal CLK : std_logic := '0';
	
	-- Clock period definitions
	constant CLK_period : time := 10 ns;
BEGIN

	-- Component Instantiation
	uut: Proc PORT MAP(
			CLK => CLK,
			IP => IP
	);
			 
	-- Clock process definitions
	CLK_process :process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;


	--  Test Bench Statements
	tb : PROCESS
	BEGIN
		wait for 100 ns; -- wait until global set/reset completes
		-- Add user defined stimulus here
		
		IP<="001"; --operation 1 is AFC
		wait for 100 ns;
		
		IP<="010"; --operation 2 is COP
		wait;
	END PROCESS tb;

END;

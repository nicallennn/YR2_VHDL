----------------------------------------------------------
-- Filename: ex8_tb.vhdl
-- Author: Nick Allen
---------------------------------------------------------

LIBRARY ieee;                                         	           	-- library clause -make library visible to circuit
USE ieee.std_logic_1164.ALL;                  		-- use clause - use package from library
USE ieee.numeric_std.ALL;                                    	-- use clause - use package from library

ENTITY tb IS                                                            	-- entity definition, a test-bench has no ports
END tb;                                                                 		-- end entity definition

ARCHITECTURE behavior OF tb IS                                                    -- define the architecture behavior of tb

   signal Clk : std_logic := '0';                                      	 	-- declare clock signal and initialise with 0
   signal A,B,R : signed(7 downto 0) := (others => '0');		-- declare and initialise 8 bit in/out signals
   signal R2 : signed(15 downto 0) := (others => '0');                  	-- declare and initialise 16 bit output signal
   signal Op : unsigned(3 downto 0) := (others => '0');   	-- declare and initialise 4 bit operation signal
   constant Clk_period : time := 10 ns;                                   -- define constant Clk_period and initialise with value 10ns

BEGIN                                                                   			-- begin behavior
                                                                   			-- instantiate the Unit Under Test (UUT),
   uut: entity work.simple_alu2 PORT MAP (                              	-- and map test-bench signals to simple_alu2 ports
          Clk => Clk,                                                   			-- assign the clock signal to the clock port
          A => A,                                                       			-- assign input a signal to input a
          B => B,                                                       			-- assign input b signal to input b
          Op => Op,                                                     		-- assign op signal to op input
          R => R,                                                       			-- assign output 1 signal to output 1
          R2 => R2                                                      		-- assign output 2 signal to output 2
        );
   Clk_process :process                                                 		-- clock process definition
   variable i : POSITIVE := 1;                                          		-- create variable i and initialise to 1
   begin                                                                			-- begin clock process
        L1: loop                                                        			-- start loop
        Clk <= '0';                                                     			-- put value '0' in clock signal
        wait for Clk_period/2;                                          		-- wait for half the clock period
        Clk <= '1';                                                     			-- put value '1' in clock signal
        wait for Clk_period/2;                                          		-- wait for half the clock period
        i:= i+1;                                                       	 		-- add 1 to variable i
        exit L1 when i >18;                                             		-- exit loop when variable i is greater than decimal 18
        end loop L1;                                                    			-- end loop
        assert false report "NONE. End of simulation." severity failure;	-- push report "end of simulation"
   end process;                                                         			-- end clock process

   stim_proc: process                                                   	    -- stimulus process definition
   begin                                                                		    -- begin process
      wait for Clk_period*1;                                            	    -- wait for one clock period
        A <= "00010010";                                                	    -- assign decimal value 18 to signal a
        B <= "00001010";                                                	    -- assign decimal value 10 to signal b
        Op <= "0000";  wait for Clk_period;                             -- add A and B
        Op <= "0001";  wait for Clk_period;                             -- subtract B from A.
        Op <= "0010";  wait for Clk_period;                             -- Bitwise NOT of A
        Op <= "0011";  wait for Clk_period;                             -- Bitwise NAND of A and B
        Op <= "0100";  wait for Clk_period;                             -- Bitwise NOR of A and B
        Op <= "0101";  wait for Clk_period;                             -- Bitwise AND of A and B
        Op <= "0110";  wait for Clk_period;                             -- Bitwise OR of A and B
        Op <= "0111";  wait for Clk_period;                             -- Bitwise XOR of A and B
        Op <= "1000";  wait for Clk_period;                             -- A * B
        Op <= "1001";  wait for Clk_period;                             -- Left Shift of A
        Op <= "1010";  wait for Clk_period;                             -- Right Shift of A
        Op <= "1011";  wait for Clk_period;                             -- Rotate A left
        Op <= "1100";  wait for Clk_period;                             -- Rotate B Right
        Op <= "1101";  wait for Clk_period;                             -- A / B
        Op <= "1110";  wait for Clk_period;                             -- A mod B
        Op <= "1111";  wait for Clk_period;                             -- A rem B
        wait;                                                             		    -- wait
   end process;                                                         	    -- end process
END;                                                                    		    -- end architecture definition

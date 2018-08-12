-- Filename: ex6_tb.vhdl
----------------------------------------------------
LIBRARY ieee;                           			-- library clause, make ieee library visible to file
USE ieee.std_logic_1164.ALL;            		-- use clause, use all of std_logic_1164 package
----------------------------------------------------
entity ex6_tb is                        			-- define entity, there are no ports in a test bench
end ex6_tb;                             			-- end entity definition
architecture tb of ex6_tb is            		-- define architecture tb of ex6_tb
component ex6 is                       			-- declare component ex6
port(   inputA: in std_logic;           		-- inputA uses std_logic
        inputB: in std_logic;           			-- inputB uses std_logic
        outputQ1: out std_logic        		-- ouputQ1 uses std_logic
);
end component;                          			-- end component declaration
signal in1, in2, out1 : std_logic;      		-- define temporary signals to use in circuit
begin                                                   		-- begin statements to perform
        mapping: ex6 port map(in1, in2, out1);          -- instantiate ex6 and map ports with signals
        process                                        	 	-- begin process definition
           type pattern_type is record                  	-- set pattern type to record
              in1, in2 : std_logic;                     		-- inputs uses std_logic
              out1 : std_logic;                         		-- output uses std_logic
           end record;                                  		-- end record definition
           type pattern_array is array (natural range <>) of pattern_type;       -- declare a new array
           constant patterns : pattern_array :=                                 		-- initialise array with,
               (('0', '0', '0'),                                                				-- ex6 truth table
                ('0', '1', '0'),
                ('1', '0', '1'),
                ('1', '1', '0'));
           begin                                                			-- use a loop to cycle through array and
           for i in patterns'range loop                         		-- compare the truth table with the circuit
              in1 <= patterns(i).in1;                           		-- use i as index to pass values to circuit inputA
              in2 <= patterns(i).in2;                           		-- use i as index o pass values to circuit inputB
              wait for 1 ns;                                    		-- wait to allow for gate propagation delay
              assert out1 = patterns(i).out1                   		 -- check the output matches the array
                 report "bad output value" severity error;      	-- print error if values do not match
           end loop;                                            			-- end the loop
           assert false report "end of test" severity note;     	-- force a report to print "end of test"
           wait;                                                			-- wait a moment
        end process;                                            		-- end the process
end tb;                                                         			-- end architecture definition

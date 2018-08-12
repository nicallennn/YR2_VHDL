-- filename: ex6.vhdl
-------------------------------------------------
library ieee;                          	 		-- library clause, make library visible to circuit
use ieee.std_logic_1164.all;           		-- use clause, select logic package to use
---------------------------------------------------
entity ex6 is                         	  		-- define entity ex6 (black box view)
                                      		  		-- map circuit ports
port(   inputA: in std_logic;            		-- define input port inputA
        inputB: in std_logic;        	  		-- define input port inputB
        outputQ1:  out std_logic        		-- define output port ouput Q1
);                                   		  		 -- end port map
end ex6;                              	  		 -- end entity declaration
---------------------------------------------------
architecture behv of ex6 is             		-- define the architecture behv of ex6
begin                                   	   		-- begin the behaviour definition
    process(inputA,inputB)               		-- process definition and sensitivity list
                                        		   		-- sensitivity list specify which signals should,
                                        		  		 -- cause the process to be reevaluated
    begin                              	  		 -- statements to be performed are contained between,
                                        		   		-- begin and end statements
        outputQ1 <= inputA and (not inputB);    	-- boolean expression, Q1 = A and (NOT B)
    end process;                        	    		-- end process
end behv;                               	    		-- end behv

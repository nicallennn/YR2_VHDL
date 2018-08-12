-- Filename: simple_alu2.vhdl
-- Author: Nick Allen
------------------------------------------------------------------
-- import library and logic packages
library IEEE;                                                   		-- library clause - make ieee library visible to circuit design
use IEEE.STD_LOGIC_1164.ALL;                                  	-- use clause - use std_logic_1164.all package
use IEEE.NUMERIC_STD.ALL;                                   	-- use clause - use numeric_std.all package
entity simple_alu2 is                                           	-- simple_alu2 entity definition                                                                			-- define input and output ports
port(   Clk : in std_logic;			-- clock signal input
        A,B : in signed(7 downto 0);                            	-- input operands
        Op : in unsigned(3 downto 0);                           	-- operation to be performed
        R : out signed(7 downto 0);                             	-- output 1 of ALU
        R2 : out signed(15 downto 0)                            	-- output 2 - used for multiplication (size of a + b = 16 bits)
);
end simple_alu2;                                                		-- end simple_alu2 entity definition

architecture Behavioral of simple_alu2 is              	-- architecture definition                                                            				-- temporary signal declaration.
signal Reg1,Reg2,Reg3 : signed(7 downto 0) := (others => '0');  -- 8 bit signals for inputs a,b and output 1
signal Reg4 : signed(15 downto 0) := (others => '0');           	-- 16 bit signal for multiplication result

begin                                                           		-- begin definition

Reg1 <= A;                                                      		-- assign input A to signal reg1
Reg2 <= B;                                                      		-- assign input B to signal reg2
R <= Reg3;                                                      		-- assign signal reg3 to output 1
R2 <= Reg4;                                                     		-- assign signal reg4 to output 2

process(Clk)                                                    		-- process definition
begin                                                           		-- begin process definition
    if(rising_edge(Clk)) then                                  	-- calculate on rising edge of clock signal
        case Op is                                              		-- case statements for each operation
            when "0000" =>                                     		 -- 0
                Reg3 <= Reg1 + Reg2;                            	-- addition
            when "0001" =>                                      		-- 1
                Reg3 <= Reg1 - Reg2;                            	-- subtraction
            when "0010" =>                                      		-- 2
                Reg3 <= not Reg1;                               		-- NOT gate
            when "0011" =>                                      		-- 3
                Reg3 <= Reg1 nand Reg2;                         	-- NAND gate
            when "0100" =>                                      		-- 4
                Reg3 <= Reg1 nor Reg2;                          	-- NOR gate
            when "0101" =>                                      		-- 5
                Reg3 <= Reg1 and Reg2;                          	-- AND gate
            when "0110" =>                                      		-- 6
                Reg3 <= Reg1 or Reg2;                           	-- OR gate
            when "0111" =>                                      		-- 7
                Reg3 <= Reg1 xor Reg2;                          	-- XOR gate
        -- CUSTOM OPERATIONS --
            when "1000" =>                                      		-- 8
                Reg4 <= Reg1 * Reg2;                            	-- multiplication
            when "1001" =>                                      		-- 9
                Reg3 <= shift_left(Reg1, 1);              		-- left shift
            when "1010" =>                                      		-- 10
                Reg3 <= shift_right(Reg1, 1);                  	 -- right shift
            when "1011" =>                                     		 -- 11
                Reg3 <= rotate_left(Reg1, 5);                  	 -- rotate left
            when "1100" =>                                      		-- 12
                Reg3 <= rotate_right(Reg1, 5);                	-- rotate right
            when "1101" =>                                      		-- 13
                Reg3 <= Reg1 / Reg2;                            	-- division
            when "1110" =>                                      		-- 14
                Reg3 <= Reg1 mod Reg2;                          	-- modulus - has sign of divisor
            when "1111" =>                                      		-- 15
                Reg3 <= Reg1 rem Reg2;                         	-- remainder - has sign of dividend
            when others =>                                      		-- for any other operation,
            NULL;                                           		-- do nothing
        end case;                                               		-- end case statements
    end if;                                                     		-- end if statement
end process;                                                    		-- end process definition
end Behavioral;                                                 		-- end architecture definition

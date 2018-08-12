-- Filename: ex4_tb.vhdl
--define library
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;    -- use ieee standard logic

entity ex4_tb is                -- define entity ex4_tb
end ex4_tb;                     -- end enityt definition

architecture tb of ex4_tb is    -- define the architecture of tb - ex4_tb

component ex4 is                -- define the inputs and output of the component
port(   inputA: in std_logic;   -- define the input 1 port
        inputB: in std_logic;   -- define the input 2 port
        output: out std_logic); -- define the output port
end component;                  -- end the component definition

signal in1, in2, out1 : std_logic;      -- use standard logic for the input and output signals

begin
        mapping: ex4 port map(in1, in2, out1);  -- map the input and output ports

        process                                 -- define the process
           type pattern_type is record          -- define the pattern type as record
              in1, in2 : std_logic;             -- inputs use standard logic
              out1 : std_logic;                 -- output uses standard logic
           end record;                          -- end record definition

           type pattern_array is array (natural range <>) of pattern_type; -- define the pattern array
           constant patterns : pattern_array :=                            -- define the truth table for the circuit
             (('0', '0', '0'),
              ('0', '1', '0'),
              ('1', '0', '1'),
              ('1', '1', '0'));

           begin                                                -- begin the process
           for i in patterns'range loop                         -- start for loop
              in1 <= patterns(i).in1;                           -- use i as index for input 1
              in2 <= patterns(i).in2;                           -- use i as index for input 2
              wait for 1 ns;                                    -- wait for 1ns
              assert out1 = patterns(i).out1                    -- compare the ouput with the truth table
                 report "bad output value" severity error;      -- print error message if not equal
           end loop;                                            -- end loop
           assert false report "end of test" severity note;     -- print end of test message
           wait;                                                -- wait
        end process;                                            -- end the process
end tb;    

--- filename: ex4.vhdl
-------------------------------------------------------------
-- define library
library ieee;                           -- component #1
use ieee.std_logic_1164.all;            -- use ieee standard logic

entity notGate1 is                      -- define entity notGate1
port(   A:      in std_logic;           -- define input port
        C1:     out std_logic);         -- define output port
end notGate1;                           -- end entity definition

architecture func of notGate1 is        -- define the architecture of notGate1
begin                                   -- begin function definition
        C1 <= not A;                    -- Boolean expression - output is not input
end func;                               -- end function definition
--------------------------------------------------------------
--define library
library ieee;                           -- component #2
use ieee.std_logic_1164.all;            -- use ieee standard logic

entity notGate2 is                      -- define entity notGate2
port(   B:      in std_logic;           -- define input port
        D1:     out std_logic);         -- define output port
end notGate2;                           -- end entity definition

architecture func of notGate2 is        -- define the architecture of notGate2
begin                                   -- begin function definition
        D1 <= not B;                    -- Boolean expression - output is not input
end func;                               -- end function definition
--------------------------------------------------------------
-- define library
library ieee;                           -- component #3
use ieee.std_logic_1164.all;            -- use ieee standard logic

entity andGate1 is                      -- define entity andGate1
port(   C2:     in std_logic;           -- define input port 1
        B:      in std_logic;           -- define input port 2
        E1:     out std_logic           -- define output port
);
end andGate1;                           -- end entity definition

architecture func of andGate1 is        -- define the architecture of andGate1
begin                                   -- begin function definition
        E1 <= C2 and B;                 -- Boolean expression - output is input 1 and input 2
end func;                               -- end function defintion
--------------------------------------------------------------
-- define library
library ieee;                           -- component #4
use ieee.std_logic_1164.all;            -- use ieee standard logic

entity nandGate1 is                     -- define entity nandGate1
port(   A:      in std_logic;           -- define input port 1
        D2:     in std_logic;           -- define input port 2
        F1:     out std_logic           -- define output port
);
end nandGate1;                          -- end entity definition

architecture func of nandGate1 is       -- define architexture of nandGate1
begin                                   -- begin function definition
        F1 <= A nand D2;                -- Boolean expression - output is input 1 nand input 2
end func;                               -- end function definition
--------------------------------------------------------------
-- define library
library ieee;                           -- component #5
use ieee.std_logic_1164.all;            -- use ieee standard logic

entity norGate1 is                      -- define entity norGate1
port(   E2:     in std_logic;           -- define input 1 port
        F2:     in std_logic;           -- define input 2 port
        Q:      out std_logic           -- define output port
);
end norGate1;                           -- end entity definition

architecture func of norGate1 is        -- define architecture of norGate1
begin                                   -- begin function definition
        Q <= E2 nor F2;                 -- Boolean expression - output is input 1 nor input 2
end func;                               -- end function definition
--------------------------------------------------------------
-- define library
library ieee;                           -- declare overall circuit
use ieee.std_logic_1164.all;            -- use ieee standard logic
use work.all;                           -- use ieee work.all

entity ex4 is                           -- define entity ex4 - complete circuit
port(   inputA: in std_logic;           -- define input 1 port
        inputB: in std_logic;           -- define input 2 port
        output: out std_logic           -- define output port
);
end ex4;                                -- end entity definition

architecture struct of ex4 is       -- specify the parts list

    component notGate1 is               -- specify notGate1
    port(   A:  in std_logic;           -- define component input port
            C1: out std_logic           -- define component output port
    );
    end component;                      -- end component

    component notGate2 is               -- specify notGate2
    port(   B:  in std_logic;           -- define component input port
            D1: out std_logic           -- define component output port
    );
    end component;                      -- end component

    component andGate1 is               -- specify andGate1
    port(   C2:  in std_logic;          -- define component input 1 port
            B:  in std_logic;           -- define component input 2 port
            E1: out std_logic           -- define component output port
    );
    end component;                      -- end component

    component nandGate1 is              -- specify andGate2
    port(   A:  in std_logic;           -- define component input 1 port
            D2:  in std_logic;          -- define component input 2 port
            F1: out std_logic           -- define component output port
    );
    end component;                      -- end component

    component norGate1 is               -- specify orGate1
    port(   E2:  in std_logic;          -- define component input 1 port
            F2:  in std_logic;          -- define compoennt input 2 port
            Q: out std_logic            -- define component output port
    );
    end component;                      -- end component

    -- specify the connecting wires

    signal wireC: std_logic;            -- specify wireC
    signal wireD: std_logic;            -- specify wireD
    signal wireE: std_logic;            -- specify wireE
    signal wireF: std_logic;            -- specify wireF

    -- connect everything together to form the overall circuit
    begin

       Gate1: notGate1 port map (A=>inputA, C1=>wireC);                 -- connect notGate1
       Gate2: notGate2 port map (B=>inputB, D1=>wireD);                 -- connet notGate2
       Gate3: andGate1 port map (C2=>wireC, B=>inputB, E1=>wireE);      -- connect andGate1
       Gate4: nandGate1 port map (D2=>wireD, A=>inputA, F1=>wireF);     -- connect nandGate1
       Gate5: norGate1 port map (E2=>wireE, F2=>wireF, Q=>output);      -- connect norGte1

end struct;                                                             -- end structure definition

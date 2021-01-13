----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2017 03:13:07 PM
-- Design Name: 
-- Module Name: cu - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cu is
Port (  rst : in STD_LOGIC;
        clk : in STD_LOGIC;
        opc : in STD_LOGIC_VECTOR(4 downto 0) := "00000";
        cbus : out STD_LOGIC_VECTOR(10 downto 0) := "00000000000"
        -- 10:  ldpc
        -- 09:  incpc
        -- 08:  we
        -- 07:  re_mem
        -- 06:  re_pio
        -- 05:  ldacc
        -- 04:  ldir
        -- 03:  sel
        -- 02:  sel
        -- 01:  mode
        -- 00:  mode
         );
end cu;

architecture Behavioral of cu is
shared variable cbusTemp : STD_LOGIC_VECTOR(10 downto 0) := "00000000000";
type state_T is (FETCH, DECODE, EXECUTE, RESET);
signal state : state_T := RESET;

begin

    process(clk,rst)
    
    begin
        
        if(rst='0') then
            state <= RESET; --go to FETCH state
            cbusTemp := "00000000000";
        else
            if(rising_edge(clk)) then
                -- cbusTemp := "00000000000";
                
                -- cbusTemp(3 downto 2) := opc(3 downto 2); --sel <= opc(sel)    
            
                case state is
                    when FETCH => --FETCH state
                        cbusTemp := "00000000000";
                        cbusTemp(4) := '1'; --ldir <= 1
                        state <= DECODE;
                    
                    when DECODE => --DECODE state
                        --if(opc(3) = '0') then
                        --    cbusTemp(1 downto 0) := opc(1 downto 0);
                        --end if;
                        state <= EXECUTE;
                    
                    when EXECUTE => --EXECUTE state
                        cbusTemp(5) := '1'; --ldacc <= 1
                        if(opc(3 downto 2) = "10") then
                            cbusTemp(8) := '1'; --we <= 1
                        end if;
                        
                        if(opc(3 downto 0) = "1100") then
                            cbusTemp(10) := '1'; --ldpc <= 1
                        else
                            cbusTemp(9) := '1'; --incpc <= 1
                        end if;
                        state <= FETCH;
                    when RESET => 
                        state <= FETCH;
                 end case;                
            end if;
            
                if(opc(4 downto 3) = "00") then
                                cbusTemp(7) := '1'; --re_mem <= 1
                                cbusTemp(6) := '1'; --re_pio <= 1
                            else
                                cbusTemp(7) := '0'; --re_mem <= 0
                                cbusTemp(6) := '0'; --re_pio <= 0
                end if;
        end if;
        cbus(10 downto 4) <= cbusTemp(10 downto 4);
        --cbus(1 downto 0) <= cbusTemp(1 downto 0);
    end process;
    
    -- select should not have one clock cycle delay (in the process it has 1 clk cycle delay)
    cbus(3 downto 2) <= opc(3 downto 2); --sel <= opc(sel)
    cbus(1 downto 0) <= opc(1 downto 0);
    
    
end Behavioral;









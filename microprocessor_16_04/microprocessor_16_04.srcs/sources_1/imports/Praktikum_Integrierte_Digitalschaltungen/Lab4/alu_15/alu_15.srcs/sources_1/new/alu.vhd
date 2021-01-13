----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/16/2017 02:20:00 PM
-- Design Name: 
-- Module Name: alu - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
  Port (clk,rst, ldacc : in STD_LOGIC;
        mode : in STD_LOGIC_VECTOR(1 downto 0) := "00";
        din: in STD_LOGIC_VECTOR(3 downto 0) := "0000";
        dout :  out STD_LOGIC_VECTOR(3 downto 0) := "0000");
end alu;

architecture Behavioral of alu is
Signal data_s : unsigned(3 downto 0) := to_unsigned(0,4);
Signal mode_s : STD_LOGIC_VECTOR(1 downto 0) := "00";
Signal acc : unsigned(4 downto 0) := to_unsigned(0,5);
type state_T is (FETCH, DECODE, EXECUTE, RESET);
signal state : state_T := DECODE;

begin

-- decoder 
process(clk, rst)
variable doutTemp : STD_LOGIC_VECTOR(4 downto 0);
begin
if (rst = '0') then
    data_s <= to_unsigned(0,4);
    mode_s <= "00";
    acc <= to_unsigned(0,5);
    state <= DECODE;
else 
    
if(rising_edge(clk)) then
    if (state = DECODE) then
    -- aktuelle daten liegen nicht zur decode zeit an
        mode_s <= mode;
        data_s <= unsigned(din);
        state <= EXECUTE;
        -- str muss noch behandelt werden
    if (state = EXECUTE)then
        if (ldacc = '1') then 
            case mode_s is
                when "01" => 
                    acc <= acc + data_s;
                    doutTemp := std_logic_vector(acc);
                    dout <= doutTemp(3 downto 0);
                when "10" => 
                    acc <= acc - data_s;
                    doutTemp := std_logic_vector(acc);
                    dout <= doutTemp(3 downto 0);
                when "00" =>
                    doutTemp := std_logic_vector(acc);
                    dout <= doutTemp(3 downto 0);
                when others =>
                    acc <= '0' & data_s;
                    dout <= std_logic_vector(data_s);
            end case;
        end if; -- ldacc end
        if (ldacc ='0' and mode_s = "00") then
        -- kann hier die  
             doutTemp := std_logic_vector(acc);
             dout <= doutTemp(3 downto 0);
             state <= DECODE;
        end if;
        
        state <= DECODE;
        
    end if; -- DECODE state
    end if; -- EXECUTE state
    end if; -- rising_edge
    end if; -- reset

end process;

end Behavioral;

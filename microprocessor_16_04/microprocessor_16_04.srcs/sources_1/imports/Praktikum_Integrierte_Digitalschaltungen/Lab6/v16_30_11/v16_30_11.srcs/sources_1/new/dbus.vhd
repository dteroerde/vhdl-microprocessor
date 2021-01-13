----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2017 03:37:57 PM
-- Design Name: 
-- Module Name: dbus - Behavioral
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

entity dbus is
Port (  sel : in STD_LOGIC_VECTOR(1 downto 0);
        piobus : in STD_LOGIC_VECTOR(3 downto 0);
        membus : in STD_LOGIC_VECTOR(3 downto 0);
        alu : in STD_LOGIC_VECTOR(3 downto 0);
        const : in STD_LOGIC_VECTOR(3 downto 0);
        dout : out STD_LOGIC_VECTOR(3 downto 0)
        );
end dbus;

architecture Behavioral of dbus is

begin

process(sel)

begin

case sel is 
    when "00" =>
        if (const(3) = '0') then 
            dout <= membus;
        else
            dout <= piobus;
        end if; 
    when "01" => 
        dout <= const;
    when others => 
        dout <= alu;
end case;


end process;

end Behavioral;

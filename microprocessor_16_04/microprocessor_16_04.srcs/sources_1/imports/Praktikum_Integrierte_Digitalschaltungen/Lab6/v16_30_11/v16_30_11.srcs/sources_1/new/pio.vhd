----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2017 03:37:24 PM
-- Design Name: 
-- Module Name: pio - Behavioral
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

entity pio is
  Port (clk : in std_logic;
        rst : in std_logic;
        we : in std_logic;
        re : in std_logic;
        addr : in std_logic_vector(3 downto 0);
        din : in std_logic_vector(3 downto 0);
        dout : out std_logic_vector(3 downto 0);
        pioport : inout std_logic_vector(3 downto 0) );
end pio;

architecture Behavioral of pio is
Signal piomode, pioread, piowrite : std_logic_vector(3 downto 0) := "ZZZZ";
begin

process(clk, rst)
    begin
        if rst = '0' then
            pioread <= "0000";
            piowrite <= "0000";
            piomode <= "1111";
        elsif rising_edge(clk) then
            pioread <= pioport;
            if re = '1' and addr(3 downto 1) = "100" then
                dout <= pioread;
            else
                dout <= (others => '0');
            end if; 
            if we = '1' then
                if addr(3 downto 1) = "101" then
                    piowrite <= din;
                elsif addr(3 downto 2) = "11" then
                    piomode <= din;
                end if;
            end if;   
        end if;
    end process;

    process(piowrite, piomode, rst)
    begin
        for n in 0 to 3 loop
            if piomode(n) = '0' and rst = '0' then
                pioport(n) <= piowrite(n);
            else 
                pioport(n) <= 'Z';
            end if;
        end loop;               
    end process;
    
    
end Behavioral;

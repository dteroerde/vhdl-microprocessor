----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.11.2017 16:13:47
-- Design Name: 
-- Module Name: pmem - Behavioral
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


LIBRARY work; 
USE work.program_def.all; 

entity pmem is
  Port ( clk, rst, ldir, incpc, ldpc : in STD_LOGIC; 
         opc : out STD_LOGIC_VECTOR(4 downto 0) := "00000";
         const : out STD_LOGIC_VECTOR(3 downto 0) := "0000");
end pmem;

architecture Behavioral of pmem is
Signal pc : unsigned(3 downto 0) := to_unsigned(0,4);  
Signal ir : STD_LOGIC_VECTOR(7 downto 0) := "00000000";


begin

process(clk, rst) 
variable instructionregister : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
begin
    if( rst = '0') then 
        pc <= to_unsigned(0, 4);
    end if;
    if(rising_edge(clk)) then 
        if(incpc = '1') then 
            pc <= pc + 1;
        end if;
        if(ldpc = '1') then 
            pc <= unsigned(ir(3 downto 0));
        end if;
        if(ldir = '1') then 
        -- Datenbus muss in execute daten schon durchleiten koennen
            instructionregister := rom(to_integer(pc));
            const <= instructionregister(3 downto 0);
            ir <= instructionregister;
        end if;
        
        opc(4 downto 0) <= instructionregister(7) & instructionregister(7 downto 4);
    
    end if;
   
end process;
end Behavioral;
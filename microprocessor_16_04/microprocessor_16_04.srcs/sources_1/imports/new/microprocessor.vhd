----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2017 02:40:29 PM
-- Design Name: 
-- Module Name: microprocessor - Behavioral
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

entity microprocessor is
--  Port ( );
end microprocessor;

architecture Behavioral of microprocessor is
signal rst : std_logic := '1';
signal opc : STD_LOGIC_VECTOR(4 downto 0);
signal cbus : STD_LOGIC_VECTOR(10 downto 0);
signal doutdbus : STD_LOGIC_VECTOR(3 downto 0);
signal aluout : STD_LOGIC_VECTOR(3 downto 0);
signal const, membus, piobus, pioport: STD_LOGIC_VECTOR(3 downto 0);

-- remove when not in testbench
signal clk : std_logic := '0';

begin

controlUnit: entity work.cu port map(rst => rst, clk => clk, opc => opc, cbus => cbus );

algorithmUnit: entity work.alu port map(clk => clk, rst => rst, ldacc => cbus(5), mode => cbus(1 downto 0), din => doutdbus, dout => aluout);

programMemory: entity work.pmem port map(clk => clk, rst => rst, opc => opc, const => const, ldpc => cbus(10), incpc => cbus(9), ldir => cbus(4));

dataBus: entity work.dbus port map(sel => cbus(3 downto 2), const => const, alu => aluout, membus => membus, piobus => piobus, dout => doutdbus);

dataMemory: entity work.dmem port map(clk => clk, we => cbus(8), re => cbus(7), addr => const, din => doutdbus, dout => membus);

parallelIO: entity work.pio port map(clk => clk, rst => rst, we => cbus(8), re => cbus(6), addr => const, pioport => pioport, din => doutdbus, dout => piobus);


clk <= not clk after 5 ns;

end Behavioral;

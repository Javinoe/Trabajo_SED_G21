----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/15/2022 09:27:51 PM
-- Design Name: 
-- Module Name: clk_divider - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_divider is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_clk : out STD_LOGIC_VECTOR (15 downto 0));
end clk_divider;

architecture Behavioral of clk_divider is

begin
    process (clk, reset)
    variable count: STD_LOGIC_VECTOR (15 downto 0) := (others=>'0');
    begin
    
    if reset ='1' then
        count := (others=>'0');
    elsif enable = '1'and clk'event and clk= '1' then
        count := count + 1;
    end if; 
    data_clk <= count;
    end process;

end Behavioral;

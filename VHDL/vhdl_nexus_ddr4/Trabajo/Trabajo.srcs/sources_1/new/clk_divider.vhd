library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clk_divider is
    Port ( CLK : in STD_LOGIC;
           ENABLE : in STD_LOGIC;
           RESET : in STD_LOGIC;
           DATA_CLK : out STD_LOGIC_VECTOR (15 downto 0));
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
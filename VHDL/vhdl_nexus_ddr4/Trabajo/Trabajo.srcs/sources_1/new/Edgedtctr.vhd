library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR is
    port (
    CLK : in std_logic;
    SYNC_IN1 : in std_logic_vector(3 downto 0);
    EDGE1 : out std_logic_vector(3 downto 0)
    );
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is
    type matrix is array (2 downto 0) of std_logic_vector (3 downto 0);
    begin
    process (CLK)
        variable edge : matrix := (others => ( others => '0'));
        begin
        if rising_edge(CLK) then
            edge(2) := edge(1 downto 0) & SYNC_IN1;
        end if;
    end process;
    with edge select
    EDGE1 <= edge(2) when "100",
    '0' when others;
end BEHAVIORAL;

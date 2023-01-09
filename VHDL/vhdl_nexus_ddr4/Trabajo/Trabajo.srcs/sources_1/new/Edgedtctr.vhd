library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR is
    port (
    CLK : in std_logic;
    SYNC_IN : in std_logic_vector(3 downto 0);
    EDGE : out std_logic_vector(3 downto 0)
    );
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is
    type matrix is array (2 downto 0) of std_logic_vector (3 downto 0);
    signal edgesol : std_logic_vector (3 downto 0);
    begin
    process (CLK)
        variable edgedec : matrix := (others => ( others => '0'));
        begin
        if rising_edge(CLK) then
            edgedec := edgedec(1 downto 0) & SYNC_IN;
        end if;
        if edgedec(1) = "0000" and edgedec(0) = "0000" then
            edgesol <= edgedec(2);
        else 
            edgesol <= "0000";
        end if;
    end process;
    
    EDGE <= edgesol;
end BEHAVIORAL;

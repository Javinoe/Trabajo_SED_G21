library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Synchrnzr is
    port (
    CLK : in std_logic;
    ASYNC_IN1 : in std_logic_vector(3 downto 0);
    SYNC_OUT1 : out std_logic_vector(3 downto 0)
    );
end Synchrnzr;

architecture BEHAVIORAL of Synchrnzr is
    type matrix is array (1 downto 0) of std_logic_vector (3 downto 0);
    begin
    process (CLK)
        variable sync : matrix := (others => ( others => '0'));
        begin
        if rising_edge(CLK) then
            sync_out1 <= sync(1);
            sync := sync(0) & async_in1;
        end if;
    end process;
end BEHAVIORAL;

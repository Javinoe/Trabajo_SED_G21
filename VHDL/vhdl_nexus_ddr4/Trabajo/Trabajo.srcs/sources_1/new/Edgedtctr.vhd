library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EDGEDTCTR is
    port (
    CLK : in std_logic;
    SYNC_IN1 : in std_logic;
    SYNC_IN2 : in std_logic;
    SYNC_IN3 : in std_logic;
    SYNC_IN4 : in std_logic;
    SYNC_IN5 : in std_logic;
    SYNC_IN6 : in std_logic;
    SYNC_IN7 : in std_logic;
    SYNC_IN8 : in std_logic;
    SYNC_IN9 : in std_logic;
    EDGE1 : out std_logic;
    EDGE2 : out std_logic;
    EDGE3 : out std_logic;
    EDGE4 : out std_logic;
    EDGE5 : out std_logic;
    EDGE6 : out std_logic;
    EDGE7 : out std_logic;
    EDGE8 : out std_logic;
    EDGE9 : out std_logic
    );
end EDGEDTCTR;

architecture BEHAVIORAL of EDGEDTCTR is
    signal sreg1 : std_logic_vector(2 downto 0);
    signal sreg2 : std_logic_vector(2 downto 0);
    signal sreg3 : std_logic_vector(2 downto 0);
    signal sreg4 : std_logic_vector(2 downto 0);
    signal sreg5 : std_logic_vector(2 downto 0);
    signal sreg6 : std_logic_vector(2 downto 0);
    signal sreg7 : std_logic_vector(2 downto 0);
    signal sreg8 : std_logic_vector(2 downto 0);
    signal sreg9 : std_logic_vector(2 downto 0);
    begin
    process (CLK)
        begin
        if rising_edge(CLK) then
            sreg1 <= sreg1(1 downto 0) & SYNC_IN1;
            sreg2 <= sreg2(1 downto 0) & SYNC_IN2;
            sreg3 <= sreg3(1 downto 0) & SYNC_IN3;
            sreg4 <= sreg4(1 downto 0) & SYNC_IN4;
            sreg5 <= sreg5(1 downto 0) & SYNC_IN5;
            sreg6 <= sreg6(1 downto 0) & SYNC_IN6;
            sreg7 <= sreg7(1 downto 0) & SYNC_IN7;
            sreg8 <= sreg8(1 downto 0) & SYNC_IN8;
            sreg9 <= sreg9(1 downto 0) & SYNC_IN9;
        end if;
    end process;
    with sreg1 select
    EDGE1 <= '1' when "100",
    '0' when others;
    with sreg2 select
    EDGE2 <= '1' when "100",
    '0' when others;
    with sreg3 select
    EDGE3 <= '1' when "100",
    '0' when others;
    with sreg4 select
    EDGE4 <= '1' when "100",
    '0' when others;
    with sreg5 select
    EDGE5 <= '1' when "100",
    '0' when others;
    with sreg6 select
    EDGE6 <= '1' when "100",
    '0' when others;
    with sreg7 select
    EDGE7 <= '1' when "100",
    '0' when others;
    with sreg8 select
    EDGE8 <= '1' when "100",
    '0' when others;
    with sreg9 select
    EDGE9 <= '1' when "100",
    '0' when others;
end BEHAVIORAL;

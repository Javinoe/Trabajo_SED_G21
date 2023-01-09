library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Synchrnzr is
    port (
    CLK : in std_logic;
    ASYNC_IN1 : in std_logic;
    ASYNC_IN2 : in std_logic;
    ASYNC_IN3 : in std_logic;
    ASYNC_IN4 : in std_logic;
    ASYNC_IN5 : in std_logic;
    ASYNC_IN6 : in std_logic;
    ASYNC_IN7 : in std_logic;
    ASYNC_IN8 : in std_logic;
    ASYNC_IN9 : in std_logic;
    SYNC_OUT1 : out std_logic;
    SYNC_OUT2 : out std_logic;
    SYNC_OUT3 : out std_logic;
    SYNC_OUT4 : out std_logic;
    SYNC_OUT5 : out std_logic;
    SYNC_OUT6 : out std_logic;
    SYNC_OUT7 : out std_logic;
    SYNC_OUT8 : out std_logic;
    SYNC_OUT9 : out std_logic
    );
end Synchrnzr;

architecture BEHAVIORAL of Synchrnzr is
    signal sreg1 : std_logic_vector(1 downto 0);
    signal sreg2 : std_logic_vector(1 downto 0);
    signal sreg3 : std_logic_vector(1 downto 0);
    signal sreg4 : std_logic_vector(1 downto 0);
    signal sreg5 : std_logic_vector(1 downto 0);
    signal sreg6 : std_logic_vector(1 downto 0);
    signal sreg7 : std_logic_vector(1 downto 0);
    signal sreg8 : std_logic_vector(1 downto 0);
    signal sreg9 : std_logic_vector(1 downto 0);
    begin
    process (CLK)
        begin
        if rising_edge(CLK) then
            sync_out1 <= sreg1(1);
            sreg1 <= sreg1(0) & async_in1;
            sync_out2 <= sreg2(1);
            sreg2 <= sreg2(0) & async_in2;
            sync_out3 <= sreg3(1);
            sreg3 <= sreg3(0) & async_in3;
            sync_out4 <= sreg4(1);
            sreg4 <= sreg4(0) & async_in4;
            sync_out5 <= sreg5(1);
            sreg5 <= sreg5(0) & async_in5;
            sync_out6 <= sreg6(1);
            sreg6 <= sreg6(0) & async_in6;
            sync_out7 <= sreg7(1);
            sreg7 <= sreg7(0) & async_in7;
            sync_out8 <= sreg8(1);
            sreg8 <= sreg8(0) & async_in8;
            sync_out9 <= sreg9(1);
            sreg9 <= sreg9(0) & async_in9;
        end if;
    end process;
end BEHAVIORAL;

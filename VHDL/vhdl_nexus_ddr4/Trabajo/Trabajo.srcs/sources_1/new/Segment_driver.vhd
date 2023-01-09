library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--DISPLAY_A->DISPLAY_D respuestas usuario
--DISPLAY_E->DISPLAY_H contador de vidas

entity segmentdriver is
Port( DISPLAY_A : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_B : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_C : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_D : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_E : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_F : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_G : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_H : in STD_LOGIC_VECTOR (3 downto 0);
    SEG_A : out STD_LOGIC;
    SEG_B : out STD_LOGIC;
    SEG_C : out STD_LOGIC;
    SEG_D : out STD_LOGIC;
    SEG_E : out STD_LOGIC;
    SEG_F : out STD_LOGIC;
    SEG_G : out STD_LOGIC;
    SELECT_DISPLAY_A : out STD_LOGIC;
    SELECT_DISPLAY_B : out STD_LOGIC;
    SELECT_DISPLAY_C : out STD_LOGIC;
    SELECT_DISPLAY_D : out STD_LOGIC;
    SELECT_DISPLAY_E : out STD_LOGIC;
    SELECT_DISPLAY_F : out STD_LOGIC;
    SELECT_DISPLAY_G : out STD_LOGIC;
    SELECT_DISPLAY_H : out STD_LOGIC;
    CLK : in STD_LOGIC);
end segmentdriver;

architecture Behavioral of segmentdriver is
--Component Declaration

COMPONENT segmentdecoder is
Port ( VALUE : in STD_LOGIC_VECTOR (3 downto 0);
    SEGMENT_A: out STD_LOGIC;
    SEGMENT_B: out STD_LOGIC;
    SEGMENT_C: out STD_LOGIC;
    SEGMENT_D: out STD_LOGIC;
    SEGMENT_E: out STD_LOGIC;
    SEGMENT_F: out STD_LOGIC;
    SEGMENT_G: out STD_LOGIC);
END COMPONENT;

COMPONENT clk_divider is
    PORT(
    CLK : in STD_LOGIC;
    ENABLE : in STD_LOGIC;
    RESET : in STD_LOGIC;
    DATA_CLK : out STD_LOGIC_VECTOR (15 downto 0));
END COMPONENT;
    
SIGNAL aux_data : std_logic_vector(3 downto 0);
SIGNAL clock_word :std_logic_vector (15 downto 0);
SIGNAL slow_clock : std_logic;

begin
-- Component Instantiation
uut: segmentdecoder PORT MAP(
        VALUE => aux_data,
        SEGMENT_A => SEG_A,
        SEGMENT_B => SEG_B,
        SEGMENT_C => SEG_C,
        SEGMENT_D => SEG_D,
        SEGMENT_E => SEG_E,
        SEGMENT_F => SEG_F,
        SEGMENT_G => SEG_G);
        
uut1: clk_divider PORT MAP(
        CLK => CLK,
        ENABLE => '1',
        RESET => '0',
        DATA_CLK => clock_word);
        
slow_clock <= clock_word(9); --Divisor del reloj, a 0 es un calco del mismo

PROCESS (slow_clock)
variable DISPLAY_SELECTion : STD_LOGIC_VECTOR(2 downto 0);
BEGIN


if slow_clock'event and slow_clock = '1' then

case DISPLAY_SELECTion is

when "000" => aux_data <= DISPLAY_A;

    SELECT_DISPLAY_A <= '0'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '1';
    
    DISPLAY_SELECTion := DISPLAY_SELECTion+'1';

when "001" => aux_data <= DISPLAY_B;

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '0';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '1';
    
    DISPLAY_SELECTion := DISPLAY_SELECTion+'1';

when "010" => aux_data <= DISPLAY_C;

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '0';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '1';
    
    DISPLAY_SELECTion := DISPLAY_SELECTion+'1';

when "011" => aux_data <= DISPLAY_D;

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '0';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '1';
    
    DISPLAY_SELECTion := DISPLAY_SELECTion+'1';

when "100" => aux_data <= DISPLAY_E;

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '0';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '1';
    
    DISPLAY_SELECTion := DISPLAY_SELECTion+'1';

when "101" => aux_data <= DISPLAY_F;

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '0';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '1';
    
    DISPLAY_SELECTion := DISPLAY_SELECTion+'1';

when "110" => aux_data <= DISPLAY_G;

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '0';
    SELECT_DISPLAY_H <= '1';
    
    DISPLAY_SELECTion := DISPLAY_SELECTion+'1';

when "111" => aux_data <= DISPLAY_H;

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '0';
    
    DISPLAY_SELECTion := "000";
    
when others =>

    SELECT_DISPLAY_A <= '1'; 
    SELECT_DISPLAY_B <= '1';
    SELECT_DISPLAY_C <= '1';
    SELECT_DISPLAY_D <= '1';
    SELECT_DISPLAY_E <= '1';
    SELECT_DISPLAY_F <= '1';
    SELECT_DISPLAY_G <= '1';
    SELECT_DISPLAY_H <= '1';
    DISPLAY_SELECTion := "000";

end case;
end if;
end process;
end Behavioral;

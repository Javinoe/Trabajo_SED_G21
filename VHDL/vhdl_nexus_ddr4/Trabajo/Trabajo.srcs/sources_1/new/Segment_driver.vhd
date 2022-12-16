library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--display_A->display_D respuestas usuario
--display_E->display_H contador de vidas

entity segmentdriver is
Port( display_A : in STD_LOGIC_VECTOR (3 downto 0);
    display_B : in STD_LOGIC_VECTOR (3 downto 0);
    display_C : in STD_LOGIC_VECTOR (3 downto 0);
    display_D : in STD_LOGIC_VECTOR (3 downto 0);
    display_E : in STD_LOGIC_VECTOR (3 downto 0);
    display_F : in STD_LOGIC_VECTOR (3 downto 0);
    display_G : in STD_LOGIC_VECTOR (3 downto 0);
    display_H : in STD_LOGIC_VECTOR (3 downto 0);
    seg_A : out STD_LOGIC;
    seg_B : out STD_LOGIC;
    seg_C : out STD_LOGIC;
    seg_D : out STD_LOGIC;
    seg_E : out STD_LOGIC;
    seg_F : out STD_LOGIC;
    seg_G : out STD_LOGIC;
    select_display_A : out STD_LOGIC;
    select_display_B : out STD_LOGIC;
    select_display_C : out STD_LOGIC;
    select_display_D : out STD_LOGIC;
    select_display_E : out STD_LOGIC;
    select_display_F : out STD_LOGIC;
    select_display_G : out STD_LOGIC;
    select_display_H : out STD_LOGIC;
    clk : in STD_LOGIC);
end segmentdriver;

architecture Behavioral of segmentdriver is
--Component Declaration

COMPONENT segmentdecoder is
Port ( Value : in STD_LOGIC_VECTOR (3 downto 0);
    segment_A: out STD_LOGIC;
    segment_B: out STD_LOGIC;
    segment_C: out STD_LOGIC;
    segment_D: out STD_LOGIC;
    segment_E: out STD_LOGIC;
    segment_F: out STD_LOGIC;
    segment_G: out STD_LOGIC);
END COMPONENT;

COMPONENT clk_divider is
    PORT(
    clk : in STD_LOGIC;
    enable : in STD_LOGIC;
    reset : in STD_LOGIC;
    data_clk : out STD_LOGIC_VECTOR (15 downto 0));
END COMPONENT;
    
SIGNAL aux_data : std_logic_vector(3 downto 0);
SIGNAL clock_word :std_logic_vector (15 downto 0);
SIGNAL slow_clock : std_logic;

begin
-- Component Instantiation
uut: segmentdecoder PORT MAP(
        Value => aux_data,
        segment_A => seg_A,
        segment_B => seg_B,
        segment_C => seg_C,
        segment_D => seg_D,
        segment_E => seg_E,
        segment_F => seg_F,
        segment_G => seg_G);
        
uut1: clk_divider PORT MAP(
        clk => clk,
        enable => '1',
        reset => '0',
        data_clk => clock_word);
        
slow_clock <= clock_word(0); --Divisor del reloj, a 0 es un calco del mismo

PROCESS (slow_clock)
variable display_selection : STD_LOGIC_VECTOR(2 downto 0);
BEGIN


if slow_clock'event and slow_clock = '1' then

case display_selection is

when "000" => aux_data <= display_A;

    select_display_A <= '0'; 
    select_display_B <= '1';
    select_display_C <= '1';
    select_display_D <= '1';
    select_display_E <= '1';
    select_display_F <= '1';
    select_display_G <= '1';
    select_display_H <= '1';
    
    display_selection := display_selection+'1';

when "001" => aux_data <= display_B;

    select_display_A <= '1'; 
    select_display_B <= '0';
    select_display_C <= '1';
    select_display_D <= '1';
    select_display_E <= '1';
    select_display_F <= '1';
    select_display_G <= '1';
    select_display_H <= '1';
    
    display_selection := display_selection+'1';

when "010" => aux_data <= display_C;

    select_display_A <= '1'; 
    select_display_B <= '1';
    select_display_C <= '0';
    select_display_D <= '1';
    select_display_E <= '1';
    select_display_F <= '1';
    select_display_G <= '1';
    select_display_H <= '1';
    
    display_selection := display_selection+'1';

when "011" => aux_data <= display_D;

    select_display_A <= '1'; 
    select_display_B <= '1';
    select_display_C <= '1';
    select_display_D <= '0';
    select_display_E <= '1';
    select_display_F <= '1';
    select_display_G <= '1';
    select_display_H <= '1';
    
    display_selection := display_selection+'1';

when "100" => aux_data <= display_E;

    select_display_A <= '1'; 
    select_display_B <= '1';
    select_display_C <= '1';
    select_display_D <= '1';
    select_display_E <= '0';
    select_display_F <= '1';
    select_display_G <= '1';
    select_display_H <= '1';
    
    display_selection := display_selection+'1';

when "101" => aux_data <= display_F;

    select_display_A <= '1'; 
    select_display_B <= '1';
    select_display_C <= '1';
    select_display_D <= '1';
    select_display_E <= '1';
    select_display_F <= '0';
    select_display_G <= '1';
    select_display_H <= '1';
    
    display_selection := display_selection+'1';

when "110" => aux_data <= display_G;

    select_display_A <= '1'; 
    select_display_B <= '1';
    select_display_C <= '1';
    select_display_D <= '1';
    select_display_E <= '1';
    select_display_F <= '1';
    select_display_G <= '0';
    select_display_H <= '1';
    
    display_selection := display_selection+'1';

when "111" => aux_data <= display_H;

    select_display_A <= '1'; 
    select_display_B <= '1';
    select_display_C <= '1';
    select_display_D <= '1';
    select_display_E <= '1';
    select_display_F <= '1';
    select_display_G <= '1';
    select_display_H <= '0';
    
    display_selection := "000";
    
when others =>

    select_display_A <= '1'; 
    select_display_B <= '1';
    select_display_C <= '1';
    select_display_D <= '1';
    select_display_E <= '1';
    select_display_F <= '1';
    select_display_G <= '1';
    select_display_H <= '1';
    display_selection := "000";

end case;
end if;
end process;
end Behavioral;
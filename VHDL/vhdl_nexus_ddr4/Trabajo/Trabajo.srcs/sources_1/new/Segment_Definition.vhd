library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    

entity segmentdecoder is
Port ( Value : in STD_LOGIC_VECTOR (3 downto 0);
    segment_A: out STD_LOGIC;
    segment_B: out STD_LOGIC;
    segment_C: out STD_LOGIC;
    segment_D: out STD_LOGIC;
    segment_E: out STD_LOGIC;
    segment_F: out STD_LOGIC;
    segment_G: out STD_LOGIC);
end segmentdecoder;

architecture Behavioral of segmentdecoder is

begin
process (Value)
variable Decode_Data : std_logic_vector(6 downto 0);
begin
case Value is
    when "0000" => Decode_Data := "0000001"; --0
    when "0001" => Decode_Data := "1001111"; --1
    when "0010" => Decode_Data := "0010010"; --2
    when "0011" => Decode_Data := "0000110"; --3
    when "0100" => Decode_Data := "1001100"; --4
    when "0101" => Decode_Data := "0100100"; --5
    when "0110" => Decode_Data := "0100000"; --6
    when "0111" => Decode_Data := "0001111"; --7
    when "1000" => Decode_Data := "0000000"; --8
    when "1001" => Decode_Data := "0000100"; --9
    when "1010" => Decode_Data := "0000100"; --g
    when "1011" => Decode_Data := "1000001"; --u
    when "1100" => Decode_Data := "0110000"; --e
    when "1101" => Decode_Data := "0100100"; --s
    when "1110" => Decode_Data := "0011100"; --símbolo de vida (Es como un muñeco de nieve pero sin la mitad de abajo)
    when "1111" => Decode_Data := "1111110"; --símbolo de vacío (-)
    when others => Decode_Data := "0110110"; --error
end case;

    segment_A <= Decode_Data(6);
    segment_B <= Decode_Data(5);
    segment_C <= Decode_Data(4);
    segment_D <= Decode_Data(3);
    segment_E <= Decode_Data(2);
    segment_F <= Decode_Data(1);
    segment_G <= Decode_Data(0);

end process;
end;
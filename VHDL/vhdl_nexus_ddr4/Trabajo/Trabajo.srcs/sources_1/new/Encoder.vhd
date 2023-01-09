library IEEE;
use IEEE.std_logic_1164.all;

entity Encoder is
    port (
    BUTTONPRESSED : out std_logic_vector(3 downto 0);
    x9, x8, x7, x6, x5, x4, x3, x2, x1 : in std_logic
    );
end entity;

architecture Encoder of Encoder is
signal vbinariox : std_logic_vector (3 downto 0);
signal createbutton_s : std_logic;
begin

    process ( x9, x8, x7, x6, x5, x4, x3, x2, x1) 

begin 
if    x1='1' then 
vbinariox <= "0001" ;
elsif x2='1' then 
vbinariox <= "0010" ; 
elsif x3='1' then 
vbinariox <= "0011" ; 
elsif x4='1' then 
vbinariox <= "0100" ; 
elsif x5='1' then 
vbinariox <= "0101" ; 
elsif x6='1' then 
vbinariox <= "0110" ; 
elsif x7='1' then 
vbinariox <= "0111" ; 
elsif x8='1' then 
vbinariox <= "1000" ; 
elsif x9='1' then 
vbinariox <= "1001" ;
else vbinariox <= "0000";
end if;
    end process;
    BUTTONPRESSED <= vbinariox;
end Encoder;

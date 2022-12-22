library IEEE;
use IEEE.std_logic_1164.all;

entity Encoder is
    port (
     buttonpressed : out std_logic_vector(3 downto 0);
     createbutton :  out std_logic; 
     x4, x3, x2, x1, x0 : in std_logic
    );
end entity;

architecture Encoder of Encoder is
signal vbinariox : std_logic_vector (3 downto 0);
signal createbutton_s : std_logic;
begin

    process ( x4, x3, x2, x1, x0) 

begin 
if    x0='1' then vbinariox <= "0001" ;
createbutton_s <= '1';
elsif x1='1' then 
vbinariox <= "0010" ; 
createbutton_s <= '1';
elsif x2='1' then 
vbinariox <= "0011" ; 
createbutton_s <= '1';
elsif x3='1' then 
vbinariox <= "0100"; 
createbutton_s <= '1';
elsif x4='1' then 
vbinariox <= "0101" ; 
createbutton_s <= '1';
        else vbinariox <= "0000";
createbutton_s <= '0';
        end if;
    end process;
    buttonpressed <= vbinariox;
    createbutton  <= createbutton_s;
end Encoder;


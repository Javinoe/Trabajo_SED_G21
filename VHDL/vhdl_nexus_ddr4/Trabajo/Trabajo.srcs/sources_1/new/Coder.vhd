library IEEE;
use IEEE.std_logic_1164.all;

entity Coder is
    port (
     vbinario : out std_logic_vector(3 downto 0);
     x4, x3, x2, x1, x0 : in std_logic
    );
end entity;

architecture Coder of Coder is
signal vbinariox : std_logic_vector (3 downto 0);
begin

    process ( x4, x3, x2, x1, x0) 

begin 
if    x0='1' then vbinariox <= "0001" ;
elsif x1='1' then vbinariox <= "0010" ;   
elsif x2='1' then vbinariox <= "0011" ; 
elsif x3='1' then vbinariox <= "0100" ; 
elsif x4='1' then vbinariox <= "0101" ; 
        else vbinariox <= "0000";
        end if;

    end process;
    vbinario <= vbinariox;
end Coder;

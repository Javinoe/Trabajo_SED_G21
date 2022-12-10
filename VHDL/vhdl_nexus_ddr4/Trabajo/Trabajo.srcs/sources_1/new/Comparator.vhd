library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Comparator is
    port(
    RESET :         in std_logic;
    INPUT_P0ASSWORD : in integer;
    INPUT_ANSWER :  in integer;
    RESULT1 :       out std_logic_vector (3 downto 0);   --Respuesta del comparador
    RESULT2 :       out std_logic_vector (3 downto 0);
    RESULT3 :       out std_logic_vector (3 downto 0);
    RESULT4 :       out std_logic_vector (3 downto 0);
    COMPLETE:       out std_logic;   --Se han pulsado 4 botones
    CORRECT:        out std_logic   --Son los correctos       
    );
end Comparator;

architecture Behavioral of Comparator is
    signal password : std_logic_vector (3 downto 0) := "0000";
    signal answer : std_logic_vector (3 downto 0) := "0000";
    signal complete : std_logic := '0';
    signal correct : std_logic := '1';
    type matrix is array (3 downto 0, 3 downto 0) of integer range 0 to 3;
    signal results : matrix :=
        ((0,0,0,0),
         (0,0,0,0),
         (0,0,0,0),
         (0,0,0,0));
begin
    reset: process (RESET)
    begin
    	if RESET = '0' then
        	password <= "0000";
        	answer <= "0000";
        end if;
    end process;
    
    create_password: process(INPUT_PASSWORD)
        begin
        if password(0) /= '0' then
                complete := 1;
        else    
            for count in 3 downto 0 loop
                if password(count) = '0' then
                    password(count) <= INPUT_PASSWORD;
                end if;
            end loop;
        end if; 
    end process;
    
    create_answer: process(INPUT_ASNWER)
        begin
        if answer(0) /= '0' then
            for count in 3 downto 0 loop
                if answer(count) = password(count) then
                        results(count) <= "0000000";
                else
                    correct := '0';
                    for count2 in 3 downto 0 loop
                        if answer(count) = password(count2) then
                            results(count) <= "0000001";
                            exit;
                        else
                            results(count) <= "1111110";
                        end if;
                    end loop;
                end if;        
            end loop;
            complete <= 1;         
        else    
            for count in 3 downto 0 loop
                if answer(count) = '0' then
                    answer(count) := INPUT_ANSWER;
                end if;
            end loop;
        end if; 
    end process;
    
    output: process (complete)
    begin
        if complete = '1' and password(0) /= '0' then
            COMPLETE <= complete;
            complete := '0';
        elsif complete = '1' and password(0) /= '0' and answer(0) /= '0' then
            RESULT1 <= results(3);
            RESULT2 <= results(2); 
            RESULT3 <= results(1); 
            RESULT4 <= results(0); 
            CORRECT <= corrrect;
            correct := 1;
        end if;
    end process;   
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Comparator is
    port(
    RESET :         in std_logic;
    INPUT_PASSWORD : in integer;
    INPUT_ANSWER :  in integer;
    RESULT1 :       out std_logic_vector (3 downto 0);   --Results to to FSM
    RESULT2 :       out std_logic_vector (3 downto 0);
    RESULT3 :       out std_logic_vector (3 downto 0);
    RESULT4 :       out std_logic_vector (3 downto 0);
    COMPLETE:       out std_logic;      --Array completed
    CORRECT:        out std_logic       --Correct response      
    );
end Comparator;

architecture Behavioral of Comparator is
    type int_array is array (3 downto 0) of integer;
    signal password : int_array := (others => 0);
    signal answer : int_array := (others => 0);
    signal complete_i : std_logic := '0';
    signal correct_i : std_logic := '1';
    type matrix is array (3 downto 0) of std_logic_vector (7 downto 0);
    signal results : matrix := (others => ( others => '0'));
begin
    reset_input: process (RESET)
    begin
    	if RESET = '0' then
        	password <= (others => 0);
        	answer <= (others => 0);
        end if;
    end process;
    
    create_password: process(INPUT_PASSWORD)
        begin
        if INPUT_PASSWORD /= 0 then
            if password(0) /= 0 then
                    complete <= '1';
            else    
                for count in 3 downto 0 loop
                    if password(count) = 0 then
                        password(count) <= INPUT_PASSWORD;
                    end if;
                end loop;
            end if;
        end if;
    end process;
    
    create_answer: process(INPUT_ANSWER)
        begin
        if INPUT_ANSWER /= 0 then
            if answer(0) /= 0 then
                for count in 3 downto 0 loop
                    if answer(count) = password(count) then
                            results(count) <= "0000000";
                    else
                        correct <= '0';
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
                complete <= '1';         
            else    
                for count in 3 downto 0 loop
                    if answer(count) = 0 then
                        answer(count) <= INPUT_ANSWER;
                    end if;
                end loop;
            end if;
        end if;
    end process;
    
    output: process (complete)
    begin
        if complete = '1' and password(0) /= 0 then
            COMPLETE <= complete;
            complete <= '0';
        elsif complete = '1' and password(0) /= 0 and answer(0) /= 0 then
            RESULT1 <= results(3);
            RESULT2 <= results(2); 
            RESULT3 <= results(1); 
            RESULT4 <= results(0); 
            CORRECT <= correct;
            COMPLETE <= complete;
            complete <= '0';
            correct <= '1';
            results <= (others => (others => '0'));
        end if;
    end process;   
end Behavioral;

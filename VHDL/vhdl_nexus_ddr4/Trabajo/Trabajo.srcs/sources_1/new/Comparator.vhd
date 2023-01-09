library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity Comparator is
   	generic(
    PASS_ELEMENTS: positive := 3;     -- Number of elements in the password
    INPUT_WIDTH: positive := 3;       -- Number of input's elements
    OUTPUT_WIDTH: positive := 3       -- Number of elements needed for output
    );
    port(
    RESET :         in std_logic;
    INPUT_PASSWORD : in std_logic_vector (INPUT_WIDTH downto 0);
    INPUT_ANSWER :  in std_logic_vector (INPUT_WIDTH downto 0);
    RESULT1 :       out std_logic_vector (OUTPUT_WIDTH downto 0);   --Results to to FSM
    RESULT2 :       out std_logic_vector (OUTPUT_WIDTH downto 0);
    RESULT3 :       out std_logic_vector (OUTPUT_WIDTH downto 0);
    RESULT4 :       out std_logic_vector (OUTPUT_WIDTH downto 0);
    COMPLETE:       out std_logic;      --Array completed
    CORRECT:        out std_logic       --Correct response      
    );
end Comparator;

architecture Behavioral of Comparator is
    type matrix is array (PASS_ELEMENTS downto 0) of std_logic_vector (OUTPUT_WIDTH downto 0);
    type matrix2 is array (PASS_ELEMENTS downto 0) of std_logic_vector (INPUT_WIDTH downto 0);
begin
    compare: process(INPUT_PASSWORD, INPUT_ANSWER, RESET)
        variable counter: integer := PASS_ELEMENTS;
        variable password : matrix2  := (others => ( others => '0'));
        variable answer : matrix2  := (others => ( others => '0'));
        variable results : matrix := (others => ( others => '0'));
        variable complete_i : std_logic := '0';
        variable correct_a : std_logic := '1';    
    begin
        if RESET = '0' then                                 -- Reset
        	COMPLETE <= '0';
        	CORRECT <= '0';
            RESULT1 <= "1111";
            RESULT2 <= "1111"; 
            RESULT3 <= "1111"; 
            RESULT4 <= "1111";
        elsif RESET = '1' then
            if INPUT_PASSWORD /= "0000" and password(0) = "0000" then     -- Receiving a password when it is uncompleted    
                for count in PASS_ELEMENTS downto 0 loop                
                    if password(count) = "0000" then
                        password(count) := INPUT_PASSWORD;  -- Places it in the last free slot of the array
                        counter := count;
                        exit;
                    end if;
                end loop;
                if counter = 0 then
                    complete_i := '1';                      -- If all slots have been completed, sends a signal
                end if;
            elsif INPUT_ANSWER /= "0000" then                -- Receiving an answer
                for count in PASS_ELEMENTS downto 0 loop 
                    if answer(count) = "0000" then
                        answer(count) := INPUT_ANSWER ;     -- Places it in the last free slot of the array
                        counter := count;
                        exit;
                    end if;
                end loop;
                if counter = 0 then                         -- Once the array is completed
                    for count in PASS_ELEMENTS downto 0 loop    -- Checks all the slots
                        if answer(count) = password(count) then
                                results(count) := "1000";       -- If the answer is correct, sends the correct symbol
                        else
                            correct_a := '0';                   -- Entering here means the answer is not correct
                            for count2 in PASS_ELEMENTS downto 0 loop
                                if answer(count) = password(count2) then
                                    results(count) := "0000";   -- The button is part of the password but it is not in place
                                    exit;
                                else
                                    results(count) := "1111";   -- The button is not in the password
                                end if;
                            end loop;
                        end if;        
                    end loop;
                    RESULT1 <= results(3);                       -- Overwrites the outputs   
                    RESULT2 <= results(2); 
                    RESULT3 <= results(1); 
                    RESULT4 <= results(0);
                    answer := (others => ( others => '0'));
                    results := (others => (others => '0'));
                    CORRECT <= correct_a;
                    correct_a := '1';
                    complete_i := '1';
                end if;                       
            end if;
        end if;
        COMPLETE <= complete_i;
        complete_i := '0';
    end process;
end Behavioral;
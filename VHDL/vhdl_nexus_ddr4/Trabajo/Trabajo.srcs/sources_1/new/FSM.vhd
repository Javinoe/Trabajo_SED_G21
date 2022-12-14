library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
   	generic(
    INPUT_WIDTH: positive := 3;       -- Number of input's elements
    OUTPUT_WIDTH: positive := 3       -- Number of elements needed for output
    );
    port (
    RESET :         in std_logic;
    CLK :           in std_logic;
    CREATEBUTTON:   in std_logic;   --Button for creation mode
    BUTTONPRESSED:  in std_logic_vector (INPUT_WIDTH downto 0);     --Buttons pressed during game
    -- Comparator
    COMPLETE:       in std_logic;   --Full answer given
    CORRECT:        in std_logic;   --Correct answer given      
    RESULT1 :       in std_logic_vector (OUTPUT_WIDTH downto 0);   -- Comparator results
    RESULT2 :       in std_logic_vector (OUTPUT_WIDTH downto 0);
    RESULT3 :       in std_logic_vector (OUTPUT_WIDTH downto 0);
    RESULT4 :       in std_logic_vector (OUTPUT_WIDTH downto 0);
    PASSWORD :      out std_logic_vector (INPUT_WIDTH downto 0);    --Signal to define password
    ANSWER :        out std_logic_vector (INPUT_WIDTH downto 0);    --Signal to define answer
    -- Display     
    DISPLAY1 :      out std_logic_vector(OUTPUT_WIDTH downto 0);   --Display orders
    DISPLAY2 :      out std_logic_vector(OUTPUT_WIDTH downto 0);
    DISPLAY3 :      out std_logic_vector(OUTPUT_WIDTH downto 0);
    DISPLAY4 :      out std_logic_vector(OUTPUT_WIDTH downto 0);
    DISPLAY5 :      out std_logic_vector(OUTPUT_WIDTH downto 0);
    DISPLAY6 :      out std_logic_vector(OUTPUT_WIDTH downto 0);
    DISPLAY7 :      out std_logic_vector(OUTPUT_WIDTH downto 0);
    DISPLAY8 :      out std_logic_vector(OUTPUT_WIDTH downto 0)   
    );
end FSM;

architecture behavioral of fsm is
    type STATES is (Start, Create, Waiting, S3, S2, S1, S0, Lose, Victory);
    signal current_state: STATES := Start;
    signal next_state: STATES;
begin
    state_register: process (RESET, CLK)
        begin
    	if RESET = '0' then
        	current_state <= Start;
        elsif rising_edge(CLK) then
        	current_state <= next_state;
        end if;
    end process;

    nextstate_decod: process (RESET, CREATEBUTTON, COMPLETE, CORRECT, BUTTONPRESSED, current_state)
    begin
        next_state <= current_state;
        case current_state is
            when Start =>
                if CREATEBUTTON = '1' then
                    next_state <= Create;
                end if;
            when Create =>
                if COMPLETE = '1' then
                    next_state <= Waiting;
                end if;
            when Waiting =>
                if BUTTONPRESSED = "0000" then
                    next_state <= S3;
                end if;
            when S3 =>
                if COMPLETE = '1' and CORRECT = '0' then
                    next_state <= S2;
                elsif COMPLETE = '1' and CORRECT = '1' then
                    next_state <= Victory;  
                end if;
            when S2 =>
                if COMPLETE = '1' and CORRECT = '0' then
                    next_state <= S1;
                elsif COMPLETE = '1' and CORRECT = '1' then
                    next_state <= Victory;   
                end if;
            when S1 =>
                if COMPLETE = '1' and CORRECT = '0' then
                    next_state <= S0;
                elsif COMPLETE = '1' and CORRECT = '1' then
                    next_state <= Victory;   
                end if;
            when S0 =>
                if COMPLETE = '1' and CORRECT = '0' then
                    next_state <= Lose;
                elsif COMPLETE = '1' and CORRECT = '1' then
                    next_state <= Victory;
                end if;
            when Victory =>
                if RESET = '0' then
                    next_state <= Start;
                end if;
            when Lose =>
                if RESET = '0' then
                    next_state <= Start;
                end if;             

            when others =>
                next_state <= Start;
        end case;
    end process;
    
    output_decod: process (current_state, BUTTONPRESSED, RESULT1, RESULT2, RESULT3, RESULT4)
    begin
--        DISPLAY1  <= (OTHERS => '0');
--        DISPLAY2  <= (OTHERS => '0');
--        DISPLAY3  <= (OTHERS => '0');
--        DISPLAY4  <= (OTHERS => '0');
--        DISPLAY5  <= (OTHERS => '0');
--        DISPLAY6  <= (OTHERS => '0');
--        DISPLAY7  <= (OTHERS => '0');
--        DISPLAY8  <= (OTHERS => '0');
        PASSWORD  <= "0000";
        ANSWER    <= "0000";
        case current_state is
            when Start  =>
                DISPLAY1 <= "1010"; --g
                DISPLAY2 <= "1011"; --u
                DISPLAY3 <= "1100"; --e
                DISPLAY4 <= "1101"; --s
                DISPLAY5 <= "1101"; --s
                DISPLAY6 <= "1001"; --9
                DISPLAY7 <= "0000"; --0
                DISPLAY8 <= "0000"; --0
                PASSWORD  <= "0000";
                ANSWER    <= "0000";
            when Create =>
                DISPLAY1 <= "1111"; ---
                DISPLAY2 <= "1111"; ---
                DISPLAY3 <= "1111"; ---
                DISPLAY4 <= "1111"; ---
                DISPLAY5 <= "1111"; ---
                DISPLAY6 <= "1111"; ---
                DISPLAY7 <= "1111"; ---
                DISPLAY8 <= "1111"; ---
                PASSWORD <= BUTTONPRESSED;
                ANSWER    <= "0000";
            when S3 =>
                DISPLAY1 <= "1110"; --??
                DISPLAY2 <= "1110"; --??
                DISPLAY3 <= "1110"; --??
                DISPLAY4 <= "1110"; --??
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
                PASSWORD  <= "0000";
            when S2 =>
                DISPLAY1 <= "1110"; --??
                DISPLAY2 <= "1110"; --??
                DISPLAY3 <= "1110"; --??
                DISPLAY4 <= "1111"; ---
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
                PASSWORD  <= "0000";
            when S1 =>
                DISPLAY1 <= "1110"; --??
                DISPLAY2 <= "1110"; --??
                DISPLAY3 <= "1111"; ---
                DISPLAY4 <= "1111"; ---
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
                PASSWORD  <= "0000";
            when S0 =>
                DISPLAY1 <= "1110"; --??
                DISPLAY2 <= "1111"; ---
                DISPLAY3 <= "1111"; ---
                DISPLAY4 <= "1111"; ---
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
                PASSWORD  <= "0000";
            when Victory   =>
                DISPLAY1 <= "1000"; --8
                DISPLAY2 <= "1000"; --8
                DISPLAY3 <= "1000"; --8
                DISPLAY4 <= "1000"; --8
                DISPLAY5 <= "1000"; --8
                DISPLAY6 <= "1000"; --8
                DISPLAY7 <= "1000"; --8
                DISPLAY8 <= "1000"; --8
                PASSWORD  <= "0000";
                ANSWER    <= "0000";
            when Lose    =>
                DISPLAY1 <= "1111"; ---
                DISPLAY2 <= "1111"; ---
                DISPLAY3 <= "1111"; ---
                DISPLAY4 <= "1111"; ---
                DISPLAY5 <= "1111"; ---
                DISPLAY6 <= "1111"; ---
                DISPLAY7 <= "1111"; ---
                DISPLAY8 <= "1111"; ---
                PASSWORD  <= "0000";
                ANSWER    <= "0000";
            when others =>
                DISPLAY1  <= (OTHERS => '0');
                DISPLAY2  <= (OTHERS => '0');
                DISPLAY3  <= (OTHERS => '0');
                DISPLAY4  <= (OTHERS => '0');
                DISPLAY5  <= (OTHERS => '0');
                DISPLAY6  <= (OTHERS => '0');
                DISPLAY7  <= (OTHERS => '0');
                DISPLAY8  <= (OTHERS => '0');
                PASSWORD  <= "0000";
                ANSWER    <= "0000";
        end case;
    end process;
end behavioral;

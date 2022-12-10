library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FSM is
    port (
    RESET :         in std_logic;
    CLK :           in std_logic;
    CREATEBUTTON:   in std_logic;   --Button for creation mode
    BUTTONPRESSED:  in integer;     --Buttons pressed during game
    -- Comparator
    COMPLETE:       in std_logic;   --Full answer given
    CORRECT:        in std_logic;   --Correct answer given      
    RESULT1 :       in std_logic_vector (3 downto 0);   --Comparator results
    RESULT2 :       in std_logic_vector (3 downto 0);
    RESULT3 :       in std_logic_vector (3 downto 0);
    RESULT4 :       in std_logic_vector (3 downto 0);
    PASSWORD :      out integer;    --Signal to define password
    ANSWER :        out integer;    --Signal to define answer
    -- Display     
    DISPLAY1 :      out std_logic_vector(3 downto 0);   --Display orders
    DISPLAY2 :      out std_logic_vector(3 downto 0);
    DISPLAY3 :      out std_logic_vector(3 downto 0);
    DISPLAY4 :      out std_logic_vector(3 downto 0);
    DISPLAY5 :      out std_logic_vector(3 downto 0);
    DISPLAY6 :      out std_logic_vector(3 downto 0);
    DISPLAY7 :      out std_logic_vector(3 downto 0);
    DISPLAY8 :      out std_logic_vector(3 downto 0)   
    );
end FSM;

architecture behavioral of fsm is
    type STATES is (Start, Create, S3, S2, S1, S0, Lose, Victory);
    signal current_state: STATES := Start;
    signal next_state: STATES;
begin
    state_register: process (RESET, CLK)
        begin
    	if RESET = '0' then
        	current_state <= Start;
        elsif rising_edge(clk) then
        	current_state <= next_state;
        end if;
    end process;

    nextstate_decod: process (COMPLETE, CORRECT, current_state)
    begin
        next_state <= current_state;
        case current_state is
            when START =>
                if CREATEBUTTON = '1' then
                    next_state <= Create;
                end if;
            when Create =>
                if CREATEBUTTON = '0' and COMPLETE = '1' then
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

            when others =>
                next_state <= Start;
        end case;
    end process;
    
    output_decod: process (current_state)
    begin
        DISPLAY1  <= (OTHERS => '0');
        DISPLAY2  <= (OTHERS => '0');
        DISPLAY3  <= (OTHERS => '0');
        DISPLAY4  <= (OTHERS => '0');
        DISPLAY5  <= (OTHERS => '0');
        DISPLAY6  <= (OTHERS => '0');
        DISPLAY7  <= (OTHERS => '0');
        DISPLAY8  <= (OTHERS => '0');
        PASSWORD  <= 0;
        ANSWER    <= 0;
        case current_state is
            when Start  =>
                DISPLAY1 <= "1010";
                DISPLAY2 <= "1011";
                DISPLAY3 <= "1100";
                DISPLAY4 <= "1101";
                DISPLAY5 <= "1101";
                DISPLAY6 <= "1001";
                DISPLAY7 <= "0000";
                DISPLAY8 <= "0000";
            when Create =>
                DISPLAY1 <= "1111";
                DISPLAY2 <= "1111";
                DISPLAY3 <= "1111";
                DISPLAY4 <= "1111";
                DISPLAY5 <= "1111";
                DISPLAY6 <= "1111";
                DISPLAY7 <= "1111";
                DISPLAY8 <= "1111";
                PASSWORD <= BUTTONPRESSED;
            when S3 =>
                DISPLAY1 <= "1110";
                DISPLAY2 <= "1110";
                DISPLAY3 <= "1110";
                DISPLAY4 <= "1110";
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
            when S2 =>
                DISPLAY1 <= "1110";
                DISPLAY2 <= "1110";
                DISPLAY3 <= "1110";
                DISPLAY4 <= "1111";
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
            when S1 =>
                DISPLAY1 <= "1110";
                DISPLAY2 <= "1110";
                DISPLAY3 <= "1111";
                DISPLAY4 <= "1111";
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
            when S0 =>
                DISPLAY1 <= "1110";
                DISPLAY2 <= "1111";
                DISPLAY3 <= "1111";
                DISPLAY4 <= "1111";
                DISPLAY5 <= RESULT1;
                DISPLAY6 <= RESULT2;
                DISPLAY7 <= RESULT3;
                DISPLAY8 <= RESULT4;
                ANSWER   <= BUTTONPRESSED;
            when Victory   =>
                DISPLAY1 <= "1000";
                DISPLAY2 <= "1000";
                DISPLAY3 <= "1000";
                DISPLAY4 <= "1000";
                DISPLAY5 <= "1000";
                DISPLAY6 <= "1000";
                DISPLAY7 <= "1000";
                DISPLAY8 <= "1000";
            when Lose    =>
                DISPLAY1 <= "1111";
                DISPLAY2 <= "1111";
                DISPLAY3 <= "1111";
                DISPLAY4 <= "1111";
                DISPLAY5 <= "1111";
                DISPLAY6 <= "1111";
                DISPLAY7 <= "1111";
                DISPLAY8 <= "1111";
            when others =>
                DISPLAY1  <= (OTHERS => '0');
                DISPLAY2  <= (OTHERS => '0');
                DISPLAY3  <= (OTHERS => '0');
                DISPLAY4  <= (OTHERS => '0');
                DISPLAY5  <= (OTHERS => '0');
                DISPLAY6  <= (OTHERS => '0');
                DISPLAY7  <= (OTHERS => '0');
                DISPLAY8  <= (OTHERS => '0');
                PASSWORD  <= 0;
                ANSWER    <= 0;
        end case;
    end process;
end behavioral;
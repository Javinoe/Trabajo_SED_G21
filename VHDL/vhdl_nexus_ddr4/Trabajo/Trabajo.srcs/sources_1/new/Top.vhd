library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
   	generic(
    PASS_ELEMENTS: positive := 3;     -- Number of elements in the password
    INPUT_WIDTH: positive := 3;       -- Number of input's elements
    OUTPUT_WIDTH: positive := 3       -- Number of elements needed for output
    );
    port (
    RESET : in std_logic;
    CLK : in std_logic;
    x9, x8, x7, x6, x5, x4, x3, x2, x1 : in std_logic;
    CREATEBUTTON:   in std_logic;
    --variables to segment driver
    topsegA : out std_logic;
    topsegB : out std_logic;
    topsegC : out std_logic;
    topsegD : out std_logic;
    topsegE : out std_logic;
    topsegF : out std_logic;
    topsegG : out std_logic;
    topselect_display_A : out std_logic;
    topselect_display_B : out std_logic;
    topselect_display_C : out std_logic;
    topselect_display_D : out std_logic;
    topselect_display_E : out std_logic;
    topselect_display_F : out std_logic;
    topselect_display_G : out std_logic;
    topselect_display_H : out std_logic
    );
end top;

architecture behavioral of top is

component Synchrnzr 
    port (
    CLK : in std_logic;
    ASYNC_IN : in std_logic_vector (INPUT_WIDTH downto 0);
    SYNC_OUT : out std_logic_vector (INPUT_WIDTH downto 0)
    );
end component;

component Edgedtctr
    port (
    CLK : in std_logic;
    SYNC_IN : in std_logic_vector (INPUT_WIDTH downto 0);
    EDGE : out std_logic_vector (INPUT_WIDTH downto 0)
    );
end component;

component Encoder
    port(
    BUTTONPRESSED : out std_logic_vector (INPUT_WIDTH downto 0);
    x9 : in std_logic;
    x8 : in std_logic;
    x7 : in std_logic; 
    x6 : in std_logic;
    x5 : in std_logic;
    x4 : in std_logic;
    x3 : in std_logic;
    x2 : in std_logic; 
    x1 : in std_logic
    );
end component;

component FSM
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
end component;

component Comparator
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
end component;

component segmentdriver
    port(
    DISPLAY_A : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_B : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_C : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_D : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_E : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_F : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_G : in STD_LOGIC_VECTOR (3 downto 0);
    DISPLAY_H : in STD_LOGIC_VECTOR (3 downto 0);
    SEG_A : out STD_LOGIC;
    SEG_B : out STD_LOGIC;
    SEG_C : out STD_LOGIC;
    SEG_D : out STD_LOGIC;
    SEG_E : out STD_LOGIC;
    SEG_F : out STD_LOGIC;
    SEG_G : out STD_LOGIC;
    SELECT_DISPLAY_A : out STD_LOGIC;
    SELECT_DISPLAY_B : out STD_LOGIC;
    SELECT_DISPLAY_C : out STD_LOGIC;
    SELECT_DISPLAY_D : out STD_LOGIC;
    SELECT_DISPLAY_E : out STD_LOGIC;
    SELECT_DISPLAY_F : out STD_LOGIC;
    SELECT_DISPLAY_G : out STD_LOGIC;
    SELECT_DISPLAY_H : out STD_LOGIC;
    CLK : in STD_LOGIC
    );
end component;

--Signals between Encoder and Synchrnzr
signal buttonpressed_es: std_logic_vector (INPUT_WIDTH downto 0);
--Signals between Synchrnzr  and Edge detector
signal syncbutton_se: std_logic_vector (INPUT_WIDTH downto 0);
--Signals between Edge detector and FSM
signal buttonpressed_ef: std_logic_vector (INPUT_WIDTH downto 0);
-- Signals between FSM and Comparator
signal complete_cf : std_logic;
signal correct_cf : std_logic;
signal result1_cf : std_logic_vector (OUTPUT_WIDTH downto 0);
signal result2_cf : std_logic_vector (OUTPUT_WIDTH downto 0);
signal result3_cf : std_logic_vector (OUTPUT_WIDTH downto 0);
signal result4_cf : std_logic_vector (OUTPUT_WIDTH downto 0);
signal password_fc : std_logic_vector (INPUT_WIDTH downto 0);
signal answer_fc : std_logic_vector (INPUT_WIDTH downto 0);
--Signals between FSM and Display
signal display1_fd : std_logic_vector(OUTPUT_WIDTH downto 0);   --Binary code for displays
signal display2_fd : std_logic_vector(OUTPUT_WIDTH downto 0);
signal display3_fd : std_logic_vector(OUTPUT_WIDTH downto 0);
signal display4_fd : std_logic_vector(OUTPUT_WIDTH downto 0);
signal display5_fd : std_logic_vector(OUTPUT_WIDTH downto 0);
signal display6_fd : std_logic_vector(OUTPUT_WIDTH downto 0);
signal display7_fd : std_logic_vector(OUTPUT_WIDTH downto 0);
signal display8_fd : std_logic_vector(OUTPUT_WIDTH downto 0);
    
begin
Inst_encoder: Encoder PORT MAP(
    BUTTONPRESSED => buttonpressed_es,
    x9 => x9,
    x8 => x8,
    x7 => x7,
    x6 => x6,
    x5 => x5,
    x4 => x4,
    x3 => x3,
    x2 => x2,
    x1 => x1
);

Inst_synchrnzr: Synchrnzr PORT MAP (
    CLK => CLK,
    ASYNC_IN => buttonpressed_es,
    SYNC_OUT => syncbutton_se
);

Inst_edgedtctr: Edgedtctr PORT MAP (
    CLK => CLK,
    SYNC_IN => syncbutton_se,
    EDGE => buttonpressed_ef
);

Inst_FSM: FSM PORT MAP (
    RESET => RESET,
    CLK => CLK,
    CREATEBUTTON => CREATEBUTTON,
    BUTTONPRESSED => buttonpressed_ef,
    -- Comparator
    COMPLETE => complete_cf,
    CORRECT => correct_cf,  
    RESULT1 => result1_cf,
    RESULT2 => result2_cf,
    RESULT3 => result3_cf,
    RESULT4 => result4_cf,
    PASSWORD => password_fc,
    ANSWER => answer_fc,
    -- Display     
    DISPLAY1 => display1_fd,
    DISPLAY2 => display2_fd,
    DISPLAY3 => display3_fd,
    DISPLAY4 => display4_fd,
    DISPLAY5 => display5_fd,
    DISPLAY6 => display6_fd,
    DISPLAY7 => display7_fd,
    DISPLAY8 => display8_fd
);
Inst_comparator: Comparator PORT MAP (
    RESET => RESET,
    INPUT_PASSWORD => password_fc,
    INPUT_ANSWER => answer_fc,
    RESULT1 => result1_cf,
    RESULT2 => result2_cf,
    RESULT3 => result3_cf,
    RESULT4 => result4_cf,
    COMPLETE => complete_cf,
    CORRECT => correct_cf 
);
Inst_segmentdriver: segmentdriver PORT MAP(
    DISPLAY_A => display1_fd,
    DISPLAY_B => display2_fd,
    DISPLAY_C => display3_fd, 
    DISPLAY_D => display4_fd,
    DISPLAY_E => display5_fd,
    DISPLAY_F => display6_fd,
    DISPLAY_G => display7_fd,
    DISPLAY_H => display8_fd,
    CLK => CLK,
    SEG_A => topsegA,
    SEG_B => topsegB,
    SEG_C => topsegC,
    SEG_D => topsegD,
    SEG_E => topsegE,
    SEG_F => topsegF,
    SEG_G => topsegG,
    SELECT_DISPLAY_A => topselect_display_H,
    SELECT_DISPLAY_B => topselect_display_G,
    SELECT_DISPLAY_C => topselect_display_F,
    SELECT_DISPLAY_D => topselect_display_E,
    SELECT_DISPLAY_E => topselect_display_D,
    SELECT_DISPLAY_F => topselect_display_C,
    SELECT_DISPLAY_G => topselect_display_B,
    SELECT_DISPLAY_H => topselect_display_A
);
end behavioral;
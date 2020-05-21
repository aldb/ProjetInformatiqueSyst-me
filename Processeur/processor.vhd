----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.04.2020 14:47:45
-- Design Name: 
-- Module Name: processor - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity processor is
  Port ( CLK : in STD_LOGIC;
         RESET : in STD_LOGIC);
end processor;

architecture Behavioral of processor is
    component Registre
        Port ( atA : in STD_LOGIC_VECTOR (3 downto 0);
               atB : in STD_LOGIC_VECTOR (3 downto 0);
               atW : in STD_LOGIC_VECTOR (3 downto 0);
               W : in STD_LOGIC;
               DATA : in STD_LOGIC_VECTOR (7 downto 0);
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               QA : out STD_LOGIC_VECTOR (7 downto 0);
               QB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component pipeline
        Port ( OP_in : in STD_LOGIC_VECTOR (3 downto 0);
               A_in : in  STD_LOGIC_VECTOR (7 downto 0);
               B_in : in  STD_LOGIC_VECTOR (7 downto 0);
               C_in : in  STD_LOGIC_VECTOR (7 downto 0);
               OP_out : out STD_LOGIC_VECTOR (3 downto 0);
               A_out : out  STD_LOGIC_VECTOR (7 downto 0);
               B_out : out  STD_LOGIC_VECTOR (7 downto 0);
               C_out : out  STD_LOGIC_VECTOR (7 downto 0);
               Clk : in  STD_LOGIC );
    end component;

    component data_memory
        Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
               data_IN : in STD_LOGIC_VECTOR (7 downto 0);
               RW : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               data_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component alu
        Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
               b : in  STD_LOGIC_VECTOR (7 downto 0);
               S : out  STD_LOGIC_VECTOR (7 downto 0);
               Ctrl_Alu : in  STD_LOGIC_VECTOR (3 downto 0);
               Flag_n : out  STD_LOGIC;
               Flag_o : out  STD_LOGIC;
               Flag_z : out  STD_LOGIC;
               Flag_c : out  STD_LOGIC);
    end component;

    component instruction_memory
        Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               instru_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    component counter
        Port ( CLK : in  STD_LOGIC;
               RST_N : in  STD_LOGIC;
               LOAD : in  STD_LOGIC;
               SENS : in  STD_LOGIC;
               EN_N : in  STD_LOGIC;
               Din : in  STD_LOGIC_VECTOR (7 downto 0);
               Dout : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    
    -- Signaux
    signal Ins_Addr : STD_LOGIC_VECTOR (7 downto 0);
    signal Ins_Out_A, Ins_Out_B, Ins_Out_C : STD_LOGIC_VECTOR (7 downto 0);
    signal Ins_Out_OP : STD_LOGIC_VECTOR (3 downto 0);
    
    signal Mux1, Mux2, Mux3, Mux4 : STD_LOGIC_VECTOR (7 downto 0);
    
    signal LC1 : STD_LOGIC_VECTOR (3 downto 0);
    signal LC2, LC3 : STD_LOGIC := '0';
    
    signal Instu_Mem_OUT : STD_LOGIC_VECTOR (31 downto 0);
    
    signal BancReg_QA, BancReg_QB : STD_LOGIC_VECTOR (7 downto 0);
    
    signal Ual_S : STD_LOGIC_VECTOR (7 downto 0);
    
    signal Data_Mem_OUT : STD_LOGIC_VECTOR (7 downto 0);
    
    signal LiDi_Pip_OP, DiEx_Pip_OP, ExMem_Pip_OP, MemRe_Pip_OP : STD_LOGIC_VECTOR (3 downto 0);
    signal LiDi_Pip_A, LiDi_Pip_B, LiDi_Pip_C, DiEx_Pip_A, DiEx_Pip_B, DiEx_Pip_C, ExMem_Pip_A, ExMem_Pip_B, ExMem_Pip_C, MemRe_Pip_A, MemRe_Pip_B, MemRe_Pip_C : STD_LOGIC_VECTOR (7 downto 0);
    signal ExMem_Pip_aux : STD_LOGIC_VECTOR (7 downto 0);
begin


Compteur : counter
    PORT MAP (
        CLK => CLK,
        RST_N => RESET,
        LOAD => '0',
        SENS => '1',
        EN_N => '0',
        Din => x"00",
        Dout => Ins_Addr);


Instu_Mem : instruction_memory
    PORT MAP (
        addr => Ins_Addr,
        CLK => CLK,
        instru_OUT => Instu_Mem_OUT);
        

BancReg : registre
    PORT MAP (
        atA => LiDi_Pip_B (3 downto 0),
        atB => LiDi_Pip_C (3 downto 0),
        atW => MemRe_Pip_A (3 downto 0),
        W => LC3,
        DATA => MemRe_Pip_B,
        RST => RESET,
        CLK => CLK,
        QA => BancReg_QA,
        QB => BancReg_QB);
    
    
Ual : alu
    PORT MAP (
        a => DiEx_Pip_B,
        b => DiEx_Pip_C,
        S => Ual_S,
        Ctrl_Alu => LC1,
        Flag_n => open,
        Flag_o => open,
        Flag_z => open,
        Flag_c => open);
        
        
Data_Mem : data_memory
    PORT MAP (
        addr => Mux3,
        data_IN => ExMem_Pip_B,
        RW => LC2,
        RST => RESET,
        CLK => CLK,
        data_OUT => Data_Mem_OUT);


LiDi_Pip : pipeline
    PORT MAP (
        OP_in => Ins_Out_OP,
        A_in => Ins_Out_A,
        B_in => Ins_Out_B,
        C_in => Ins_Out_C,
        OP_out => LiDi_Pip_OP,
        A_out => LiDi_Pip_A,
        B_out => LiDi_Pip_B,
        C_out => LiDi_Pip_C,
        Clk => CLK);
    
DiEx_Pip : pipeline
    PORT MAP (
        OP_in => LiDi_Pip_OP,
        A_in => LiDi_Pip_A,
        B_in => Mux1,
        C_in => BancReg_QB,
        OP_out => DiEx_Pip_OP,
        A_out => DiEx_Pip_A,
        B_out => DiEx_Pip_B,
        C_out => DiEx_Pip_C,
        Clk => CLK);
    
ExMem_Pip : pipeline
    PORT MAP (
        OP_in => DiEx_Pip_OP,
        A_in => DiEx_Pip_A,
        B_in => Mux2,
        C_in => x"00",
        OP_out => ExMem_Pip_OP,
        A_out => ExMem_Pip_A,
        B_out => ExMem_Pip_B,
        C_out => open,
        Clk => CLK);
    
MemRe_Pip : pipeline
    PORT MAP (
        OP_in => ExMem_Pip_OP,
        A_in => ExMem_Pip_aux,
        B_in => Mux4,
        C_in => x"00",
        OP_out => MemRe_Pip_OP,
        A_out => MemRe_Pip_A,
        B_out => MemRe_Pip_B,
        C_out => open,
        CLK => CLK);


Mux1 <= BancReg_QA when LiDi_Pip_OP = x"1"
                             or LiDi_Pip_OP = x"2"
                             or LiDi_Pip_OP = x"3"
                             or LiDi_Pip_OP = x"4"
                             or LiDi_Pip_OP = x"5"
                             or LiDi_Pip_OP = x"8"
   else LiDi_Pip_B;
                           
Mux2 <= Ual_S when DiEx_Pip_OP <= x"4"
   else DiEx_Pip_B;
   
Mux3 <= ExMem_Pip_A when ExMem_Pip_OP = x"8"
   else ExMem_Pip_B;

Mux4 <= Data_Mem_OUT when MemRe_Pip_OP = x"7"
   else ExMem_Pip_B;
   
   
ExMem_Pip_aux <= MemRe_Pip_A when MemRe_Pip_OP = x"7"
          else ExMem_Pip_A; -- corrige le retard de data_memory au load

   
LC1 <= DiEx_Pip_OP;
  
LC2 <= '1' when ExMem_Pip_OP = x"8" else '0';  -- 1 for store

LC3 <= '0' when MemRe_Pip_OP = x"8" -- 0 for store
           else '1';
           
    
Ins_Out_OP <= Instu_Mem_OUT (27 downto 24);

Ins_Out_A <= Instu_Mem_OUT (23 downto 16);
        
Ins_Out_B <= Instu_Mem_OUT (15 downto 8);

Ins_Out_C <= Instu_Mem_OUT (7 downto 0);


end Behavioral;

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
    component Registre is
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
    
    component pipeline is
        Port ( OP_in : in STD_LOGIC_VECTOR (4 downto 0);
               A_in : in  STD_LOGIC_VECTOR (7 downto 0);
               B_in : in  STD_LOGIC_VECTOR (7 downto 0);
               C_in : in  STD_LOGIC_VECTOR (7 downto 0);
                  OP_out : out STD_LOGIC_VECTOR (4 downto 0);
               A_out : out  STD_LOGIC_VECTOR (7 downto 0);
               B_out : out  STD_LOGIC_VECTOR (7 downto 0);
               C_out : out  STD_LOGIC_VECTOR (7 downto 0);
                  Clk : in  STD_LOGIC );
    end component;

    component data_memory is
        Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
               data_IN : in STD_LOGIC_VECTOR (7 downto 0);
               RW : in STD_LOGIC;
               RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               data_OUT : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component alu is
        Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
               b : in  STD_LOGIC_VECTOR (7 downto 0);
               S : out  STD_LOGIC_VECTOR (7 downto 0);
               Ctrl_Alu : in  STD_LOGIC_VECTOR (4 downto 0);
               Flag_n : out  STD_LOGIC;
               Flag_o : out  STD_LOGIC;
               Flag_z : out  STD_LOGIC;
               Flag_c : out  STD_LOGIC);
    end component;

    component instruction_memory is
        Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
               CLK : in STD_LOGIC;
               instru_OUT : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

begin

Instu_Mem : instruction_memory
    PORT MAP (
        addr =>
        CLK => CLK;
        instru_OUT => );

LiDi_Pip : pipeline
    PORT MAP (
    OP_in =>
    A_in =>
    B_in =>
    C_in =>
    OP_out => DiEx_Pip.OP_in;
    A_out => DiEx_Pip.A_in;
    B_out =>
    C_out =>
    Clk => CLK);


end Behavioral;

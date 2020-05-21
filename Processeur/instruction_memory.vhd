----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2020 15:25:46
-- Design Name: 
-- Module Name: instruction_memory - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           instru_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end instruction_memory;

architecture Behavioral of instruction_memory is
    type instruction_memory is array (0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
    signal ins : instruction_memory := (
    0 => x"06010300", -- affec
    10 => x"05020100", -- copy
    20 => x"02030202", -- mul
    25 => x"03010203", -- sub
    30 => x"01040202", -- add
    35 => x"08020100", -- store 6
    40 => x"07060200", -- load
    others => x"90FFFFFF"
    );

begin

p : process
        begin
            wait until CLK'event and CLK= '1';
            instru_OUT <= ins(to_integer(unsigned(addr)));
    end process p;
    
end Behavioral;

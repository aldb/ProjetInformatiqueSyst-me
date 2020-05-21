----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2020 15:25:46
-- Design Name: 
-- Module Name: data_memory - Behavioral
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

entity data_memory is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           data_IN : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           data_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end data_memory;

architecture Behavioral of data_memory is
    type data_memory is array (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
    signal Mem : data_memory := (others => (others => '0'));
    
begin
    
    p : process
        begin
            wait until CLK'event and CLK= '1';
            if RST = '0' then
                Mem  <= (others => (others => '0'));
            else
                if RW = '1' then
                    Mem(to_integer(unsigned(addr))) <= data_IN;
                else
                    data_OUT <= Mem(to_integer(unsigned(addr)));
                end if;
            end if;
    end process p;
end Behavioral;

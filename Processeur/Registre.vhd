----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2020 14:49:57
-- Design Name: 
-- Module Name: Register - Behavioral
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

entity Registre is
    Port ( atA : in STD_LOGIC_VECTOR (3 downto 0);
           atB : in STD_LOGIC_VECTOR (3 downto 0);
           atW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Registre;

architecture Behavioral of Registre is
    type Registre is array (0 to 15) of STD_LOGIC_VECTOR (7 downto 0);
    signal Reg : Registre := (others => (others => '0'));

begin
    p : process
        begin
            wait until CLK'event and CLK= '0';
            if RST = '0' then
                Reg  <= (others => (others => '0'));
            else
                if W = '1' then
                    Reg(to_integer(unsigned(atW))) <= DATA;
                end if;
            end if;
    end process p;
    
    QA <= Reg(to_integer(unsigned(atA))) when atW /= atA else DATA;
    QB <= Reg(to_integer(unsigned(atB))) when atW /= atB else DATA;

end Behavioral;

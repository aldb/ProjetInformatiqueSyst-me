----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:00:36 03/24/2020 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( CLK : in  STD_LOGIC;
           RST_N : in  STD_LOGIC;
           LOAD : in  STD_LOGIC;
           SENS : in  STD_LOGIC;
           EN_N : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (7 downto 0);
           Dout : out  STD_LOGIC_VECTOR (7 downto 0));
end counter;

architecture Behavioral of counter is

    signal AUX: STD_LOGIC_VECTOR (7 downto 0);

begin
--Concurrents
--Paralelle et continue
--Seauentiel
counter: process --list de sensibilit2
begin
--front montant 1
wait until CLK'event and CLK= '1';
--front montant 2
    if(RST_N='0') then
    AUX<=X"00";
    else 
        if(LOAD='1') then
        --chargerDin dans le conteur et afficher DOUT
            AUX<=Din;
        else 
            if(EN_N='0') then
                --counter va compter ou déconter en fonction de SENS
                if (SENS='1') then
                    AUX<=AUX+1;
                else 
                    AUX<=AUX-1;
                end if; 
            end if;
        end if;
    end if;

end process counter;

Dout<=AUX; --en parallele du process clock 

end Behavioral;

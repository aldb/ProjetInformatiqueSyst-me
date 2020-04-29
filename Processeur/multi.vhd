----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:42:26 04/24/2020 
-- Design Name: 
-- Module Name:    multi - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multi is
    Port ( OP : in STD_LOGIC_VECTOR (4 downto 0);
			  B_in : in  STD_LOGIC_VECTOR (0 downto 7);
           QB_in : in  STD_LOGIC_VECTOR (0 downto 7);
           S : out  STD_LOGIC_VECTOR (0 downto 7));
end multi;

architecture Behavioral of multi is

begin

	S<= 
		B_in when OP =x"06"
	else 
		QB_in ;
		

end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:16:54 04/15/2020 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (3 downto 0);
           Flag_n : out  STD_LOGIC;
           Flag_o : out  STD_LOGIC;
           Flag_z : out  STD_LOGIC;
           Flag_c : out  STD_LOGIC);
end alu;

architecture Behavioral of alu is
signal resultat_tmp : STD_LOGIC_VECTOR (8 downto 0);
signal resultat_tmp_mul : STD_LOGIC_VECTOR (15 downto 0);

begin

p : process(Ctrl_Alu, a, b, resultat_tmp, resultat_tmp_mul)

begin

     S <= x"00";
     Flag_o <= '0';
     Flag_z <= '0';
     Flag_n <= '0';
     Flag_c <= '0';
     resultat_tmp <= "000000000";
     resultat_tmp_mul <= x"0000";

		--addition 
    if Ctrl_Alu="0001"	 then
         resultat_tmp <= (b"0" & a) + (b"0" & b);
			S <= resultat_tmp(7 downto 0);
			if resultat_tmp= x"0" then
				Flag_z <= '1';
			else 
				Flag_z <= '0';
			end if;
			Flag_n <= resultat_tmp(7);
			Flag_c <= resultat_tmp(8);
			if (a(7)='1' and b(7)='1' and resultat_tmp(8)='0') or (a(7)='0' and b(7)='0' and resultat_tmp(8)='1') then
				Flag_o <='1';
			else 
				Flag_o <='0';
			end if; 
		  --soustraction 
    else 
			if Ctrl_Alu="0011" then
				resultat_tmp <= (b"0" & a) - (b"0" & b);
				S <= resultat_tmp(7 downto 0);
				if resultat_tmp= x"0" then
					Flag_z <= '1';
				else 
					Flag_z <= '0';
				end if;
				Flag_c <= resultat_tmp(8);
				Flag_n <= resultat_tmp(7);
				
				if (a(7)='0' and b(7)='1' and resultat_tmp(8)='1') or (a(7)='1' and b(7)='0' and resultat_tmp(8)='0') then
					Flag_o <= '1';
				else 
					Flag_o <= '0';
				--multiplication 
				end if; 
			else 
					if Ctrl_Alu="0010" then 
							resultat_tmp_mul<= a*b;
							S <= resultat_tmp_mul(7 downto 0);
							if resultat_tmp_mul(15 downto 8)/= x"0" then 
								Flag_o <= '1';
							else
								Flag_o <= '0';
							end if; 
							
							if resultat_tmp = x"0" then
								Flag_z <= '1';
							else 
								Flag_z <= '0';
							end if;
							Flag_c <= '0';
							Flag_n <= resultat_tmp(7);
				
			 end if;
			 
	end if; 
end if;
end process p;



end Behavioral;
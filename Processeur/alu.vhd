architecture Behavioral of alu is
signal resultat_tmp : STD_LOGIC_VECTOR (8 downto 0);
signal resultat_tmp_mul : STD_LOGIC_VECTOR (14 downto 0);

begin

p : process
begin
		--addition 
    if Ctrl_Alu="001"	 then
         resultat_tmp <= (b"0" & a) + (b"0" & b);
			S <= resultat_tmp(7 downto 0);
			if resultat_tmp= x"0" then
				Flag_z <= "1";
			else 
				Flag_z <= "0";
			end if;
			Flag_n <= resultat_tmp(7);
			Flag_c <= resultat_tmp(8);
			if (a(7)="1" and b(7)="1" and resultat_tmp(8)="0") or (a(7)="0" and b(7)="0" and resultat_tmp(8)="1")
				Flag_o <=1;
			else 
				Flag_o <=0;
		  --soustraction 
    else 
			if Ctrl_Alu="011" then
				resultat_tmp <= (b"0" & a) - (b"0" & b);
				S <= resultat_tmp(7 downto 0);
				if resultat_tmp= x"0" then
					Flag_z <= "1";
				else 
					Flag_z <= "0";
				end if;
				Flag_c <= resultat_tmp(8);
				Flag_n <= resultat_tmp(7);
				
				if (a(7)="0" and b(7)="1" and resultat_tmp(8)="1") or (a(7)="1" and b(7)="0" and resultat_tmp(8)="0")
					Flag_o <=1;
				else 
					Flag_o <=0;
				--multiplication 
			else 
					if Ctrl_Alu="010" then 
							resultat_tmp_mul<= a*b;
							S <= resultat_tmp_mul(7 downto 0);
							if resultat_tmp_mul(14 downto 8)/= x"0" then 
								Flag_o <= '1';
							else
								Flag_o <= '0';
							end if; 
							
							if resultat_tmp = x"0" then
								Flag_z <= "1";
							else 
								Flag_z <= "0";
							end if;
							Flag_c <= "0";
							Flag_n <= resultat_tmp(7);
			 end if;
	end if; 
end if;
end process p;



end Behavioral;


library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity alu8bit is
	port(a, b : in std_logic_vector(7 downto 0);	
		op : in std_logic_vector(2 downto 0);
		zero : out std_logic;
		carry : out std_logic;
		negative : out std_logic;
		overflow : out std_logic;
	    f : out std_logic_vector(7 downto 0));
END alu8bit;

architecture behavioral of alu8bit is
begin
	process(op)
	variable temp: std_logic_vector(7 downto 0);
	begin
	case op is
		when "000" =>
			temp := a and b;
		when "100" =>
			temp := a and b;
		when "001" =>
			temp := a or b;
		when "101" =>
			temp := a or b;
		when "010" =>
			temp := a + b;
		when "110" =>
			temp := a - b;
		when "111" =>
			if a < b then
			temp := "11111111";
			else
			temp := "00000000";
			end if;
		when others =>
			temp := a - b;
	end case;
	if temp="00000000" then
	zero <= '1';
	else
	zero <= '0';
	end if;
	f <= temp;
	end process;
end behavioral;

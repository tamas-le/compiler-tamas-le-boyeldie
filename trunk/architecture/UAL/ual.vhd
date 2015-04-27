library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_numeric.all;
use ieee.std_logic_arith.all;

entity alu8bit is
	port(a, b : in std_logic_vector(7 downto 0);	
		op : in std_logic_vector(2 downto 0);
		zero,carry,negative,overflow : out std_logic;
	    	f : out std_logic_vector(7 downto 0));
END alu8bit;

architecture behavioral of alu8bit is
	signal temp_a : std_logic_vector(15 downto 0);
	signal temp_b : std_logic_vector(15 downto 0);
begin
	process(op,a,b)
	variable temp: std_logic_vector(7 downto 0);
	variable temp16:std_logic_vector(15 downto 0);
	
	begin
	negative<='0';
	carry <='0';
	overflow <='0';
	temp_a <= "00000000"&a;
	temp_b <= "00000000"&b;
	case op is
		when "000" =>
			temp := a and b;
		when "001" =>
			temp := a - b;
			if b>a then
			negative <='1';
			else
			negative <='0';
			end if;
		when "010" =>
			temp := a / b;
		when "100" =>
			temp16 := temp_a + temp_b;
			temp := a + b;
			if temp16(8)='1' then
			carry <= '1';
			else 
			carry <= '0';
			end if;
		when "101" =>
			temp16 := a * b;
			--temp := a * b;
			temp := temp16(7 downto 0);
			if temp16 > "0000000011111111" then 
			overflow <='1';
			else
			overflow <='0';
			end if; 
		when "110" =>
			temp := a - b;
		when others =>
			temp :="00000000";
	end case;
	if temp="00000000" then
	zero <= '1';
	else
	zero <= '0';
	end if;
	f <= temp;
	end process;
end behavioral;

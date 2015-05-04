library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_numeric.all;
use ieee.std_logic_arith.all;

entity inst_memory is
	port(
		adresse : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		output : out std_logic_vector(31 downto 0)
	);

end inst_memory;


architecture behavorial of inst_memory is 

type inst_type is array(255 downto 0) of std_logic_vector(31 downto 0);


signal mes_inst : inst_type;
signal ad_int : integer range 0 to 255;
signal op : std_logic_vector(7 downto 0);
signal a :std_logic_vector(7 downto 0);
signal b :std_logic_vector(7 downto 0);
signal c :std_logic_vector(7 downto 0);

begin



	 
process(clk) begin
	
	ad_int <= conv_integer(adresse);
	op <="00000110";
	a <= "00000000";
	b <= "10111011";
	c <= "00000000";
	
	mes_inst(1)<=op&a&b&c;

	if rising_edge(clk) then  -- front montant
		output <= mes_inst(ad_int);   
  	end if;
	
end process;

end behavorial;

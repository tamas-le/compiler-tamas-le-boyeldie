library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_numeric.all;
use ieee.std_logic_arith.all;

entity data_memory is
	port(
		adresse : in std_logic_vector(7 downto 0);
		input : in std_logic_vector(7 downto 0);
		rw : in std_logic;
		rst : in std_logic;
		clk : in std_logic;
		output : out std_logic_vector(7 downto 0)
	
	);

end data_memory;


architecture behavorial of data_memory is 

type data_type is array(255 downto 0) of std_logic_vector(7 downto 0);


signal ma_data : data_type;
signal ad_int : integer range 0 to 255;

begin


	 
process(clk) begin
	ad_int <= conv_integer(adresse);

	if rising_edge(clk) then  -- front montant
		if rst='0' then
			for i in ma_data'range loop
			--if (i=1 or i=2) then ma_data(i)<="10111011";
			--else
			ma_data(i)<="00000000";
			--end if;
			end loop;      
		else
			if rw='1' then -- lecture
			output <= ma_data(ad_int);
			elsif rw='0' then --ecriture
			ma_data(ad_int) <= input;
			end if;
			
 		end if;     
  	end if;
	
end process;

end behavorial;

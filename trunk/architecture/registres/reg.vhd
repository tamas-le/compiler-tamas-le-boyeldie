library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.std_logic_numeric.all;
use ieee.std_logic_arith.all;

entity register_bench is
	port(
		ra, rb :in std_logic_vector(3 downto 0);
		rw : in std_logic_vector(3 downto 0);
		
		w : in std_logic;
		data : in std_logic_vector(7 downto 0);
		rst : in std_logic;
		clk : in std_logic;

		qa : out std_logic_vector(7 downto 0);
	
		qb : out std_logic_vector(7 downto 0)
	);


end register_bench;

architecture behavorial of register_bench is 
--On définit un nouveau type : un tableau de 16 vecteurs de 8 bits.
type registres is array(15 downto 0) of std_logic_vector(7 downto 0);
type indice is range 0 to 15;

-- On l'instancie 
signal mes_registres : registres;
signal ad_a : integer range 0 to 15;
signal ad_b : integer range 0 to 15;
signal ad_w : integer range 0 to 15;
signal 	test : std_logic :='0';


begin

	 
process(clk,ra,rb) begin
	--test <='0';
	ad_a <= conv_integer(ra);
	ad_b <= conv_integer(rb);
	ad_w <= conv_integer(rw);

	if rising_edge(clk) then  -- front montant
	test <= not test;
		if rst='0' then
			for i in mes_registres'range loop
			-- Pour tester la lecture if (i=1 or i=2) then mes_registres(i)<="10101010";else
			mes_registres(i)<="00000000";
			--end if;
			end loop;      
		elsif w='1' then -- ecriture	
			mes_registres(ad_w)<=data;
			
 		end if;     
  	end if;
	
end process;
	qa <=mes_registres(ad_a);
	qb <=mes_registres(ad_b);
end behavorial;

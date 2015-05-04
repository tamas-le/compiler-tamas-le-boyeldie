library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity test_reg is
end test_reg;

architecture bench of test_reg is 
	component registres_test is
	port(
		ra, rb : in std_logic_vector(3 downto 0);
		rw : in std_logic_vector(3 downto 0);
		
		w : in std_logic;
		data : in std_logic_vector(7 downto 0);
		rst : in std_logic;
		clk : in std_logic;

		qa : out std_logic_vector(7 downto 0);
		qb : out std_logic_vector(7 downto 0)
	);
	end component;

for all : registres_test use entity work.register_bench(behavorial);

signal ad_a : std_logic_vector(3 downto 0);
signal ad_b : std_logic_vector(3 downto 0);
signal ad_w :std_logic_vector(3 downto 0);
signal w,rst : std_logic;
signal clk : std_logic :='0';
signal tdata : std_logic_vector(7 downto 0);
signal tqa : std_logic_vector(7 downto 0);
signal tqb : std_logic_vector(7 downto 0);



constant half_period : time := 5 ns;

begin
	tester : registres_test port map(ad_a,ad_b,ad_w,w,tdata,rst,clk,tqa,tqb);
	w <= '0','1' after 6 ns ;
	tdata <="10111011"; 
	ad_a <="0001";
	ad_b <="0010";
	ad_w <="0001";
	rst <= '0','1' after 6 ns;
	--clk <= not clk after half_period;
	
    	clk <= '1', '0' after half_period, '1' after 2*half_period,'0' after 3*half_period,'1' after 4*half_period,'0' after 5*half_period;
end bench;

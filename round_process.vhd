library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity round_process is
	port( ipt:  in std_logic_vector(63 downto 0);
			iky:  in std_logic_vector(79 downto 0);
			opt: out std_logic_vector(63 downto 0);
			oky: out std_logic_vector(79 downto 0);
			i: 	in integer range 1 to 31);
end round_process;

architecture rtl of round_process is
	type s is array(0 to 15) of std_logic_vector(3 downto 0);
	constant sbox: s := ("1100", "0101", "0110", "1011",
								"1001", "0000", "1010", "1101",
								"0011", "1110", "1111", "1000",
								"0100", "0111", "0001", "0010");
	signal T:				std_logic_vector(63 downto 0);	--through sBoxLayer
	
	signal R:				std_logic_vector(79 downto 0);	--rotate shifted
	signal C:				std_logic_vector(79 downto 0);	--sbox converted
	signal updatedKey:	std_logic_vector(79 downto 0);
	component sBoxLayer is
		port( X:  in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
	component pLayer is
		port( X:  in std_logic_vector(63 downto 0);
				Y: out std_logic_vector(63 downto 0));
	end component;
begin
	UU1:sBoxLayer port map(ipt xor iky(79 downto 16),T);
	UU2:pLayer port map(T,opt);
	R<=to_stdlogicvector(to_bitvector(iky) ror 19);
	C<=sbox(conv_integer(R(79 downto 76))) & R(75 downto 0);
	oky<=C xor to_stdlogicvector(to_bitvector(conv_std_logic_vector(i, 20)) sll 15);
end rtl;
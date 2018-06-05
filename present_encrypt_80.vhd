library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity present_encrypt_80 is
	port( clk: 						 in std_logic;
			HEX3,HEX2,HEX1,HEX0: out std_logic_vector(7 downto 0));
end present_encrypt_80;

architecture rtl of present_encrypt_80 is
	signal plaintxt:	std_logic_vector(63 downto 0) := (others=>'0');
	signal key:			std_logic_vector(79 downto 0) := (others=>'0');
	signal crypt:		std_logic_vector(63 downto 0);
	type temp_pt is array(0 to 31) of std_logic_vector(63 downto 0);	--temporally plaintxt
	type temp_ky is array(0 to 31) of std_logic_vector(79 downto 0);	--temporally key
	signal pt: temp_pt;
	signal ky: temp_ky;
	component round_process is
		port( ipt:  in std_logic_vector(63 downto 0);
				iky:  in std_logic_vector(79 downto 0);
				opt: out std_logic_vector(63 downto 0);
				oky: out std_logic_vector(79 downto 0);
				i: 	in integer range 1 to 31);
	end component;
	component show_16digit is
		port( clk: in std_logic;
				crypt: in std_logic_vector(63 downto 0);
				D3,D2,D1,D0: out std_logic_vector(7 downto 0));
	end component;
begin
	pt(0)<=plaintxt;
	ky(0)<=key;
	calcCrypt: for i in 1 to 31 generate
		U1:round_process port map(pt(i-1),ky(i-1),pt(i),ky(i),i);
	end generate;
	crypt<=pt(31) xor ky(31)(79 downto 16);
	U:show_16digit port map(clk,crypt,HEX3,HEX2,HEX1,HEX0);
end rtl;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity myDataMemory is
port(
	address : in std_logic_vector(31 downto 0);
	write_data : in std_logic_vector(31 downto 0);
	MemWrite, MemRead : in std_logic;
	read_Data : out std_logic_vector(31 downto 0)
);
end myDataMemory;

architecture behv of myDataMemory is
TYPE mem_array is array(0 to 7) of std_logic_vector(31 downto 0);
begin
	process(MemRead, MemWrite)
	variable data_mem : mem_array; 
--:= (
--		X"00000001",
--		X"00000002",
--		X"00000003",
--		X"00000004",
--		X"00000005",
--		X"00000006",
--		X"00000007",
--		X"00000008"
--	);
	variable addr : std_logic_vector(2 downto 0);
	begin
		addr := address(2 downto 0);
		if(MemWrite = '1') then
			data_mem(to_integer(unsigned(addr))) := write_data;
		elsif(MemRead = '1') then
			read_Data <= data_mem(to_integer(unsigned(addr)));
		end if;
	end process;
end behv;
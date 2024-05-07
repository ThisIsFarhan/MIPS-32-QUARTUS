library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity myfetch is
port(
	reset : in std_logic;
	clock : in std_logic;
	branch_decision : in std_logic;
	jump_decision : in std_logic;
	branch_addr : in std_logic_vector(31 downto 0);
	jump_addr : in std_logic_vector(31 downto 0);
	pc_out : out std_logic_vector(31 downto 0);
	instruction : out std_logic_vector(31 downto 0)
);
end myfetch;

architecture behv of myfetch is
type mem_array is array(0 to 4) of std_logic_vector(31 downto 0);
begin

	process(clock, reset)
	variable mem: mem_array := (
			X"00622020",
			X"8c220000",
			X"8c230005",
			X"ac240000",
			X"8c220000"
	);
	variable PC : std_logic_vector(31 downto 0) := X"00000000";
	variable index : integer := 0;
	begin
		if(reset = '1') then
				PC := X"00000000";
				instruction <= X"00000000";
		elsif(clock 'event and clock = '1') then
			if (branch_decision = '1') then
				PC := branch_addr;
			elsif (jump_decision = '1') then
				PC := jump_addr;
			end if;
			index := to_integer(unsigned(PC(2 downto 0)));
			PC := PC + X"1";
			PC_out <= PC;
			instruction <= mem(index);
		end if;
	end process;
end behv;
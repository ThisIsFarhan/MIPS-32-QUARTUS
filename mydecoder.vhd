library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mydecoder is
port(
	reset : in std_logic;
	clock : in std_logic;
	
	instruction : in std_logic_vector(31 downto 0);
	memory_data : in std_logic_vector(31 downto 0);
	Alu_result : in std_logic_vector(31 downto 0);
	
	RegDst : in std_logic;
	RegWrite : in std_logic;
	MemToReg : in std_logic;
	
	register_rs : out std_logic_vector(31 downto 0);
	register_rt : out std_logic_vector(31 downto 0);
	register_rd : out std_logic_vector(31 downto 0);
	jump_addr : out std_logic_vector(31 downto 0);
	immediate : out std_logic_vector(31 downto 0)
);
end mydecoder;

architecture behv of mydecoder is
type reg_array is array(0 to 31) of std_logic_vector(31 downto 0);
shared variable RegFile: reg_array := (
		X"00000000",
		X"00000001",
		X"00000002",
		X"00000003",
		X"00000004",
		X"00000005",
		X"00000006",
		X"00000007",
		X"00000008",
		X"00000009",
		X"0000000A",
		X"0000000b",
		X"0000000C",
		X"0000000D",
		X"0000000E",
		X"0000000F",
		X"00000010",
		X"00000011",
		X"00000012",
		X"00000013",
		X"00000014",
		X"00000015",
		X"00000016",
		X"00000017",
		X"00000018",
		X"00000019",
		X"0000001A",
		X"0000001b",
		X"0000001C",
		X"0000001D",
		X"0000001E",
		X"0000001F",
		others =>
		X"01010101");
begin
	reg_write : process(reset, memory_data, Alu_result, clock)
	variable write_value : std_logic_vector(31 downto 0);
	variable index : integer := 0;
	begin
		if (reset = '1') then
				RegFile := (
				X"00000000",
				X"00000001",
				X"00000002",
				X"00000003",
				X"00000004",
				X"00000005",
				X"00000006",
				X"00000007",
				X"00000008",
				X"00000009",
				X"0000000A",
				X"0000000b",
				X"0000000C",
				X"0000000D",
				X"0000000E",
				X"0000000F",
				X"00000010",
				X"00000011",
				X"00000012",
				X"00000013",
				X"00000014",
				X"00000015",
				X"00000016",
				X"00000017",
				X"00000018",
				X"00000019",
				X"0000001A",
				X"0000001b",
				X"0000001C",
				X"0000001D",
				X"0000001E",
				X"0000001F",
				others =>
				X"01010101");
		elsif(clock 'event and clock = '0') then
			if (regDst = '0') then
				index := to_integer(unsigned(instruction(20 downto 16)));
			elsif (regDst = '1') then
				index := to_integer(unsigned(instruction(15 downto 11)));
			end if;
			
			
			if (regWrite = '1') then
				if (MemToReg = '0') then
					write_value := Alu_result;
				elsif(MemToReg = '1') then
					write_value := memory_data;
				end if;
				RegFile(index) := write_value;
			end if;
		end if;
	end process reg_write;
	
	
	reg_read : process(instruction)
	variable rs : std_logic_vector(31 downto 0);
	variable rt : std_logic_vector(31 downto 0);
	variable rd : std_logic_vector(31 downto 0);
	variable imm : std_logic_vector(31 downto 0);
		
	variable addr_rs : integer;
	variable addr_rt : integer;
	variable addr_rd : integer;	
	begin
		
			addr_rs := to_integer(unsigned(instruction(25 downto 21)));
			addr_rt := to_integer(unsigned(instruction(20 downto 16)));
			addr_rd := to_integer(unsigned(instruction(15 downto 11)));
			
			rs := RegFile(addr_rs);
			rt := RegFile(addr_rt);
			rd := RegFile(addr_rd);
			
			imm(15 downto 0) := instruction(15 downto 0);
			if (instruction(15) = '1') then 
				imm(31 downto 16) := X"ffff";
			else
				imm(31 downto 16) := X"0000";
			end if;
			
			jump_addr(31 downto 0) <= "000000" & instruction(25 downto 0);
			
			
			register_rs <= rs;
			register_rt <= rt;
			immediate <= imm;
			register_rd <= rd;
	end process reg_read;
end behv;
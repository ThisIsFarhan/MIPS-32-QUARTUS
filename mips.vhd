library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.myComponents.all;

entity mips is
port(
	clock : in std_logic;
	reset : in std_logic;
	
	op : out std_logic_vector(31 downto 0);
	inp : in std_logic_vector(3 downto 0)
);
end mips;

architecture behv of mips is
	signal instruction : std_logic_vector(31 downto 0);
	signal br_decision : std_logic;
	signal br_addr : std_logic_vector(31 downto 0);
	signal jump_decision : std_logic;
	signal jump_addr : std_logic_vector(31 downto 0);
	signal PC_out : std_logic_vector(31 downto 0);
	
	signal RegDst : std_logic;
	signal ALUSrc : std_logic;
	signal MemtoReg : std_logic;
	signal RegWrite : std_logic;
	signal MemRead : std_logic;
	signal MemWrite : std_logic;
	signal Branch : std_logic;
	signal ALUOp : std_logic_vector(1 downto 0);
	
	signal memory_data : std_logic_vector(31 downto 0);
	signal Alu_result : std_logic_vector(31 downto 0);
	signal register_rs : std_logic_vector(31 downto 0);
	signal register_rt : std_logic_vector(31 downto 0);
	signal register_rd : std_logic_vector(31 downto 0);
	--signal jump_addr : std_logic_vector(31 downto 0);
	signal immediate : std_logic_vector(31 downto 0);
	
	signal op_signal : std_logic_vector(31 downto 0);
	
begin
	U1: myfetch port map (reset, clock, br_decision, jump_decision, br_addr, jump_addr, PC_out, instruction);
	U2: myControlUnit port map (instruction, reset, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALuOp, jump_decision);
	U3 : mydecoder port map (reset, clock, instruction, memory_data, Alu_result, RegDst, RegWrite, MemtoReg, register_rs,
										register_rt, register_rd, jump_addr, immediate);
	U4 : myexecution port map (PC_out, register_rs, register_rt, immediate, ALuOp, ALuSrc, Branch, Alu_result, br_addr, br_decision);
	U5 : myDataMemory port map (Alu_result, register_rt, MemWrite, MemRead, Memory_data);
	
	
	 
	op_signal <= PC_out when (inp = "0001") else
					 register_rs when (inp = "0010") else
					 register_rt when (inp = "0011") else
					 immediate when (inp = "0100") else
					 alu_result when (inp = "0101") else
					 memory_data when (inp = "0110") else
					 br_addr when (inp = "0111") else
					 instruction;
					 
	op <= op_signal;
					 
end behv;
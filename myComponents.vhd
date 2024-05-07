library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package myComponents is
	component myfetch is
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
	end component;
	
	component mydecoder is
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
	end component;
	component myControlUnit is
		port(
			instruction : in std_logic_vector(31 downto 0);
			reset : in std_logic;
				
			RegDst : out std_logic;
			ALUSrc : out std_logic;
			MemtoReg : out std_logic;
			RegWrite : out std_logic;
			MemRead : out std_logic;
			MemWrite : out std_logic;
			Branch : out std_logic;
			ALUOp : out std_logic_vector(1 downto 0);
			jump : out std_logic
		);
	end component;
	component myDataMemory is
		port(
			address : in std_logic_vector(31 downto 0);
			write_data : in std_logic_vector(31 downto 0);
			MemWrite, MemRead : in std_logic;
			read_Data : out std_logic_vector(31 downto 0)
		);
	end component;
		
	component myexecution is
		port(
			PC4 : in std_logic_vector(31 downto 0);
			register_rs : in std_logic_vector(31 downto 0);
			register_rt : in std_logic_vector(31 downto 0);
			immediate : in std_logic_vector(31 downto 0);
			
			--control inputs
			ALUOp : in std_logic_vector(1 downto 0);
			ALUSrc : in std_logic;
			beq_control : in std_logic;
			
			--outputs
			alu_result : out std_logic_vector(31 downto 0);
			branch_addr : out std_logic_vector(31 downto 0);
			branch_decision : out std_logic
		);
	end component;
end myComponents;
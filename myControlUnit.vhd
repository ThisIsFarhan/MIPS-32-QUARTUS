library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity myControlUnit is
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
end myControlUnit;

architecture behv of myControlUnit is
begin
	process(instruction, reset)
		variable opcode : std_logic_vector(5 downto 0);
	begin
		if reset = '1' then
			RegDst <= '0';
			ALUSrc <= '0';
			MemtoReg <= '0';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			ALUOp <= "00";
			jump <= '0';
		else
			opcode := instruction(31 downto 26);
			case opcode is
				when "000000" => --R-type
					RegDst <= '1';
					ALUSrc <= '0';
					MemtoReg <= '0';
					RegWrite <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					Branch <= '0';
					ALUOp <= "10";
					jump <= '0';
				when "100011" => --lw
					RegDst <= '0';
					ALUSrc <= '1';
					MemtoReg <= '1';
					RegWrite <= '1';
					MemRead <= '1';
					MemWrite <= '0';
					Branch <= '0';
					ALUOp <= "00";
					jump <= '0';
				when "101011" => --sw
					RegDst <= '0';
					ALUSrc <= '1';
					MemtoReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '1';
					Branch <= '0';
					ALUOp <= "00";
					jump <= '0';
				when "000100" => --beq
					RegDst <= '0';
					ALUSrc <= '0';
					MemtoReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					Branch <= '1';
					ALUOp <= "01";
					jump <= '0';
				when "001000" => --addi
					RegDst <= '0';
					ALUSrc <= '1';
					MemtoReg <= '0';
					RegWrite <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					Branch <= '0';
					ALUOp <= "00";
					jump <= '0';
				when "000010" => --j
					RegDst <= '0';
					ALUSrc <= '0';
					MemtoReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					Branch <= '0';
					ALUOp <= "00";
					jump <= '1';
				when others => 
					RegDst <= '0';
					ALUSrc <= '0';
					MemtoReg <= '0';
					RegWrite <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					Branch <= '0';
					ALUOp <= "00";
					jump <= '0';
				end case;
		end if;
	end process;
end behv;

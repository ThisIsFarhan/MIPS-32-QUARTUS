library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity myexecution is port (
	--execution inputs
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
end myexecution;

architecture behv of myexecution is
begin
	process(register_rs, register_rt, immediate)
		variable zero : std_logic;
		variable operand_two : std_logic_vector(31 downto 0);
		variable func : std_logic_vector(5 downto 0);
	begin
		--seleting between rt and imm as second input to ALU
		if(ALUSrc = '0') then
			operand_two := register_rt;
		else 
			operand_two := immediate;
		end if;
		
		--recognizing the instr based on ALUOP
		case ALUOp is
			--LW/SW
			when "00" =>
				alu_result <= register_rs + operand_two;
			--Branch Equal
			when "01" =>
				--checking if both the operands are equal
				alu_result <= register_rs - operand_two;
				if ((register_rs - operand_two) = X"00000000") then
					zero := '1';
				else
					zero := '0';
				end if;
			--R-type instructions
			when "10" =>
				--if R-type, then judging based on the function bits which are the last 6 digits of imm
				func := immediate(5 downto 0);
				case func is
					--addition
					when "100000" =>
						alu_result <= register_rs + operand_two;
					--subtraction
					when "100010" =>
						alu_result <= register_rs - operand_two;
					--AND
					when "100100" =>
						alu_result <= register_rs and operand_two;
					--OR
					when "100101" =>
						alu_result <= register_rs or operand_two;
					--SLT
					when "101010" =>
						if(register_rs < register_rt) then
							alu_result <= X"00000001";
						else
							alu_result <= X"00000000";
						end if;
					when others =>
						alu_result <= X"ffffffff"; --error code
				end case;
			when others =>
				alu_result <= X"ffffffff"; --error code
		end case;
		branch_addr <= immediate + PC4;
		branch_decision <= (zero and beq_control);
	end process;
end behv;
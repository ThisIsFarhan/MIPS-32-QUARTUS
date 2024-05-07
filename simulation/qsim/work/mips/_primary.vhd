library verilog;
use verilog.vl_types.all;
entity mips is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        op              : out    vl_logic_vector(31 downto 0);
        inp             : in     vl_logic_vector(3 downto 0)
    );
end mips;

library verilog;
use verilog.vl_types.all;
entity mips_vlg_sample_tst is
    port(
        clock           : in     vl_logic;
        inp             : in     vl_logic_vector(3 downto 0);
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end mips_vlg_sample_tst;

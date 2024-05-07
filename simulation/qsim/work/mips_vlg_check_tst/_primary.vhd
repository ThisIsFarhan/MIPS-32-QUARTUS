library verilog;
use verilog.vl_types.all;
entity mips_vlg_check_tst is
    port(
        op              : in     vl_logic_vector(31 downto 0);
        sampler_rx      : in     vl_logic
    );
end mips_vlg_check_tst;

module core(
    input [63:0] datain,
    output [63:0] dataout,
    output [63:0] addr,
    output read,
    output write,
    input clock,
    input reset
    );
    wire [63:0] address,database,dataoutbase,rw;
    basecore basecore(database,dataoutbase,address,rw,clock,clock,reset);
    wire chipselectcache = address > 64'sd16384 & address < 20480;
    wire cacheread = chipselectcache & ~rw;
    wire cachewrite = chipselectcache & rw;
    wire outread = ~chipselectcache & ~rw;
    wire outwrite = ~chipselectcache & rw;
    assign read = outread;
    assign write = outwrite;
    assign addr = address;
    assign dataout = dataoutbase;
    assign database = datain;
    L1Cache cache(address[12:0],dataoutbase,database,clock,cacheread,cachewrite);
endmodule

module multicores(
    input clock,
    input reset,
    input [63:0] data,
    output reg [63:0] dataout,
    output reg [63:0] address,
    output reg rw,

);
    parameter Ncores = 4;
    reg [7:0] count;
    reg cycles;
    wire [Ncores:0] [63:0] datasin;
    wire [Ncores:0] [63:0] datasout;
    wire [Ncores:0] [63:0] addrs;
    wire [Ncores:0]  reads;
    wire [Ncores:0]  writes;
    generate
          genvar i;
          for (i=0; i<Ncores; i=i+1) begin
              core core(datasin[i],datasout[i],addrs[i],reads[i],writes[i]);


          end

    endgenerate
    L2SharedCache L2cache(addrs,datasout,datasin,clock,reset,reads,writes);
    always @(negedge clock) begin
        if (reset) begin
            count <= 0;
            cycles <= 0;
        end
        wire reading = reads[count];
        if (reading) begin
            datasin[count] <= data;
            address <= addrs[count];
            rw <= 0;
        end
        wire writing = reads[count];
        if (writing) begin
            dataout <= datasout[count];
            address <= addrs[count];
            rw <= 1;
        end
        if (count > Ncores) begin
            count <= 0;
        else begin
            count <= count + 1;
        end

        
    end
endmodule
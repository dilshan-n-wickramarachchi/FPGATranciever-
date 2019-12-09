
`timescale 1ns / 1ns
module tb_new()   ; 

//Transmitter 
parameter STATE_STOP  = 2'b11 ;
parameter STATE_DATA  = 2'b10 ;
parameter STATE_START  = 2'b01 ;
parameter STATE_IDLE  = 2'b00 ;
	wire   tx   ; 
	wire   tx_busy   ; 
	reg    wr_en   ; 
	reg  [7:0]  din   ;

//Receiver 
parameter RX_STATE_STOP  = 2'b10 ;
parameter RX_STATE_DATA  = 2'b01 ;
parameter RX_STATE_START  = 2'b00 ; 

  wire  [7:0]  dout   ; 
  reg    rx   ;
  reg rdy_clr;



//Baudrate conversions
  wire    txclk_en   ; 
  wire    rxclk_en   ; 
  reg    clk_50m   ; 
  
  
baud_rate_gen uart_baud(.clk_50m(clk_50m),
			.rxclk_en(rxclk_en),
			.txclk_en(txclk_en));
			
transmitter uart_tx(.din(din),
		    .wr_en(wr_en),
		    .clken(txclk_en),
		    .tx(tx),
		    .tx_busy(tx_busy));
			 
receiver uart_rx(.rx(rx),
		 .rdy(rdy),
		 .rdy_clr(rdy_clr),
		 .clk_50m(clk_50m),
		 .clken(rxclk_en),
		 .data(dout));

//Transmitter
// "Constant Pattern"
// Start Time = 0 ns, End Time = 1 ms, Period = 0 ns
	initial
	begin
	  wr_en  = 1'b1  ;
	  rdy_clr = 1'b1;
	  din  = 8'b10101010  ;
	  clk_50m = 1;
	 # 100000 wr_en  = 1'b0  ;
	 # 100000 wr_en  = 1'b1  ;
	 # 100000 ;
	 if(dout == din) begin 
			$display("Tranmission successful");
	 end else begin
			$display("Tranmission failed");
			end
	#100000 $stop;
	// dumped values till 1 us
	end
	
//Baud rate 
// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ns, End Time = 1 ms, Period = 20 ns
	always begin
		#10 clk_50m = !clk_50m;
		rx = tx;
	end
	
	
	
endmodule

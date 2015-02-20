//========================================================================
// Memory Access Control Module 
//========================================================================

`ifndef PLAB5_MCORE_MEM_ACC_V
`define PLAB5_MCORE_MEM_ACC_V

`include "vc-mem-msgs.v"

module plab5_mcore_mem_acc
#(
	parameter p_opaque_nbits = 8,	// mem message opaque field num bits
	parameter p_addr_nbits	 = 32,	// mem message address num bits
	parameter p_data_nbits	 = 32,	// mem message data num bits

	// Shorter names for message type, not to be set from outside the module
	parameter o = p_opaque_nbits,
	parameter a = p_addr_nbits,
	parameter d = p_data_nbits,

	// Local constants not meant to be set from ouside the module
	parameter req_nbits		= `VC_MEM_REQ_MSG_NBITS(o,a,d),
	parameter req_cnbits	= req_nbits - p_data_nbits,
	parameter req_dnbits	= p_data_nbits,
	parameter resp_nbits	= `VC_MEM_RESP_MSG_NBITS(o,d),
	parameter resp_cnbits	= resp_nbits - p_data_nbits,
	parameter resp_dnbits	= p_data_nbits
)
(
	input						{L} clk,

	// requests security level
	input						{L} req_sec_level,
	// responses from memory's security level
	output	reg					{L} resp_sec_level,
	
	// Module's security level
	input						{L} mem_sec_level,

	// Inputs of requests
	input	[req_cnbits-1:0]	{L} net_req_control,
	input	[req_dnbits-1:0]	{Domain req_sec_level} net_req_data,
	input						{L} net_req_val,
	output						{L} net_req_rdy,

	// outputs to the memory side
	output	reg [req_cnbits-1:0]	{L} mem_req_control,
	output	reg [req_dnbits-1:0]	{Domain mem_sec_level} mem_req_data,
	output	reg 					{L} mem_req_val,
	input							{L} mem_req_rdy,

	// Output of responses
	output	[resp_cnbits-1:0]	{L} net_resp_control,
	output	[resp_dnbits-1:0]	{Domain resp_sec_level} net_resp_data,
	output						{L} net_resp_val,
	input						{L} net_resp_rdy,

	// Inputs from the memory side
	input	[resp_cnbits-1:0]	{L} mem_resp_control,
	input	[resp_dnbits-1:0]	{Domain mem_sec_level} mem_resp_data,
	input						{L} mem_resp_val,
	output						{L} mem_resp_rdy
);
	
	// always pass rdy signals between network and memory
	assign net_req_rdy	= mem_req_rdy;
	assign mem_resp_rdy	= net_resp_rdy;

	// since if request is not secure, the requests will be not
	// passed to the memory. Therefore, it indicates that each
	// response correspond to a secure request, and we don't need
	// to check whether the reponses is secure or not, and directly
	// pass response signal to network side
	assign net_resp_control = mem_resp_control;
	assign net_resp_data	= mem_resp_data;
	assign net_resp_val		= mem_resp_val;

	always @(*) begin
	
		// if req security level is noise, we wil view this as
		// insecure, and set data field to be X and valid signal
		// to be low

		if ( req_sec_level === 1'bx || (req_sec_level < mem_sec_level) ) begin
			mem_req_control = 'hx;
			mem_req_data	= 'hx;
			mem_req_val		= 1'b0;

			if ( req_sec_level < mem_sec_level ) begin
				$display("Detected Insecure Memory Access!");
			end
		end

		// if req security level is higher than memory security
		// level, the operation is allowed, so we pass the data
		// field and enable the valid signal

		else if ( req_sec_level >= mem_sec_level ) begin
			mem_req_control = net_req_control;
			mem_req_data	= net_req_data;
			mem_req_val		= net_req_val;
		end
		
		resp_sec_level	= 1'b0;
	end

endmodule
`endif /*PLAB5_MCORE_MEM_ACC_V*/

//========================================================================
// Direct Memory Access Controller Module
// Since the system doesn't contain the peripheral devices(I/O devices),
// DMA only includes memory copy operations. DMA firstly receive source 
// address and destination address from processor. Then read data from
// source memory, transfer them to destination memory
//========================================================================

`ifndef PLAB5_MCORE_DMA_CONTROLLER_V
`define PLAB5_MCORE_DMA_CONTROLLER_V

`include "vc-mem-msgs.v"
`include "vc-regs.v"
`include "vc-queues.v"
`include "plab5-mcore-memreqcmsgpack.v"

module plab5_mcore_DMA_Controller
#(
	parameter	p_opaque_nbits	= 8,		// opaque field bit width
	parameter	p_addr_nbits	= 32,		// address field bit width
	parameter	p_data_nbits	= 32,		// data field bit width

	// Shorter names for messsage type, not to be set from outside the module
	parameter	o = p_opaque_nbits,
	parameter	a = p_addr_nbits,
	parameter	d = p_data_nbits,

	// Local constants not meant to be set from outside from the module
	parameter	c_req_nbits   = `VC_MEM_REQ_MSG_NBITS(o,a,d),
	parameter	c_req_cnbits  = c_req_nbits - d,
	parameter	c_req_dnbits  = d,
	parameter	c_resp_nbits  = `VC_MEM_RESP_MSG_NBITS(o,d),
    parameter	c_resp_cnbits = c_resp_nbits - d,
	parameter	c_resp_dnbits = d	
)
(
	input						{L}     clk,
	input						{L}     reset,

	// ports connected to core
	input						{Domain domain} val,	     // indicate there is a request
	output	reg					{Domain resp_domain} rdy,			
	input						{L}             domain,	     // indicate dma request security level	
	input	[p_addr_nbits-1:0]	{Domain domain} src_addr,    // source memory address
	input	[p_addr_nbits-1:0]	{Domain domain} dest_addr,   // destination memory address
	input	[c_req_cnbits-1:0]	{Domain domain} req_control, // request information from on-chip network
	output	[c_resp_cnbits-1:0]	{Domain resp_domain} resp_control,// response infomration to on-chip network
	input						{Domain domain}      inst,		// instruction type for normal use
	output	reg					{Domain resp_domain} ack,	// when operations done, notify core
	output	reg					{L}                  resp_domain,	

	// ports connected to debug interface
	input						{Domain db_domain}      db_val,	// indicate there is a debug request
	input						{L}                     db_domain,		// indicate debug  request security level
	input	[p_addr_nbits-1:0]	{Domain db_domain}      db_src_addr,	// debug source memory address
	input	[p_addr_nbits-1:0]	{Domain db_domain}      db_dest_addr,	// debug destination mmeoyr address
	input						{Domain db_domain}      db_inst,		// intruction type for debug use
	output	[p_data_nbits-1:0]	{Domain db_resp_domain} debug_data,		// result for debug interface;
    output                      {L}                     db_resp_domain,

	// ports connected to memory 
	output	reg					{Domain mem_req_domain}  mem_req_val,
	input						{Domain mem_req_domain}  mem_req_rdy,
	output	[c_req_cnbits-1:0]	{Domain mem_req_domain}  mem_req_control,
	output	[c_req_dnbits-1:0]	{Domain mem_req_domain}  mem_req_data,
	output	reg					{L}                      mem_req_domain,

	input						{Domain mem_resp_domain} mem_resp_val,
	output						{Domain mem_resp_domain} mem_resp_rdy,
	input	[c_resp_cnbits-1:0]	{Domain mem_resp_domain} mem_resp_control,
	input	[c_resp_dnbits-1:0]	{Domain mem_resp_domain} mem_resp_data,
	input						{L}                      mem_resp_domain	

);

    //----------------------------------------------------------------------
	// Datapath of DMA controller 
    //----------------------------------------------------------------------

	// two registers for registering src_addr/dest_addr
	wire	[p_addr_nbits-1:0]	{Domain domain}     src_addr_reg_out;
	wire	[p_addr_nbits-1:0]	{Domain domain}     dest_addr_reg_out;
	wire	[p_addr_nbits-1:0]	{Domain db_domain}  db_src_addr_reg_out;
	wire	[p_addr_nbits-1:0]	{Domain db_domain}  db_dest_addr_reg_out;
	wire						{Domain db_domain}  inst_reg_out;
	wire	[p_data_nbits-1:0]	{Domain mem_resp_domain} mem_resp_data_reg_out;
	wire	[c_req_cnbits-1:0]	{Domain domain}     req_control_reg_out;
	wire						{L}                 cur_domain;

	vc_EnResetReg#(p_addr_nbits) src_addr_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (domain),
		.en		(dmareq_en),
		.d		(src_addr),
		.q		(src_addr_reg_out)
	);

	vc_EnResetReg#(p_addr_nbits) dest_addr_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (domain),
		.en		(dmareq_en),
		.d		(dest_addr),
		.q		(dest_addr_reg_out)
	);

	vc_EnResetReg#(p_addr_nbits) db_src_addr_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (db_domain),
		.en		(dbreq_en),
		.d		(db_src_addr),
		.q		(db_src_addr_reg_out)
	);

	vc_EnResetReg#(p_addr_nbits) db_dest_addr_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (db_domain),
		.en		(dbreq_en),
		.d		(db_dest_addr),
		.q		(db_dest_addr_reg_out)
	);

	vc_EnResetReg#(1) inst_type_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (db_domain),
		.en		(dbreq_en),
		.d		(db_inst),
		.q		(inst_reg_out)
	);

	vc_EnResetReg#(c_req_cnbits) req_control_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (domain),
		.en		(dmareq_en),
		.d		(req_control),
		.q		(req_control_reg_out)
	);

	vc_EnResetReg domain_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (2),
		.en		(dmareq_en),
		.d		(domain),
		.q		(cur_domain)
	);
	
    reg [c_resp_cnbits-1:0] {Domain resp_domain} resp_control;

    always @(*) begin
        if ( domain == resp_domain ) begin
	        resp_control[14:12] = req_control_reg_out[46:44];
            resp_control[11:4]  = req_control_reg_out[43:36];
            resp_control[3:0]   = req_control_reg_out[3:0];
        end
    end    

	vc_EnResetReg#(p_data_nbits) mem_resp_data_reg
	(
		.clk	(clk),
		.reset	(reset),
        .domain (mem_resp_domain),
		.en		(mem_resp_val),
		.d		(mem_resp_data),
		.q		(mem_resp_data_reg_out)
	);

	// Pack Memory request control msg

	plab5_mcore_MemReqCMsgPack#(o,a,d) memreq_cmsg_pack
	(
        .domain (mem_req_domain),
		.type	(mem_req_type),
		.opaque (0),
		.addr	(mem_req_addr),
		.len	(0),
		.msg	(mem_req_control)
	);

	// Queues temporarily storing data, and transfering data
	wire	{Domain cur_domain} deq_val;
	
	vc_Queue
	#(
		.p_msg_nbits	(p_data_nbits),
		.p_num_msgs		(2)
	)
	hold_queue
	(
		.clk			(clk),
		.reset			(reset),

        .domain         (mem_req_domain),

		.enq_val		(enq_en),
		.enq_rdy		(mem_resp_rdy),
		.enq_msg		(mem_resp_data_reg_out),

		.deq_val		(deq_val),
		.deq_rdy		(mem_req_rdy),
		.deq_msg		(mem_req_data)
	);

    //----------------------------------------------------------------------
	// Control Unit of DMA controller
    //----------------------------------------------------------------------
	reg											{Domain domain}         dmareq_en;
    reg                                         {Domain db_domain}      dbreq_en;
	reg											{Domain cur_domain}     enq_en;
	reg [`VC_MEM_REQ_MSG_TYPE_NBITS(o,a,d)-1:0]	{Domain mem_req_domain} mem_req_type;
	reg [`VC_MEM_REQ_MSG_ADDR_NBITS(o,a,d)-1:0]	{Domain mem_req_domain} mem_req_addr;
	reg [p_data_nbits-1:0]						{Domain db_resp_domain} debug_data;
    reg                                         {L}                     db_resp_domain;
	
	// FSM State Definitions
	localparam STATE_IDLE			= 4'd0;
	localparam STATE_DEBUG_REG		= 4'd1;
	localparam STATE_NET_REG		= 4'd2;
	localparam STATE_READ_MEM_REQ	= 4'd3;
	localparam STATE_READ_MEM_WAIT  = 4'd4;
	localparam STATE_READ_MEM_DONE	= 4'd5;
	localparam STATE_WRITE_MEM_REQ	= 4'd6;
	localparam STATE_WRITE_MEM_WAIT = 4'd7;
	localparam STATE_WRITE_MEM_DONE = 4'd8;
	localparam STATE_ACK			= 4'd9;
	localparam STATE_DEBUG_RES		= 4'd10;

	// FSM State transition
	reg [3:0]	{Domain cur_domain} state_reg;
	reg [3:0]	{Domain cur_domain} state_next;

	always @( posedge clk ) begin
		if ( reset ) begin
			state_reg  <= STATE_IDLE;
		end
		else begin
			state_reg <= state_next;
		end
	end

	always @(*) begin

		state_next = state_reg;
		
		case ( state_reg )
			
            STATE_IDLE: begin
				if ( db_val && cur_domain == db_domain )		
                                    state_next = STATE_DEBUG_REG;
		        if ( val && cur_domain == domain)		
                                    state_next = STATE_NET_REG;
            end

			STATE_DEBUG_REG:
				state_next = STATE_READ_MEM_REQ;
			
			STATE_NET_REG:
				state_next = STATE_READ_MEM_REQ;	

			STATE_READ_MEM_REQ:
				if ( mem_req_rdy && cur_domain == mem_req_domain)  
                                    state_next = STATE_READ_MEM_WAIT;

			STATE_READ_MEM_WAIT:
				if ( mem_resp_val && cur_domain == mem_resp_domain)	
                                    state_next = STATE_READ_MEM_DONE;

			STATE_READ_MEM_DONE:
				if ( status === 1'b0 )
									state_next = STATE_WRITE_MEM_REQ;
		   else	if ( !inst_reg_out && db_domain == cur_domain )
									state_next = STATE_WRITE_MEM_REQ;
		   else if ( inst_reg_out == 1'b1 && db_domain == cur_domain )
									state_next = STATE_DEBUG_RES;

			STATE_WRITE_MEM_REQ:
				if ( mem_req_rdy && mem_req_domain == cur_domain )	
                                    state_next = STATE_WRITE_MEM_WAIT;

			STATE_WRITE_MEM_WAIT:
				if ( mem_resp_val && mem_resp_domain == cur_domain )	
                                    state_next = STATE_WRITE_MEM_DONE;

			STATE_WRITE_MEM_DONE:
				state_next = STATE_ACK;

			STATE_ACK:
				state_next = STATE_IDLE;
		   
			STATE_DEBUG_RES:
				state_next = STATE_IDLE;

		endcase
	end

	reg		{Domain cur_domain} status;
	// State Outputs
	always @(*) begin

		ack         = 1'b0;
        rdy         = 1'b0;
        dmareq_en   = 1'b0;
        dbreq_en    = 1'b0;
		mem_req_domain = cur_domain;
		resp_domain	   = cur_domain;
        db_resp_domain = cur_domain;
		
		case ( state_reg )

			STATE_IDLE: begin
                if ( domain == cur_domain && db_domain == cur_domain ) begin
				    rdy			 = 1'b1;
				    ack			 = 1'b0;
				    dmareq_en	 = 1'b1;
                    dbreq_en     = 1'b1;
				    enq_en		 = 1'b0;
				    status		 = 1'bx;
				    mem_req_val	 = 1'b0;
				    mem_req_type = 3'hx;
				    mem_req_addr = 32'hx;
                end
			end

			STATE_DEBUG_REG: begin
				ack			 = 1'b0;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b0;
				mem_req_type = 3'hx;
				mem_req_addr = 32'hx;
				status		 = 1'b1;
			end

			STATE_NET_REG: begin
				ack			 = 1'b0;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b0;
				mem_req_type = 3'hx;
				mem_req_addr = 32'hx;
				status		 = 1'b0;
			end

			STATE_READ_MEM_REQ: begin
				ack			 = 1'b0;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b1;
				mem_req_type = 3'h0;
				if ( status === 1'b0 && domain == cur_domain )
					mem_req_addr = src_addr_reg_out;
				else if ( db_domain == cur_domain )
					mem_req_addr = db_src_addr_reg_out;
			end

			STATE_READ_MEM_WAIT: begin
				ack			 = 1'b0;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b0;
				mem_req_type = 3'hx;
				mem_req_addr = 32'hx;
			end

			STATE_READ_MEM_DONE: begin
				ack			 = 1'b0;
				enq_en		 = 1'b1;
				mem_req_val	 = 1'b0;
				mem_req_type = 3'hx;
				mem_req_addr = 32'hx;
			end

			STATE_WRITE_MEM_REQ: begin
				ack			 = 1'b0;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b1;
				mem_req_type = 3'h1;
				if ( status === 1'b0 && domain == cur_domain )
					mem_req_addr = dest_addr_reg_out;
				else if ( db_domain == cur_domain ) 
					mem_req_addr = db_dest_addr_reg_out;
			end

			STATE_WRITE_MEM_WAIT: begin
				ack			 = 1'b0;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b0;
				mem_req_type = 3'hx;
				mem_req_addr = 32'hx;
			end

			STATE_WRITE_MEM_DONE: begin
				ack			 = 1'b0;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b0;
				mem_req_type = 3'hx;
				mem_req_addr = 32'hx;
			end

			STATE_ACK: begin
				ack			 = 1'b1;
				enq_en		 = 1'b0;
				mem_req_val	 = 1'b0;
				mem_req_type = 3'hx;
				mem_req_addr = 32'hx;
			end

			STATE_DEBUG_RES: begin
                if ( mem_resp_domain == cur_domain && db_resp_domain == cur_domain ) begin
				    ack			 = 1'b1;
				    enq_en		 = 1'b0;
				    mem_req_val	 = 1'b0;
				    mem_req_type = 3'hx;
				    mem_req_addr = 32'hx;
				    debug_data	 = mem_resp_data_reg_out;
                end
			end
		endcase		
	end

endmodule
`endif /*PLAB5_MCORE_DMA_CONTROLLER_V*/

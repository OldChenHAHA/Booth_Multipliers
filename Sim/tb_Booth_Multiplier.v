///////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2010-2012 by Michael A. Morris, dba M. A. Morris & Associates
//
//  All rights reserved. The source code contained herein is publicly released
//  under the terms and conditions of the GNU Lesser Public License. No part of
//  this source code may be reproduced or transmitted in any form or by any
//  means, electronic or mechanical, including photocopying, recording, or any
//  information storage and retrieval system in violation of the license under
//  which the source code is released.
//
//  The souce code contained herein is free; it may be redistributed and/or 
//  modified in accordance with the terms of the GNU Lesser General Public
//  License as published by the Free Software Foundation; either version 2.1 of
//  the GNU Lesser General Public License, or any later version.
//
//  The souce code contained herein is freely released WITHOUT ANY WARRANTY;
//  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
//  PARTICULAR PURPOSE. (Refer to the GNU Lesser General Public License for
//  more details.)
//
//  A copy of the GNU Lesser General Public License should have been received
//  along with the source code contained herein; if not, a copy can be obtained
//  by writing to:
//
//  Free Software Foundation, Inc.
//  51 Franklin Street, Fifth Floor
//  Boston, MA  02110-1301 USA
//
//  Further, no use of this source code is permitted in any form or means
//  without inclusion of this banner prominently in any derived works. 
//
//  Michael A. Morris
//  Huntsville, AL
//
///////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////////////////
// Company:         M. A. Morris & Associates
// Engineer:        Michael A. Morris
//  
// Create Date:     21:48:39 07/10/2010
// Design Name:     Booth_Multiplier
// Module Name:     C:/XProjects/ISE10.1i/F9408/tb_Booth_Multiplier.v
// Project Name:    Booth_Multiplier
// Target Devices:  Spartan-3AN
// Tool versions:   Xilinx ISE 10.1 SP3
//
// Description:
//
// Verilog Test Fixture created by ISE for module: Booth_Multiplier
//
// Dependencies: 
//
// Revision: 
//
//  0.01    10G10   MAM     File Created
//
// Additional Comments: 
//
///////////////////////////////////////////////////////////////////////////////

module tb_Booth_Multiplier;

parameter N = 2;

//  UUT Signals

reg     Rst;
reg     Clk;

reg     Ld;
reg     [(2**N - 1):0] M;
reg     [(2**N - 1):0] R;

wire    Valid;
wire    [(2**(N+1) - 1):0] P;

//  Simulation Variables

reg     [2**(N+1):0] i;

// Instantiate the Unit Under Test (UUT)

Booth_Multiplier    #(
                        .pN(N)
                    ) uut (
                        .Rst(Rst), 
                        .Clk(Clk), 
                        .Ld(Ld), 
                        .M(M), 
                        .R(R), 
                        .Valid(Valid), 
                        .P(P)
                    );

initial begin
    // Initialize Inputs
    Rst = 1;
    Clk = 1;
    Ld  = 0;
    M   = 0;
    R   = 0;
    
    i   = 0;

    // Wait 100 ns for global reset to finish
    #101 Rst = 0;
    
    // Add stimulus here
    
    for(i = 0; i < (2**(2**(N+1))); i = i + 1) begin
        @(posedge Clk) #1 Ld = 1;
            M = i[(2**(N+1) - 1):2**N];
            R = i[(2**N - 1):0];
        @(posedge Clk) #1 Ld = 0;
        @(posedge Valid);
    end
    
end

///////////////////////////////////////////////////////////////////////////////

always #5 Clk = ~Clk;
      
///////////////////////////////////////////////////////////////////////////////

endmodule

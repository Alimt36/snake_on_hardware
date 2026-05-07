
# Nexys A7 100T ---> Artix 7 

# Clock signal
#set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {CLK100MHZ}];

set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -period 10.000 -name sys_clk [get_ports { clk }]

set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { rst }];


#Buttons
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { btn_D }]; #IO_L9P_T1_DQS_14 Sch=btnc
set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { btn_U }]; #IO_L4N_T0_D05_14 Sch=btnu
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { btn_L }]; #IO_L12P_T1_MRCC_14 Sch=btnl
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { btn_R }]; #IO_L10N_T1_D15_14 Sch=btnr
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { btn_D }]; #IO_L9N_T1_DQS_D13_14 Sch=btnd



## ROW - Pmod JC - bottom of the dot-matrix display
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { COL[7] }];
set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { COL[6] }];
set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { ROW[1] }];
set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { COL[0] }];
set_property -dict { PACKAGE_PIN E7    IOSTANDARD LVCMOS33 } [get_ports { ROW[3] }];
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { COL[5] }];
set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { COL[3] }];
set_property -dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports { ROW[0] }];

## COL - Pmod JD - top of the dot-matrix display
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { ROW[4] }];
set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { ROW[6] }];
set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { COL[1] }];
set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { COL[2] }];
set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { ROW[7] }];
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { COL[4] }];
set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { ROW[5] }];
set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { ROW[2] }];

### ROW - Pmod JC
### JC[1]  -> row[0]
### JC[2]  -> row[1]
### JC[3]  -> row[2]
### JC[4]  -> row[3]
### JC[7]  -> row[4]
### JC[8]  -> row[5]
### JC[9]  -> row[6]
### JC[10] -> row[7]
#set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { ROW[0] }];
#set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { ROW[1] }];
#set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { ROW[2] }];
#set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { ROW[3] }];
#set_property -dict { PACKAGE_PIN E7    IOSTANDARD LVCMOS33 } [get_ports { ROW[4] }];
#set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { ROW[5] }];
#set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { ROW[6] }];
#set_property -dict { PACKAGE_PIN E6    IOSTANDARD LVCMOS33 } [get_ports { ROW[7] }];

### COL - Pmod JD
### JD[1]  -> col[0]
### JD[2]  -> col[1]
### JD[3]  -> col[2]
### JD[4]  -> col[3]
### JD[7]  -> col[4]
### JD[8]  -> col[5]
### JD[9]  -> col[6]
### JD[10] -> col[7]
#set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { COL[0] }];
#set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { COL[1] }];
#set_property -dict { PACKAGE_PIN G1    IOSTANDARD LVCMOS33 } [get_ports { COL[2] }];
#set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { COL[3] }];
#set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { COL[4] }];
#set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { COL[5] }];
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { COL[6] }];
#set_property -dict { PACKAGE_PIN F3    IOSTANDARD LVCMOS33 } [get_ports { COL[7] }];





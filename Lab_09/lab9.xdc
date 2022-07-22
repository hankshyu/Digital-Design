## This file is a general .xdc for the ARTY Rev. A
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


# Clock signal

set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports reset_n]

#Switches

#set_property -dict { PACKAGE_PIN A8  IOSTANDARD LVCMOS33 } [get_ports { usr_sw[0] }]; #IO_L12N_T1_MRCC_16 Sch=sw[0]
#set_property -dict { PACKAGE_PIN C11 IOSTANDARD LVCMOS33 } [get_ports { usr_sw[1] }]; #IO_L13P_T2_MRCC_16 Sch=sw[1]
#set_property -dict { PACKAGE_PIN C10 IOSTANDARD LVCMOS33 } [get_ports { usr_sw[2] }]; #IO_L13N_T2_MRCC_16 Sch=sw[2]
#set_property -dict { PACKAGE_PIN A10 IOSTANDARD LVCMOS33 } [get_ports { usr_sw[3] }]; #IO_L14P_T2_SRCC_16 Sch=sw[3]


# LEDs

set_property -dict {PACKAGE_PIN H5 IOSTANDARD LVCMOS33} [get_ports {usr_led[0]}]
set_property -dict {PACKAGE_PIN J5 IOSTANDARD LVCMOS33} [get_ports {usr_led[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {usr_led[2]}]
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {usr_led[3]}]
#set_property -dict { PACKAGE_PIN E1  IOSTANDARD LVCMOS33 } [get_ports { rgb_led[0] }]; #IO_L18N_T2_35 Sch=led0_b
#set_property -dict { PACKAGE_PIN F6  IOSTANDARD LVCMOS33 } [get_ports { rgb_led[1] }]; #IO_L19N_T3_VREF_35 Sch=led0_g
#set_property -dict { PACKAGE_PIN G6  IOSTANDARD LVCMOS33 } [get_ports { rgb_led[2] }]; #IO_L19P_T3_35 Sch=led0_r
#set_property -dict { PACKAGE_PIN G4  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_b[1] }]; #IO_L20P_T3_35 Sch=led1_b
#set_property -dict { PACKAGE_PIN J4  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_g[1] }]; #IO_L21P_T3_DQS_35 Sch=led1_g
#set_property -dict { PACKAGE_PIN G3  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_r[1] }]; #IO_L20N_T3_35 Sch=led1_r
#set_property -dict { PACKAGE_PIN H4  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_b[2] }]; #IO_L21N_T3_DQS_35 Sch=led2_b
#set_property -dict { PACKAGE_PIN J2  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_g[2] }]; #IO_L22N_T3_35 Sch=led2_g
#set_property -dict { PACKAGE_PIN J3  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_r[2] }]; #IO_L22P_T3_35 Sch=led2_r
#set_property -dict { PACKAGE_PIN K2  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_b[3] }]; #IO_L23P_T3_35 Sch=led3_b
#set_property -dict { PACKAGE_PIN H6  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_g[3] }]; #IO_L24P_T3_35 Sch=led3_g
#set_property -dict { PACKAGE_PIN K1  IOSTANDARD LVCMOS33 } [get_ports { rgb_led_r[3] }]; #IO_L23N_T3_35 Sch=led3_r


#Buttons

set_property -dict {PACKAGE_PIN D9 IOSTANDARD LVCMOS33} [get_ports {usr_btn[0]}]
set_property -dict {PACKAGE_PIN C9 IOSTANDARD LVCMOS33} [get_ports {usr_btn[1]}]
set_property -dict {PACKAGE_PIN B9 IOSTANDARD LVCMOS33} [get_ports {usr_btn[2]}]
set_property -dict {PACKAGE_PIN B8 IOSTANDARD LVCMOS33} [get_ports {usr_btn[3]}]

#UART
#set_property -dict { PACKAGE_PIN D10 IOSTANDARD LVCMOS33 } [get_ports { uart_tx }]; #IO_L19N_T3_VREF_16 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN A9  IOSTANDARD LVCMOS33 } [get_ports { uart_rx }]; #IO_L14N_T2_SRCC_16 Sch=uart_txd_in

##ChipKit Digital I/O Low

#set_property -dict { PACKAGE_PIN V15 IOSTANDARD LVCMOS33 } [get_ports { ck_io[0] }]; #IO_L16P_T2_CSI_B_14 Sch=ck_io[0]
#set_property -dict { PACKAGE_PIN U16 IOSTANDARD LVCMOS33 } [get_ports { ck_io[1] }]; #IO_L18P_T2_A12_D28_14 Sch=ck_io[1]
#set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { ck_io[2] }]; #IO_L8N_T1_D12_14 Sch=ck_io[2]
#set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports { ck_io[3] }]; #IO_L19P_T3_A10_D26_14 Sch=ck_io[3]
#set_property -dict { PACKAGE_PIN R12 IOSTANDARD LVCMOS33 } [get_ports { ck_io[4] }]; #IO_L5P_T0_D06_14 Sch=ck_io[4]
#set_property -dict { PACKAGE_PIN T14 IOSTANDARD LVCMOS33 } [get_ports { ck_io[5] }]; #IO_L14P_T2_SRCC_14 Sch=ck_io[5]
#set_property -dict { PACKAGE_PIN T15 IOSTANDARD LVCMOS33 } [get_ports { ck_io[6] }]; #IO_L14N_T2_SRCC_14 Sch=ck_io[6]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports LCD_E]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports LCD_RW]
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports LCD_RS]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {LCD_D[3]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {LCD_D[2]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {LCD_D[1]}]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {LCD_D[0]}]

##ChipKit Digital I/O High

#set_property -dict { PACKAGE_PIN U11 IOSTANDARD LVCMOS33 } [get_ports { ck_io[26] }]; #IO_L19N_T3_A09_D25_VREF_14 Sch=ck_io[26]
#set_property -dict { PACKAGE_PIN V16 IOSTANDARD LVCMOS33 } [get_ports { ck_io[27] }]; #IO_L16N_T2_A15_D31_14 Sch=ck_io[27]
#set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports { VGA_HSYNC }]; #IO_L6N_T0_D08_VREF_14 Sch=ck_io[28]
#set_property -dict { PACKAGE_PIN R10 IOSTANDARD LVCMOS33 } [get_ports { VGA_VSYNC }]; #IO_25_14 Sch=ck_io[29]
#set_property -dict { PACKAGE_PIN R11 IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN[0] }]; #IO_0_14 Sch=ck_io[30]
#set_property -dict { PACKAGE_PIN R13 IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN[1] }]; #IO_L5N_T0_D07_14 Sch=ck_io[31]
#set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN[2] }]; #IO_L13N_T2_MRCC_14 Sch=ck_io[32]
#set_property -dict { PACKAGE_PIN P15 IOSTANDARD LVCMOS33 } [get_ports { VGA_GREEN[3] }]; #IO_L13P_T2_MRCC_14 Sch=ck_io[33]
#set_property -dict { PACKAGE_PIN R16 IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE[0] }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=ck_io[34]
#set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE[1] }]; #IO_L11N_T1_SRCC_14 Sch=ck_io[35]
#set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE[2] }]; #IO_L8P_T1_D11_14 Sch=ck_io[36]
#set_property -dict { PACKAGE_PIN U17 IOSTANDARD LVCMOS33 } [get_ports { VGA_BLUE[3] }]; #IO_L17P_T2_A14_D30_14 Sch=ck_io[37]
#set_property -dict { PACKAGE_PIN T18 IOSTANDARD LVCMOS33 } [get_ports { VGA_RED[0] }]; #IO_L7N_T1_D10_14 Sch=ck_io[38]
#set_property -dict { PACKAGE_PIN R18 IOSTANDARD LVCMOS33 } [get_ports { VGA_RED[1] }]; #IO_L7P_T1_D09_14 Sch=ck_io[39]
#set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports { VGA_RED[2] }]; #IO_L9N_T1_DQS_D13_14 Sch=ck_io[40]
#set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports { VGA_RED[3] }]; #IO_L9P_T1_DQS_14 Sch=ck_io[41]

##Misc. ChipKit signals

#set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { ck_ioa }]; #IO_L10N_T1_D15_14 Sch=ck_ioa
#set_property -dict { PACKAGE_PIN C2    IOSTANDARD LVCMOS33 } [get_ports { ck_rst }]; #IO_L16P_T2_35 Sch=ck_rst

## ChipKit SPI

#set_property -dict { PACKAGE_PIN G1  IOSTANDARD LVCMOS33 } [get_ports { spi_miso }]; #IO_L17N_T2_35 Sch=ck_miso
#set_property -dict { PACKAGE_PIN H1  IOSTANDARD LVCMOS33 } [get_ports { spi_mosi }]; #IO_L17P_T2_35 Sch=ck_mosi
#set_property -dict { PACKAGE_PIN F1  IOSTANDARD LVCMOS33 } [get_ports { spi_sck }]; #IO_L18P_T2_35 Sch=ck_sck
#set_property -dict { PACKAGE_PIN C1  IOSTANDARD LVCMOS33 } [get_ports { spi_ss }]; #IO_L16N_T2_35 Sch=ck_ss


## ChipKit I2C

#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { ck_scl }]; #IO_L4P_T0_D04_14 Sch=ck_scl
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { ck_sda }]; #IO_L4N_T0_D05_14 Sch=ck_sda
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { scl_pup }]; #IO_L9N_T1_DQS_AD3N_15 Sch=scl_pup
#set_property -dict { PACKAGE_PIN A13   IOSTANDARD LVCMOS33 } [get_ports { sda_pup }]; #IO_L9P_T1_DQS_AD3P_15 Sch=sda_pup


##SMSC Ethernet PHY

#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { eth_col }]; #IO_L16N_T2_A27_15 Sch=eth_col
#set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { eth_crs }]; #IO_L15N_T2_DQS_ADV_B_15 Sch=eth_crs
#set_property -dict { PACKAGE_PIN F16   IOSTANDARD LVCMOS33 } [get_ports { eth_mdc }]; #IO_L14N_T2_SRCC_15 Sch=eth_mdc
#set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { eth_mdio }]; #IO_L17P_T2_A26_15 Sch=eth_mdio
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { eth_ref_clk }]; #IO_L22P_T3_A17_15 Sch=eth_ref_clk
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { eth_rstn }]; #IO_L20P_T3_A20_15 Sch=eth_rstn
#set_property -dict { PACKAGE_PIN F15   IOSTANDARD LVCMOS33 } [get_ports { eth_rx_clk }]; #IO_L14P_T2_SRCC_15 Sch=eth_rx_clk
#set_property -dict { PACKAGE_PIN G16   IOSTANDARD LVCMOS33 } [get_ports { eth_rx_dv }]; #IO_L13N_T2_MRCC_15 Sch=eth_rx_dv
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[0] }]; #IO_L21N_T3_DQS_A18_15 Sch=eth_rxd[0]
#set_property -dict { PACKAGE_PIN E17   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[1] }]; #IO_L16P_T2_A28_15 Sch=eth_rxd[1]
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[2] }]; #IO_L21P_T3_DQS_15 Sch=eth_rxd[2]
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { eth_rxd[3] }]; #IO_L18N_T2_A23_15 Sch=eth_rxd[3]
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { eth_rxerr }]; #IO_L20N_T3_A19_15 Sch=eth_rxerr
#set_property -dict { PACKAGE_PIN H16   IOSTANDARD LVCMOS33 } [get_ports { eth_tx_clk }]; #IO_L13P_T2_MRCC_15 Sch=eth_tx_clk
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { eth_tx_en }]; #IO_L19N_T3_A21_VREF_15 Sch=eth_tx_en
#set_property -dict { PACKAGE_PIN H14   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[0] }]; #IO_L15P_T2_DQS_15 Sch=eth_txd[0]
#set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[1] }]; #IO_L19P_T3_A22_15 Sch=eth_txd[1]
#set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[2] }]; #IO_L17N_T2_A25_15 Sch=eth_txd[2]
#set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { eth_txd[3] }]; #IO_L18P_T2_A24_15 Sch=eth_txd[3]


##Quad SPI Flash

#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { qspi_cs }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]


##Power Analysis

#set_property -dict { PACKAGE_PIN A16   IOSTANDARD LVCMOS33 } [get_ports { sns0v_n[95] }]; #IO_L8N_T1_AD10N_15 Sch=sns0v_n[95]
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports { sns0v_p[95] }]; #IO_L8P_T1_AD10P_15 Sch=sns0v_p[95]
#set_property -dict { PACKAGE_PIN F14   IOSTANDARD LVCMOS33 } [get_ports { sns5v_n[0] }]; #IO_L5N_T0_AD9N_15 Sch=sns5v_n[0]
#set_property -dict { PACKAGE_PIN F13   IOSTANDARD LVCMOS33 } [get_ports { sns5v_p[0] }]; #IO_L5P_T0_AD9P_15 Sch=sns5v_p[0]
#set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { vsns5v[0] }]; #IO_L3P_T0_DQS_AD1P_15 Sch=vsns5v[0]
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { vsnsvu }]; #IO_L7P_T1_AD2P_15 Sch=vsnsvu

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]




connect_debug_port u_ila_0/probe1 [get_nets [list {f_times_g[0][0]} {f_times_g[0][1]} {f_times_g[0][2]} {f_times_g[0][3]} {f_times_g[0][4]} {f_times_g[0][5]} {f_times_g[0][6]} {f_times_g[0][7]} {f_times_g[0][8]} {f_times_g[0][9]} {f_times_g[0][10]} {f_times_g[0][11]} {f_times_g[0][12]} {f_times_g[0][13]} {f_times_g[0][14]}]]
connect_debug_port u_ila_0/probe2 [get_nets [list {f_times_g[16][0]} {f_times_g[16][1]} {f_times_g[16][2]} {f_times_g[16][3]} {f_times_g[16][4]} {f_times_g[16][5]} {f_times_g[16][6]} {f_times_g[16][7]} {f_times_g[16][8]} {f_times_g[16][9]} {f_times_g[16][10]} {f_times_g[16][11]} {f_times_g[16][12]} {f_times_g[16][13]} {f_times_g[16][14]}]]
connect_debug_port u_ila_0/probe3 [get_nets [list {f_times_g[26][0]} {f_times_g[26][1]} {f_times_g[26][2]} {f_times_g[26][3]} {f_times_g[26][4]} {f_times_g[26][5]} {f_times_g[26][6]} {f_times_g[26][7]} {f_times_g[26][8]} {f_times_g[26][9]} {f_times_g[26][10]} {f_times_g[26][11]} {f_times_g[26][12]} {f_times_g[26][13]} {f_times_g[26][14]}]]
connect_debug_port u_ila_0/probe4 [get_nets [list {f_times_g[10][0]} {f_times_g[10][1]} {f_times_g[10][2]} {f_times_g[10][3]} {f_times_g[10][4]} {f_times_g[10][5]} {f_times_g[10][6]} {f_times_g[10][7]} {f_times_g[10][8]} {f_times_g[10][9]} {f_times_g[10][10]} {f_times_g[10][11]} {f_times_g[10][12]} {f_times_g[10][13]} {f_times_g[10][14]}]]
connect_debug_port u_ila_0/probe5 [get_nets [list {f_times_g[27][0]} {f_times_g[27][1]} {f_times_g[27][2]} {f_times_g[27][3]} {f_times_g[27][4]} {f_times_g[27][5]} {f_times_g[27][6]} {f_times_g[27][7]} {f_times_g[27][8]} {f_times_g[27][9]} {f_times_g[27][10]} {f_times_g[27][11]} {f_times_g[27][12]} {f_times_g[27][13]} {f_times_g[27][14]}]]
connect_debug_port u_ila_0/probe6 [get_nets [list {f_times_g[14][0]} {f_times_g[14][1]} {f_times_g[14][2]} {f_times_g[14][3]} {f_times_g[14][4]} {f_times_g[14][5]} {f_times_g[14][6]} {f_times_g[14][7]} {f_times_g[14][8]} {f_times_g[14][9]} {f_times_g[14][10]} {f_times_g[14][11]} {f_times_g[14][12]} {f_times_g[14][13]} {f_times_g[14][14]}]]
connect_debug_port u_ila_0/probe7 [get_nets [list {f_times_g[29][0]} {f_times_g[29][1]} {f_times_g[29][2]} {f_times_g[29][3]} {f_times_g[29][4]} {f_times_g[29][5]} {f_times_g[29][6]} {f_times_g[29][7]} {f_times_g[29][8]} {f_times_g[29][9]} {f_times_g[29][10]} {f_times_g[29][11]} {f_times_g[29][12]} {f_times_g[29][13]} {f_times_g[29][14]}]]
connect_debug_port u_ila_0/probe8 [get_nets [list {f_times_g[30][0]} {f_times_g[30][1]} {f_times_g[30][2]} {f_times_g[30][3]} {f_times_g[30][4]} {f_times_g[30][5]} {f_times_g[30][6]} {f_times_g[30][7]} {f_times_g[30][8]} {f_times_g[30][9]} {f_times_g[30][10]} {f_times_g[30][11]} {f_times_g[30][12]} {f_times_g[30][13]} {f_times_g[30][14]}]]
connect_debug_port u_ila_0/probe9 [get_nets [list {f_times_g[31][0]} {f_times_g[31][1]} {f_times_g[31][2]} {f_times_g[31][3]} {f_times_g[31][4]} {f_times_g[31][5]} {f_times_g[31][6]} {f_times_g[31][7]} {f_times_g[31][8]} {f_times_g[31][9]} {f_times_g[31][10]} {f_times_g[31][11]} {f_times_g[31][12]} {f_times_g[31][13]} {f_times_g[31][14]}]]
connect_debug_port u_ila_0/probe10 [get_nets [list {f_times_g[21][0]} {f_times_g[21][1]} {f_times_g[21][2]} {f_times_g[21][3]} {f_times_g[21][4]} {f_times_g[21][5]} {f_times_g[21][6]} {f_times_g[21][7]} {f_times_g[21][8]} {f_times_g[21][9]} {f_times_g[21][10]} {f_times_g[21][11]} {f_times_g[21][12]} {f_times_g[21][13]} {f_times_g[21][14]}]]
connect_debug_port u_ila_0/probe11 [get_nets [list {f_times_g[34][0]} {f_times_g[34][1]} {f_times_g[34][2]} {f_times_g[34][3]} {f_times_g[34][4]} {f_times_g[34][5]} {f_times_g[34][6]} {f_times_g[34][7]} {f_times_g[34][8]} {f_times_g[34][9]} {f_times_g[34][10]} {f_times_g[34][11]} {f_times_g[34][12]} {f_times_g[34][13]} {f_times_g[34][14]}]]
connect_debug_port u_ila_0/probe12 [get_nets [list {f_times_g[13][0]} {f_times_g[13][1]} {f_times_g[13][2]} {f_times_g[13][3]} {f_times_g[13][4]} {f_times_g[13][5]} {f_times_g[13][6]} {f_times_g[13][7]} {f_times_g[13][8]} {f_times_g[13][9]} {f_times_g[13][10]} {f_times_g[13][11]} {f_times_g[13][12]} {f_times_g[13][13]} {f_times_g[13][14]}]]
connect_debug_port u_ila_0/probe13 [get_nets [list {f_times_g[19][0]} {f_times_g[19][1]} {f_times_g[19][2]} {f_times_g[19][3]} {f_times_g[19][4]} {f_times_g[19][5]} {f_times_g[19][6]} {f_times_g[19][7]} {f_times_g[19][8]} {f_times_g[19][9]} {f_times_g[19][10]} {f_times_g[19][11]} {f_times_g[19][12]} {f_times_g[19][13]} {f_times_g[19][14]}]]
connect_debug_port u_ila_0/probe14 [get_nets [list {f_times_g[23][0]} {f_times_g[23][1]} {f_times_g[23][2]} {f_times_g[23][3]} {f_times_g[23][4]} {f_times_g[23][5]} {f_times_g[23][6]} {f_times_g[23][7]} {f_times_g[23][8]} {f_times_g[23][9]} {f_times_g[23][10]} {f_times_g[23][11]} {f_times_g[23][12]} {f_times_g[23][13]} {f_times_g[23][14]}]]
connect_debug_port u_ila_0/probe15 [get_nets [list {f_times_g[33][0]} {f_times_g[33][1]} {f_times_g[33][2]} {f_times_g[33][3]} {f_times_g[33][4]} {f_times_g[33][5]} {f_times_g[33][6]} {f_times_g[33][7]} {f_times_g[33][8]} {f_times_g[33][9]} {f_times_g[33][10]} {f_times_g[33][11]} {f_times_g[33][12]} {f_times_g[33][13]} {f_times_g[33][14]}]]
connect_debug_port u_ila_0/probe16 [get_nets [list {f_times_g[2][0]} {f_times_g[2][1]} {f_times_g[2][2]} {f_times_g[2][3]} {f_times_g[2][4]} {f_times_g[2][5]} {f_times_g[2][6]} {f_times_g[2][7]} {f_times_g[2][8]} {f_times_g[2][9]} {f_times_g[2][10]} {f_times_g[2][11]} {f_times_g[2][12]} {f_times_g[2][13]} {f_times_g[2][14]}]]
connect_debug_port u_ila_0/probe17 [get_nets [list {f_times_g[35][0]} {f_times_g[35][1]} {f_times_g[35][2]} {f_times_g[35][3]} {f_times_g[35][4]} {f_times_g[35][5]} {f_times_g[35][6]} {f_times_g[35][7]} {f_times_g[35][8]} {f_times_g[35][9]} {f_times_g[35][10]} {f_times_g[35][11]} {f_times_g[35][12]} {f_times_g[35][13]} {f_times_g[35][14]}]]
connect_debug_port u_ila_0/probe18 [get_nets [list {f_times_g[22][0]} {f_times_g[22][1]} {f_times_g[22][2]} {f_times_g[22][3]} {f_times_g[22][4]} {f_times_g[22][5]} {f_times_g[22][6]} {f_times_g[22][7]} {f_times_g[22][8]} {f_times_g[22][9]} {f_times_g[22][10]} {f_times_g[22][11]} {f_times_g[22][12]} {f_times_g[22][13]} {f_times_g[22][14]}]]
connect_debug_port u_ila_0/probe19 [get_nets [list {f_times_g[17][0]} {f_times_g[17][1]} {f_times_g[17][2]} {f_times_g[17][3]} {f_times_g[17][4]} {f_times_g[17][5]} {f_times_g[17][6]} {f_times_g[17][7]} {f_times_g[17][8]} {f_times_g[17][9]} {f_times_g[17][10]} {f_times_g[17][11]} {f_times_g[17][12]} {f_times_g[17][13]} {f_times_g[17][14]}]]
connect_debug_port u_ila_0/probe20 [get_nets [list {f_times_g[25][0]} {f_times_g[25][1]} {f_times_g[25][2]} {f_times_g[25][3]} {f_times_g[25][4]} {f_times_g[25][5]} {f_times_g[25][6]} {f_times_g[25][7]} {f_times_g[25][8]} {f_times_g[25][9]} {f_times_g[25][10]} {f_times_g[25][11]} {f_times_g[25][12]} {f_times_g[25][13]} {f_times_g[25][14]}]]
connect_debug_port u_ila_0/probe21 [get_nets [list {f_times_g[11][0]} {f_times_g[11][1]} {f_times_g[11][2]} {f_times_g[11][3]} {f_times_g[11][4]} {f_times_g[11][5]} {f_times_g[11][6]} {f_times_g[11][7]} {f_times_g[11][8]} {f_times_g[11][9]} {f_times_g[11][10]} {f_times_g[11][11]} {f_times_g[11][12]} {f_times_g[11][13]} {f_times_g[11][14]}]]
connect_debug_port u_ila_0/probe22 [get_nets [list {f_times_g[12][0]} {f_times_g[12][1]} {f_times_g[12][2]} {f_times_g[12][3]} {f_times_g[12][4]} {f_times_g[12][5]} {f_times_g[12][6]} {f_times_g[12][7]} {f_times_g[12][8]} {f_times_g[12][9]} {f_times_g[12][10]} {f_times_g[12][11]} {f_times_g[12][12]} {f_times_g[12][13]} {f_times_g[12][14]}]]
connect_debug_port u_ila_0/probe23 [get_nets [list {f_times_g[28][0]} {f_times_g[28][1]} {f_times_g[28][2]} {f_times_g[28][3]} {f_times_g[28][4]} {f_times_g[28][5]} {f_times_g[28][6]} {f_times_g[28][7]} {f_times_g[28][8]} {f_times_g[28][9]} {f_times_g[28][10]} {f_times_g[28][11]} {f_times_g[28][12]} {f_times_g[28][13]} {f_times_g[28][14]}]]
connect_debug_port u_ila_0/probe24 [get_nets [list {f_times_g[36][0]} {f_times_g[36][1]} {f_times_g[36][2]} {f_times_g[36][3]} {f_times_g[36][4]} {f_times_g[36][5]} {f_times_g[36][6]} {f_times_g[36][7]} {f_times_g[36][8]} {f_times_g[36][9]} {f_times_g[36][10]} {f_times_g[36][11]} {f_times_g[36][12]} {f_times_g[36][13]} {f_times_g[36][14]}]]
connect_debug_port u_ila_0/probe25 [get_nets [list {f_times_g[37][0]} {f_times_g[37][1]} {f_times_g[37][2]} {f_times_g[37][3]} {f_times_g[37][4]} {f_times_g[37][5]} {f_times_g[37][6]} {f_times_g[37][7]} {f_times_g[37][8]} {f_times_g[37][9]} {f_times_g[37][10]} {f_times_g[37][11]} {f_times_g[37][12]} {f_times_g[37][13]} {f_times_g[37][14]}]]
connect_debug_port u_ila_0/probe26 [get_nets [list {f_times_g[38][0]} {f_times_g[38][1]} {f_times_g[38][2]} {f_times_g[38][3]} {f_times_g[38][4]} {f_times_g[38][5]} {f_times_g[38][6]} {f_times_g[38][7]} {f_times_g[38][8]} {f_times_g[38][9]} {f_times_g[38][10]} {f_times_g[38][11]} {f_times_g[38][12]} {f_times_g[38][13]} {f_times_g[38][14]}]]
connect_debug_port u_ila_0/probe27 [get_nets [list {f_times_g[1][0]} {f_times_g[1][1]} {f_times_g[1][2]} {f_times_g[1][3]} {f_times_g[1][4]} {f_times_g[1][5]} {f_times_g[1][6]} {f_times_g[1][7]} {f_times_g[1][8]} {f_times_g[1][9]} {f_times_g[1][10]} {f_times_g[1][11]} {f_times_g[1][12]} {f_times_g[1][13]} {f_times_g[1][14]}]]
connect_debug_port u_ila_0/probe28 [get_nets [list {f_times_g[32][0]} {f_times_g[32][1]} {f_times_g[32][2]} {f_times_g[32][3]} {f_times_g[32][4]} {f_times_g[32][5]} {f_times_g[32][6]} {f_times_g[32][7]} {f_times_g[32][8]} {f_times_g[32][9]} {f_times_g[32][10]} {f_times_g[32][11]} {f_times_g[32][12]} {f_times_g[32][13]} {f_times_g[32][14]}]]
connect_debug_port u_ila_0/probe29 [get_nets [list {f_times_g[20][0]} {f_times_g[20][1]} {f_times_g[20][2]} {f_times_g[20][3]} {f_times_g[20][4]} {f_times_g[20][5]} {f_times_g[20][6]} {f_times_g[20][7]} {f_times_g[20][8]} {f_times_g[20][9]} {f_times_g[20][10]} {f_times_g[20][11]} {f_times_g[20][12]} {f_times_g[20][13]} {f_times_g[20][14]}]]
connect_debug_port u_ila_0/probe30 [get_nets [list {f_times_g[24][0]} {f_times_g[24][1]} {f_times_g[24][2]} {f_times_g[24][3]} {f_times_g[24][4]} {f_times_g[24][5]} {f_times_g[24][6]} {f_times_g[24][7]} {f_times_g[24][8]} {f_times_g[24][9]} {f_times_g[24][10]} {f_times_g[24][11]} {f_times_g[24][12]} {f_times_g[24][13]} {f_times_g[24][14]}]]
connect_debug_port u_ila_0/probe31 [get_nets [list {f_times_g[18][0]} {f_times_g[18][1]} {f_times_g[18][2]} {f_times_g[18][3]} {f_times_g[18][4]} {f_times_g[18][5]} {f_times_g[18][6]} {f_times_g[18][7]} {f_times_g[18][8]} {f_times_g[18][9]} {f_times_g[18][10]} {f_times_g[18][11]} {f_times_g[18][12]} {f_times_g[18][13]} {f_times_g[18][14]}]]
connect_debug_port u_ila_0/probe32 [get_nets [list {f_times_g[15][0]} {f_times_g[15][1]} {f_times_g[15][2]} {f_times_g[15][3]} {f_times_g[15][4]} {f_times_g[15][5]} {f_times_g[15][6]} {f_times_g[15][7]} {f_times_g[15][8]} {f_times_g[15][9]} {f_times_g[15][10]} {f_times_g[15][11]} {f_times_g[15][12]} {f_times_g[15][13]} {f_times_g[15][14]}]]
connect_debug_port u_ila_0/probe33 [get_nets [list {f_times_g[60][0]} {f_times_g[60][1]} {f_times_g[60][2]} {f_times_g[60][3]} {f_times_g[60][4]} {f_times_g[60][5]} {f_times_g[60][6]} {f_times_g[60][7]} {f_times_g[60][8]} {f_times_g[60][9]} {f_times_g[60][10]} {f_times_g[60][11]} {f_times_g[60][12]} {f_times_g[60][13]} {f_times_g[60][14]}]]
connect_debug_port u_ila_0/probe34 [get_nets [list {f_times_g[61][0]} {f_times_g[61][1]} {f_times_g[61][2]} {f_times_g[61][3]} {f_times_g[61][4]} {f_times_g[61][5]} {f_times_g[61][6]} {f_times_g[61][7]} {f_times_g[61][8]} {f_times_g[61][9]} {f_times_g[61][10]} {f_times_g[61][11]} {f_times_g[61][12]} {f_times_g[61][13]} {f_times_g[61][14]}]]
connect_debug_port u_ila_0/probe35 [get_nets [list {f_times_g[7][0]} {f_times_g[7][1]} {f_times_g[7][2]} {f_times_g[7][3]} {f_times_g[7][4]} {f_times_g[7][5]} {f_times_g[7][6]} {f_times_g[7][7]} {f_times_g[7][8]} {f_times_g[7][9]} {f_times_g[7][10]} {f_times_g[7][11]} {f_times_g[7][12]} {f_times_g[7][13]} {f_times_g[7][14]}]]
connect_debug_port u_ila_0/probe36 [get_nets [list {f_times_g[49][0]} {f_times_g[49][1]} {f_times_g[49][2]} {f_times_g[49][3]} {f_times_g[49][4]} {f_times_g[49][5]} {f_times_g[49][6]} {f_times_g[49][7]} {f_times_g[49][8]} {f_times_g[49][9]} {f_times_g[49][10]} {f_times_g[49][11]} {f_times_g[49][12]} {f_times_g[49][13]} {f_times_g[49][14]}]]
connect_debug_port u_ila_0/probe37 [get_nets [list {f_times_g[44][0]} {f_times_g[44][1]} {f_times_g[44][2]} {f_times_g[44][3]} {f_times_g[44][4]} {f_times_g[44][5]} {f_times_g[44][6]} {f_times_g[44][7]} {f_times_g[44][8]} {f_times_g[44][9]} {f_times_g[44][10]} {f_times_g[44][11]} {f_times_g[44][12]} {f_times_g[44][13]} {f_times_g[44][14]}]]
connect_debug_port u_ila_0/probe38 [get_nets [list {f_times_g[51][0]} {f_times_g[51][1]} {f_times_g[51][2]} {f_times_g[51][3]} {f_times_g[51][4]} {f_times_g[51][5]} {f_times_g[51][6]} {f_times_g[51][7]} {f_times_g[51][8]} {f_times_g[51][9]} {f_times_g[51][10]} {f_times_g[51][11]} {f_times_g[51][12]} {f_times_g[51][13]} {f_times_g[51][14]}]]
connect_debug_port u_ila_0/probe39 [get_nets [list {f_times_g[63][0]} {f_times_g[63][1]} {f_times_g[63][2]} {f_times_g[63][3]} {f_times_g[63][4]} {f_times_g[63][5]} {f_times_g[63][6]} {f_times_g[63][7]} {f_times_g[63][8]} {f_times_g[63][9]} {f_times_g[63][10]} {f_times_g[63][11]} {f_times_g[63][12]} {f_times_g[63][13]} {f_times_g[63][14]}]]
connect_debug_port u_ila_0/probe40 [get_nets [list {f_times_g[3][0]} {f_times_g[3][1]} {f_times_g[3][2]} {f_times_g[3][3]} {f_times_g[3][4]} {f_times_g[3][5]} {f_times_g[3][6]} {f_times_g[3][7]} {f_times_g[3][8]} {f_times_g[3][9]} {f_times_g[3][10]} {f_times_g[3][11]} {f_times_g[3][12]} {f_times_g[3][13]} {f_times_g[3][14]}]]
connect_debug_port u_ila_0/probe41 [get_nets [list {f_times_g[46][0]} {f_times_g[46][1]} {f_times_g[46][2]} {f_times_g[46][3]} {f_times_g[46][4]} {f_times_g[46][5]} {f_times_g[46][6]} {f_times_g[46][7]} {f_times_g[46][8]} {f_times_g[46][9]} {f_times_g[46][10]} {f_times_g[46][11]} {f_times_g[46][12]} {f_times_g[46][13]} {f_times_g[46][14]}]]
connect_debug_port u_ila_0/probe42 [get_nets [list {f_times_g[52][0]} {f_times_g[52][1]} {f_times_g[52][2]} {f_times_g[52][3]} {f_times_g[52][4]} {f_times_g[52][5]} {f_times_g[52][6]} {f_times_g[52][7]} {f_times_g[52][8]} {f_times_g[52][9]} {f_times_g[52][10]} {f_times_g[52][11]} {f_times_g[52][12]} {f_times_g[52][13]} {f_times_g[52][14]}]]
connect_debug_port u_ila_0/probe43 [get_nets [list {f_times_g[42][0]} {f_times_g[42][1]} {f_times_g[42][2]} {f_times_g[42][3]} {f_times_g[42][4]} {f_times_g[42][5]} {f_times_g[42][6]} {f_times_g[42][7]} {f_times_g[42][8]} {f_times_g[42][9]} {f_times_g[42][10]} {f_times_g[42][11]} {f_times_g[42][12]} {f_times_g[42][13]} {f_times_g[42][14]}]]
connect_debug_port u_ila_0/probe44 [get_nets [list {f_times_g[55][0]} {f_times_g[55][1]} {f_times_g[55][2]} {f_times_g[55][3]} {f_times_g[55][4]} {f_times_g[55][5]} {f_times_g[55][6]} {f_times_g[55][7]} {f_times_g[55][8]} {f_times_g[55][9]} {f_times_g[55][10]} {f_times_g[55][11]} {f_times_g[55][12]} {f_times_g[55][13]} {f_times_g[55][14]}]]
connect_debug_port u_ila_0/probe45 [get_nets [list {f_times_g[5][0]} {f_times_g[5][1]} {f_times_g[5][2]} {f_times_g[5][3]} {f_times_g[5][4]} {f_times_g[5][5]} {f_times_g[5][6]} {f_times_g[5][7]} {f_times_g[5][8]} {f_times_g[5][9]} {f_times_g[5][10]} {f_times_g[5][11]} {f_times_g[5][12]} {f_times_g[5][13]} {f_times_g[5][14]}]]
connect_debug_port u_ila_0/probe46 [get_nets [list {f_times_g[48][0]} {f_times_g[48][1]} {f_times_g[48][2]} {f_times_g[48][3]} {f_times_g[48][4]} {f_times_g[48][5]} {f_times_g[48][6]} {f_times_g[48][7]} {f_times_g[48][8]} {f_times_g[48][9]} {f_times_g[48][10]} {f_times_g[48][11]} {f_times_g[48][12]} {f_times_g[48][13]} {f_times_g[48][14]}]]
connect_debug_port u_ila_0/probe47 [get_nets [list {f_times_g[56][0]} {f_times_g[56][1]} {f_times_g[56][2]} {f_times_g[56][3]} {f_times_g[56][4]} {f_times_g[56][5]} {f_times_g[56][6]} {f_times_g[56][7]} {f_times_g[56][8]} {f_times_g[56][9]} {f_times_g[56][10]} {f_times_g[56][11]} {f_times_g[56][12]} {f_times_g[56][13]} {f_times_g[56][14]}]]
connect_debug_port u_ila_0/probe48 [get_nets [list {f_times_g[45][0]} {f_times_g[45][1]} {f_times_g[45][2]} {f_times_g[45][3]} {f_times_g[45][4]} {f_times_g[45][5]} {f_times_g[45][6]} {f_times_g[45][7]} {f_times_g[45][8]} {f_times_g[45][9]} {f_times_g[45][10]} {f_times_g[45][11]} {f_times_g[45][12]} {f_times_g[45][13]} {f_times_g[45][14]}]]
connect_debug_port u_ila_0/probe49 [get_nets [list {f_times_g[58][0]} {f_times_g[58][1]} {f_times_g[58][2]} {f_times_g[58][3]} {f_times_g[58][4]} {f_times_g[58][5]} {f_times_g[58][6]} {f_times_g[58][7]} {f_times_g[58][8]} {f_times_g[58][9]} {f_times_g[58][10]} {f_times_g[58][11]} {f_times_g[58][12]} {f_times_g[58][13]} {f_times_g[58][14]}]]
connect_debug_port u_ila_0/probe50 [get_nets [list {f_times_g[57][0]} {f_times_g[57][1]} {f_times_g[57][2]} {f_times_g[57][3]} {f_times_g[57][4]} {f_times_g[57][5]} {f_times_g[57][6]} {f_times_g[57][7]} {f_times_g[57][8]} {f_times_g[57][9]} {f_times_g[57][10]} {f_times_g[57][11]} {f_times_g[57][12]} {f_times_g[57][13]} {f_times_g[57][14]}]]
connect_debug_port u_ila_0/probe51 [get_nets [list {f_times_g[40][0]} {f_times_g[40][1]} {f_times_g[40][2]} {f_times_g[40][3]} {f_times_g[40][4]} {f_times_g[40][5]} {f_times_g[40][6]} {f_times_g[40][7]} {f_times_g[40][8]} {f_times_g[40][9]} {f_times_g[40][10]} {f_times_g[40][11]} {f_times_g[40][12]} {f_times_g[40][13]} {f_times_g[40][14]}]]
connect_debug_port u_ila_0/probe52 [get_nets [list {f_times_g[59][0]} {f_times_g[59][1]} {f_times_g[59][2]} {f_times_g[59][3]} {f_times_g[59][4]} {f_times_g[59][5]} {f_times_g[59][6]} {f_times_g[59][7]} {f_times_g[59][8]} {f_times_g[59][9]} {f_times_g[59][10]} {f_times_g[59][11]} {f_times_g[59][12]} {f_times_g[59][13]} {f_times_g[59][14]}]]
connect_debug_port u_ila_0/probe53 [get_nets [list {f_times_g[62][0]} {f_times_g[62][1]} {f_times_g[62][2]} {f_times_g[62][3]} {f_times_g[62][4]} {f_times_g[62][5]} {f_times_g[62][6]} {f_times_g[62][7]} {f_times_g[62][8]} {f_times_g[62][9]} {f_times_g[62][10]} {f_times_g[62][11]} {f_times_g[62][12]} {f_times_g[62][13]} {f_times_g[62][14]}]]
connect_debug_port u_ila_0/probe54 [get_nets [list {f_times_g[6][0]} {f_times_g[6][1]} {f_times_g[6][2]} {f_times_g[6][3]} {f_times_g[6][4]} {f_times_g[6][5]} {f_times_g[6][6]} {f_times_g[6][7]} {f_times_g[6][8]} {f_times_g[6][9]} {f_times_g[6][10]} {f_times_g[6][11]} {f_times_g[6][12]} {f_times_g[6][13]} {f_times_g[6][14]}]]
connect_debug_port u_ila_0/probe55 [get_nets [list {f_times_g[50][0]} {f_times_g[50][1]} {f_times_g[50][2]} {f_times_g[50][3]} {f_times_g[50][4]} {f_times_g[50][5]} {f_times_g[50][6]} {f_times_g[50][7]} {f_times_g[50][8]} {f_times_g[50][9]} {f_times_g[50][10]} {f_times_g[50][11]} {f_times_g[50][12]} {f_times_g[50][13]} {f_times_g[50][14]}]]
connect_debug_port u_ila_0/probe56 [get_nets [list {f_times_g[39][0]} {f_times_g[39][1]} {f_times_g[39][2]} {f_times_g[39][3]} {f_times_g[39][4]} {f_times_g[39][5]} {f_times_g[39][6]} {f_times_g[39][7]} {f_times_g[39][8]} {f_times_g[39][9]} {f_times_g[39][10]} {f_times_g[39][11]} {f_times_g[39][12]} {f_times_g[39][13]} {f_times_g[39][14]}]]
connect_debug_port u_ila_0/probe57 [get_nets [list {f_times_g[47][0]} {f_times_g[47][1]} {f_times_g[47][2]} {f_times_g[47][3]} {f_times_g[47][4]} {f_times_g[47][5]} {f_times_g[47][6]} {f_times_g[47][7]} {f_times_g[47][8]} {f_times_g[47][9]} {f_times_g[47][10]} {f_times_g[47][11]} {f_times_g[47][12]} {f_times_g[47][13]} {f_times_g[47][14]}]]


connect_debug_port u_ila_0/probe0 [get_nets [list {reg_f[38][0]} {reg_f[38][1]} {reg_f[38][2]} {reg_f[38][3]} {reg_f[38][4]} {reg_f[38][5]} {reg_f[38][6]} {reg_f[38][7]}]]
connect_debug_port u_ila_0/probe1 [get_nets [list {reg_f[41][0]} {reg_f[41][1]} {reg_f[41][2]} {reg_f[41][3]} {reg_f[41][4]} {reg_f[41][5]} {reg_f[41][6]} {reg_f[41][7]}]]
connect_debug_port u_ila_0/probe3 [get_nets [list {reg_f[12][0]} {reg_f[12][1]} {reg_f[12][2]} {reg_f[12][3]} {reg_f[12][4]} {reg_f[12][5]} {reg_f[12][6]} {reg_f[12][7]}]]
connect_debug_port u_ila_0/probe4 [get_nets [list {reg_f[11][0]} {reg_f[11][1]} {reg_f[11][2]} {reg_f[11][3]} {reg_f[11][4]} {reg_f[11][5]} {reg_f[11][6]} {reg_f[11][7]}]]
connect_debug_port u_ila_0/probe5 [get_nets [list {reg_f[42][0]} {reg_f[42][1]} {reg_f[42][2]} {reg_f[42][3]} {reg_f[42][4]} {reg_f[42][5]} {reg_f[42][6]} {reg_f[42][7]}]]
connect_debug_port u_ila_0/probe6 [get_nets [list {reg_f[10][0]} {reg_f[10][1]} {reg_f[10][2]} {reg_f[10][3]} {reg_f[10][4]} {reg_f[10][5]} {reg_f[10][6]} {reg_f[10][7]}]]
connect_debug_port u_ila_0/probe7 [get_nets [list {reg_f[13][0]} {reg_f[13][1]} {reg_f[13][2]} {reg_f[13][3]} {reg_f[13][4]} {reg_f[13][5]} {reg_f[13][6]} {reg_f[13][7]}]]
connect_debug_port u_ila_0/probe8 [get_nets [list {reg_f[34][0]} {reg_f[34][1]} {reg_f[34][2]} {reg_f[34][3]} {reg_f[34][4]} {reg_f[34][5]} {reg_f[34][6]} {reg_f[34][7]}]]
connect_debug_port u_ila_0/probe9 [get_nets [list {reg_f[43][0]} {reg_f[43][1]} {reg_f[43][2]} {reg_f[43][3]} {reg_f[43][4]} {reg_f[43][5]} {reg_f[43][6]} {reg_f[43][7]}]]
connect_debug_port u_ila_0/probe11 [get_nets [list {reg_f[29][0]} {reg_f[29][1]} {reg_f[29][2]} {reg_f[29][3]} {reg_f[29][4]} {reg_f[29][5]} {reg_f[29][6]} {reg_f[29][7]}]]
connect_debug_port u_ila_0/probe13 [get_nets [list {reg_f[0]__0[0]} {reg_f[0]__0[1]} {reg_f[0]__0[2]} {reg_f[0]__0[3]} {reg_f[0]__0[4]} {reg_f[0]__0[5]} {reg_f[0]__0[6]} {reg_f[0]__0[7]}]]
connect_debug_port u_ila_0/probe14 [get_nets [list {reg_f[20][0]} {reg_f[20][1]} {reg_f[20][2]} {reg_f[20][3]} {reg_f[20][4]} {reg_f[20][5]} {reg_f[20][6]} {reg_f[20][7]}]]
connect_debug_port u_ila_0/probe15 [get_nets [list {reg_f[31][0]} {reg_f[31][1]} {reg_f[31][2]} {reg_f[31][3]} {reg_f[31][4]} {reg_f[31][5]} {reg_f[31][6]} {reg_f[31][7]}]]
connect_debug_port u_ila_0/probe16 [get_nets [list {reg_f[44][0]} {reg_f[44][1]} {reg_f[44][2]} {reg_f[44][3]} {reg_f[44][4]} {reg_f[44][5]} {reg_f[44][6]} {reg_f[44][7]}]]
connect_debug_port u_ila_0/probe17 [get_nets [list {reg_f[45][0]} {reg_f[45][1]} {reg_f[45][2]} {reg_f[45][3]} {reg_f[45][4]} {reg_f[45][5]} {reg_f[45][6]} {reg_f[45][7]}]]
connect_debug_port u_ila_0/probe19 [get_nets [list {reg_f[17][0]} {reg_f[17][1]} {reg_f[17][2]} {reg_f[17][3]} {reg_f[17][4]} {reg_f[17][5]} {reg_f[17][6]} {reg_f[17][7]}]]
connect_debug_port u_ila_0/probe20 [get_nets [list {reg_f[21][0]} {reg_f[21][1]} {reg_f[21][2]} {reg_f[21][3]} {reg_f[21][4]} {reg_f[21][5]} {reg_f[21][6]} {reg_f[21][7]}]]
connect_debug_port u_ila_0/probe21 [get_nets [list {reg_f[46][0]} {reg_f[46][1]} {reg_f[46][2]} {reg_f[46][3]} {reg_f[46][4]} {reg_f[46][5]} {reg_f[46][6]} {reg_f[46][7]}]]
connect_debug_port u_ila_0/probe22 [get_nets [list {reg_f[47][0]} {reg_f[47][1]} {reg_f[47][2]} {reg_f[47][3]} {reg_f[47][4]} {reg_f[47][5]} {reg_f[47][6]} {reg_f[47][7]}]]
connect_debug_port u_ila_0/probe23 [get_nets [list {reg_f[48][0]} {reg_f[48][1]} {reg_f[48][2]} {reg_f[48][3]} {reg_f[48][4]} {reg_f[48][5]} {reg_f[48][6]} {reg_f[48][7]}]]
connect_debug_port u_ila_0/probe25 [get_nets [list {reg_f[19][0]} {reg_f[19][1]} {reg_f[19][2]} {reg_f[19][3]} {reg_f[19][4]} {reg_f[19][5]} {reg_f[19][6]} {reg_f[19][7]}]]
connect_debug_port u_ila_0/probe26 [get_nets [list {reg_f[22][0]} {reg_f[22][1]} {reg_f[22][2]} {reg_f[22][3]} {reg_f[22][4]} {reg_f[22][5]} {reg_f[22][6]} {reg_f[22][7]}]]
connect_debug_port u_ila_0/probe27 [get_nets [list {reg_f[14][0]} {reg_f[14][1]} {reg_f[14][2]} {reg_f[14][3]} {reg_f[14][4]} {reg_f[14][5]} {reg_f[14][6]} {reg_f[14][7]}]]
connect_debug_port u_ila_0/probe28 [get_nets [list {reg_f[36][0]} {reg_f[36][1]} {reg_f[36][2]} {reg_f[36][3]} {reg_f[36][4]} {reg_f[36][5]} {reg_f[36][6]} {reg_f[36][7]}]]
connect_debug_port u_ila_0/probe29 [get_nets [list {reg_f[39][0]} {reg_f[39][1]} {reg_f[39][2]} {reg_f[39][3]} {reg_f[39][4]} {reg_f[39][5]} {reg_f[39][6]} {reg_f[39][7]}]]
connect_debug_port u_ila_0/probe30 [get_nets [list {reg_f[30][0]} {reg_f[30][1]} {reg_f[30][2]} {reg_f[30][3]} {reg_f[30][4]} {reg_f[30][5]} {reg_f[30][6]} {reg_f[30][7]}]]
connect_debug_port u_ila_0/probe32 [get_nets [list {reg_f[1]__0[0]} {reg_f[1]__0[1]} {reg_f[1]__0[2]} {reg_f[1]__0[3]} {reg_f[1]__0[4]} {reg_f[1]__0[5]} {reg_f[1]__0[6]} {reg_f[1]__0[7]}]]
connect_debug_port u_ila_0/probe33 [get_nets [list {reg_f[24][0]} {reg_f[24][1]} {reg_f[24][2]} {reg_f[24][3]} {reg_f[24][4]} {reg_f[24][5]} {reg_f[24][6]} {reg_f[24][7]}]]
connect_debug_port u_ila_0/probe34 [get_nets [list {reg_f[25][0]} {reg_f[25][1]} {reg_f[25][2]} {reg_f[25][3]} {reg_f[25][4]} {reg_f[25][5]} {reg_f[25][6]} {reg_f[25][7]}]]
connect_debug_port u_ila_0/probe35 [get_nets [list {reg_f[28][0]} {reg_f[28][1]} {reg_f[28][2]} {reg_f[28][3]} {reg_f[28][4]} {reg_f[28][5]} {reg_f[28][6]} {reg_f[28][7]}]]
connect_debug_port u_ila_0/probe36 [get_nets [list {reg_f[37][0]} {reg_f[37][1]} {reg_f[37][2]} {reg_f[37][3]} {reg_f[37][4]} {reg_f[37][5]} {reg_f[37][6]} {reg_f[37][7]}]]
connect_debug_port u_ila_0/probe37 [get_nets [list {reg_f[15][0]} {reg_f[15][1]} {reg_f[15][2]} {reg_f[15][3]} {reg_f[15][4]} {reg_f[15][5]} {reg_f[15][6]} {reg_f[15][7]}]]
connect_debug_port u_ila_0/probe38 [get_nets [list {reg_f[18][0]} {reg_f[18][1]} {reg_f[18][2]} {reg_f[18][3]} {reg_f[18][4]} {reg_f[18][5]} {reg_f[18][6]} {reg_f[18][7]}]]
connect_debug_port u_ila_0/probe39 [get_nets [list {reg_f[23][0]} {reg_f[23][1]} {reg_f[23][2]} {reg_f[23][3]} {reg_f[23][4]} {reg_f[23][5]} {reg_f[23][6]} {reg_f[23][7]}]]
connect_debug_port u_ila_0/probe40 [get_nets [list {reg_f[27][0]} {reg_f[27][1]} {reg_f[27][2]} {reg_f[27][3]} {reg_f[27][4]} {reg_f[27][5]} {reg_f[27][6]} {reg_f[27][7]}]]
connect_debug_port u_ila_0/probe42 [get_nets [list {reg_f[33][0]} {reg_f[33][1]} {reg_f[33][2]} {reg_f[33][3]} {reg_f[33][4]} {reg_f[33][5]} {reg_f[33][6]} {reg_f[33][7]}]]
connect_debug_port u_ila_0/probe43 [get_nets [list {reg_f[3]__0[0]} {reg_f[3]__0[1]} {reg_f[3]__0[2]} {reg_f[3]__0[3]} {reg_f[3]__0[4]} {reg_f[3]__0[5]} {reg_f[3]__0[6]} {reg_f[3]__0[7]}]]
connect_debug_port u_ila_0/probe44 [get_nets [list {reg_f[2]__0[0]} {reg_f[2]__0[1]} {reg_f[2]__0[2]} {reg_f[2]__0[3]} {reg_f[2]__0[4]} {reg_f[2]__0[5]} {reg_f[2]__0[6]} {reg_f[2]__0[7]}]]
connect_debug_port u_ila_0/probe45 [get_nets [list {reg_f[40][0]} {reg_f[40][1]} {reg_f[40][2]} {reg_f[40][3]} {reg_f[40][4]} {reg_f[40][5]} {reg_f[40][6]} {reg_f[40][7]}]]
connect_debug_port u_ila_0/probe46 [get_nets [list {reg_f[32][0]} {reg_f[32][1]} {reg_f[32][2]} {reg_f[32][3]} {reg_f[32][4]} {reg_f[32][5]} {reg_f[32][6]} {reg_f[32][7]}]]
connect_debug_port u_ila_0/probe47 [get_nets [list {reg_f[16][0]} {reg_f[16][1]} {reg_f[16][2]} {reg_f[16][3]} {reg_f[16][4]} {reg_f[16][5]} {reg_f[16][6]} {reg_f[16][7]}]]
connect_debug_port u_ila_0/probe48 [get_nets [list {reg_f[26][0]} {reg_f[26][1]} {reg_f[26][2]} {reg_f[26][3]} {reg_f[26][4]} {reg_f[26][5]} {reg_f[26][6]} {reg_f[26][7]}]]
connect_debug_port u_ila_0/probe49 [get_nets [list {reg_f[35][0]} {reg_f[35][1]} {reg_f[35][2]} {reg_f[35][3]} {reg_f[35][4]} {reg_f[35][5]} {reg_f[35][6]} {reg_f[35][7]}]]
connect_debug_port u_ila_0/probe50 [get_nets [list {reg_f[51][0]} {reg_f[51][1]} {reg_f[51][2]} {reg_f[51][3]} {reg_f[51][4]} {reg_f[51][5]} {reg_f[51][6]} {reg_f[51][7]}]]
connect_debug_port u_ila_0/probe51 [get_nets [list {reg_f[59][0]} {reg_f[59][1]} {reg_f[59][2]} {reg_f[59][3]} {reg_f[59][4]} {reg_f[59][5]} {reg_f[59][6]} {reg_f[59][7]}]]
connect_debug_port u_ila_0/probe52 [get_nets [list {reg_g[3][0]} {reg_g[3][1]} {reg_g[3][2]} {reg_g[3][3]} {reg_g[3][4]} {reg_g[3][5]} {reg_g[3][6]} {reg_g[3][7]}]]
connect_debug_port u_ila_0/probe53 [get_nets [list {reg_g[44][0]} {reg_g[44][1]} {reg_g[44][2]} {reg_g[44][3]} {reg_g[44][4]} {reg_g[44][5]} {reg_g[44][6]} {reg_g[44][7]}]]
connect_debug_port u_ila_0/probe54 [get_nets [list {reg_f[9][0]} {reg_f[9][1]} {reg_f[9][2]} {reg_f[9][3]} {reg_f[9][4]} {reg_f[9][5]} {reg_f[9][6]} {reg_f[9][7]}]]
connect_debug_port u_ila_0/probe55 [get_nets [list {reg_f[61][0]} {reg_f[61][1]} {reg_f[61][2]} {reg_f[61][3]} {reg_f[61][4]} {reg_f[61][5]} {reg_f[61][6]} {reg_f[61][7]}]]
connect_debug_port u_ila_0/probe56 [get_nets [list {reg_g[16][0]} {reg_g[16][1]} {reg_g[16][2]} {reg_g[16][3]} {reg_g[16][4]} {reg_g[16][5]} {reg_g[16][6]} {reg_g[16][7]}]]
connect_debug_port u_ila_0/probe57 [get_nets [list {reg_g[18][0]} {reg_g[18][1]} {reg_g[18][2]} {reg_g[18][3]} {reg_g[18][4]} {reg_g[18][5]} {reg_g[18][6]} {reg_g[18][7]}]]
connect_debug_port u_ila_0/probe58 [get_nets [list {reg_g[1][0]} {reg_g[1][1]} {reg_g[1][2]} {reg_g[1][3]} {reg_g[1][4]} {reg_g[1][5]} {reg_g[1][6]} {reg_g[1][7]}]]
connect_debug_port u_ila_0/probe59 [get_nets [list {reg_f[6]__0[0]} {reg_f[6]__0[1]} {reg_f[6]__0[2]} {reg_f[6]__0[3]} {reg_f[6]__0[4]} {reg_f[6]__0[5]} {reg_f[6]__0[6]} {reg_f[6]__0[7]}]]
connect_debug_port u_ila_0/probe60 [get_nets [list {reg_g[22][0]} {reg_g[22][1]} {reg_g[22][2]} {reg_g[22][3]} {reg_g[22][4]} {reg_g[22][5]} {reg_g[22][6]} {reg_g[22][7]}]]
connect_debug_port u_ila_0/probe61 [get_nets [list {reg_g[24][0]} {reg_g[24][1]} {reg_g[24][2]} {reg_g[24][3]} {reg_g[24][4]} {reg_g[24][5]} {reg_g[24][6]} {reg_g[24][7]}]]
connect_debug_port u_ila_0/probe62 [get_nets [list {reg_f[4]__0[0]} {reg_f[4]__0[1]} {reg_f[4]__0[2]} {reg_f[4]__0[3]} {reg_f[4]__0[4]} {reg_f[4]__0[5]} {reg_f[4]__0[6]} {reg_f[4]__0[7]}]]
connect_debug_port u_ila_0/probe63 [get_nets [list {reg_f[55][0]} {reg_f[55][1]} {reg_f[55][2]} {reg_f[55][3]} {reg_f[55][4]} {reg_f[55][5]} {reg_f[55][6]} {reg_f[55][7]}]]
connect_debug_port u_ila_0/probe64 [get_nets [list {reg_f[56][0]} {reg_f[56][1]} {reg_f[56][2]} {reg_f[56][3]} {reg_f[56][4]} {reg_f[56][5]} {reg_f[56][6]} {reg_f[56][7]}]]
connect_debug_port u_ila_0/probe65 [get_nets [list {reg_f[60][0]} {reg_f[60][1]} {reg_f[60][2]} {reg_f[60][3]} {reg_f[60][4]} {reg_f[60][5]} {reg_f[60][6]} {reg_f[60][7]}]]
connect_debug_port u_ila_0/probe66 [get_nets [list {reg_f[50][0]} {reg_f[50][1]} {reg_f[50][2]} {reg_f[50][3]} {reg_f[50][4]} {reg_f[50][5]} {reg_f[50][6]} {reg_f[50][7]}]]
connect_debug_port u_ila_0/probe67 [get_nets [list {reg_f[62][0]} {reg_f[62][1]} {reg_f[62][2]} {reg_f[62][3]} {reg_f[62][4]} {reg_f[62][5]} {reg_f[62][6]} {reg_f[62][7]}]]
connect_debug_port u_ila_0/probe68 [get_nets [list {reg_f[63][0]} {reg_f[63][1]} {reg_f[63][2]} {reg_f[63][3]} {reg_f[63][4]} {reg_f[63][5]} {reg_f[63][6]} {reg_f[63][7]}]]
connect_debug_port u_ila_0/probe69 [get_nets [list {reg_f[8][0]} {reg_f[8][1]} {reg_f[8][2]} {reg_f[8][3]} {reg_f[8][4]} {reg_f[8][5]} {reg_f[8][6]} {reg_f[8][7]}]]
connect_debug_port u_ila_0/probe70 [get_nets [list {reg_g[17][0]} {reg_g[17][1]} {reg_g[17][2]} {reg_g[17][3]} {reg_g[17][4]} {reg_g[17][5]} {reg_g[17][6]} {reg_g[17][7]}]]
connect_debug_port u_ila_0/probe71 [get_nets [list {reg_f[5]__0[0]} {reg_f[5]__0[1]} {reg_f[5]__0[2]} {reg_f[5]__0[3]} {reg_f[5]__0[4]} {reg_f[5]__0[5]} {reg_f[5]__0[6]} {reg_f[5]__0[7]}]]
connect_debug_port u_ila_0/probe72 [get_nets [list {reg_g[20][0]} {reg_g[20][1]} {reg_g[20][2]} {reg_g[20][3]} {reg_g[20][4]} {reg_g[20][5]} {reg_g[20][6]} {reg_g[20][7]}]]
connect_debug_port u_ila_0/probe73 [get_nets [list {reg_g[25][0]} {reg_g[25][1]} {reg_g[25][2]} {reg_g[25][3]} {reg_g[25][4]} {reg_g[25][5]} {reg_g[25][6]} {reg_g[25][7]}]]
connect_debug_port u_ila_0/probe74 [get_nets [list {reg_g[27][0]} {reg_g[27][1]} {reg_g[27][2]} {reg_g[27][3]} {reg_g[27][4]} {reg_g[27][5]} {reg_g[27][6]} {reg_g[27][7]}]]
connect_debug_port u_ila_0/probe75 [get_nets [list {reg_g[10][0]} {reg_g[10][1]} {reg_g[10][2]} {reg_g[10][3]} {reg_g[10][4]} {reg_g[10][5]} {reg_g[10][6]} {reg_g[10][7]}]]
connect_debug_port u_ila_0/probe76 [get_nets [list {reg_g[15][0]} {reg_g[15][1]} {reg_g[15][2]} {reg_g[15][3]} {reg_g[15][4]} {reg_g[15][5]} {reg_g[15][6]} {reg_g[15][7]}]]
connect_debug_port u_ila_0/probe77 [get_nets [list {reg_f[49][0]} {reg_f[49][1]} {reg_f[49][2]} {reg_f[49][3]} {reg_f[49][4]} {reg_f[49][5]} {reg_f[49][6]} {reg_f[49][7]}]]
connect_debug_port u_ila_0/probe78 [get_nets [list {reg_g[21][0]} {reg_g[21][1]} {reg_g[21][2]} {reg_g[21][3]} {reg_g[21][4]} {reg_g[21][5]} {reg_g[21][6]} {reg_g[21][7]}]]
connect_debug_port u_ila_0/probe79 [get_nets [list {reg_f[54][0]} {reg_f[54][1]} {reg_f[54][2]} {reg_f[54][3]} {reg_f[54][4]} {reg_f[54][5]} {reg_f[54][6]} {reg_f[54][7]}]]
connect_debug_port u_ila_0/probe80 [get_nets [list {reg_g[14][0]} {reg_g[14][1]} {reg_g[14][2]} {reg_g[14][3]} {reg_g[14][4]} {reg_g[14][5]} {reg_g[14][6]} {reg_g[14][7]}]]
connect_debug_port u_ila_0/probe81 [get_nets [list {reg_g[29][0]} {reg_g[29][1]} {reg_g[29][2]} {reg_g[29][3]} {reg_g[29][4]} {reg_g[29][5]} {reg_g[29][6]} {reg_g[29][7]}]]
connect_debug_port u_ila_0/probe82 [get_nets [list {reg_g[30][0]} {reg_g[30][1]} {reg_g[30][2]} {reg_g[30][3]} {reg_g[30][4]} {reg_g[30][5]} {reg_g[30][6]} {reg_g[30][7]}]]
connect_debug_port u_ila_0/probe83 [get_nets [list {reg_g[19][0]} {reg_g[19][1]} {reg_g[19][2]} {reg_g[19][3]} {reg_g[19][4]} {reg_g[19][5]} {reg_g[19][6]} {reg_g[19][7]}]]
connect_debug_port u_ila_0/probe84 [get_nets [list {reg_g[38][0]} {reg_g[38][1]} {reg_g[38][2]} {reg_g[38][3]} {reg_g[38][4]} {reg_g[38][5]} {reg_g[38][6]} {reg_g[38][7]}]]
connect_debug_port u_ila_0/probe85 [get_nets [list {reg_g[2][0]} {reg_g[2][1]} {reg_g[2][2]} {reg_g[2][3]} {reg_g[2][4]} {reg_g[2][5]} {reg_g[2][6]} {reg_g[2][7]}]]
connect_debug_port u_ila_0/probe86 [get_nets [list {reg_g[41][0]} {reg_g[41][1]} {reg_g[41][2]} {reg_g[41][3]} {reg_g[41][4]} {reg_g[41][5]} {reg_g[41][6]} {reg_g[41][7]}]]
connect_debug_port u_ila_0/probe87 [get_nets [list {reg_g[32][0]} {reg_g[32][1]} {reg_g[32][2]} {reg_g[32][3]} {reg_g[32][4]} {reg_g[32][5]} {reg_g[32][6]} {reg_g[32][7]}]]
connect_debug_port u_ila_0/probe88 [get_nets [list {reg_g[36][0]} {reg_g[36][1]} {reg_g[36][2]} {reg_g[36][3]} {reg_g[36][4]} {reg_g[36][5]} {reg_g[36][6]} {reg_g[36][7]}]]
connect_debug_port u_ila_0/probe89 [get_nets [list {reg_g[42][0]} {reg_g[42][1]} {reg_g[42][2]} {reg_g[42][3]} {reg_g[42][4]} {reg_g[42][5]} {reg_g[42][6]} {reg_g[42][7]}]]
connect_debug_port u_ila_0/probe90 [get_nets [list {reg_g[33][0]} {reg_g[33][1]} {reg_g[33][2]} {reg_g[33][3]} {reg_g[33][4]} {reg_g[33][5]} {reg_g[33][6]} {reg_g[33][7]}]]
connect_debug_port u_ila_0/probe91 [get_nets [list {reg_g[45][0]} {reg_g[45][1]} {reg_g[45][2]} {reg_g[45][3]} {reg_g[45][4]} {reg_g[45][5]} {reg_g[45][6]} {reg_g[45][7]}]]
connect_debug_port u_ila_0/probe92 [get_nets [list {reg_g[46][0]} {reg_g[46][1]} {reg_g[46][2]} {reg_g[46][3]} {reg_g[46][4]} {reg_g[46][5]} {reg_g[46][6]} {reg_g[46][7]}]]
connect_debug_port u_ila_0/probe93 [get_nets [list {reg_g[47][0]} {reg_g[47][1]} {reg_g[47][2]} {reg_g[47][3]} {reg_g[47][4]} {reg_g[47][5]} {reg_g[47][6]} {reg_g[47][7]}]]
connect_debug_port u_ila_0/probe94 [get_nets [list {reg_g[26][0]} {reg_g[26][1]} {reg_g[26][2]} {reg_g[26][3]} {reg_g[26][4]} {reg_g[26][5]} {reg_g[26][6]} {reg_g[26][7]}]]
connect_debug_port u_ila_0/probe95 [get_nets [list {reg_f[7]__0[0]} {reg_f[7]__0[1]} {reg_f[7]__0[2]} {reg_f[7]__0[3]} {reg_f[7]__0[4]} {reg_f[7]__0[5]} {reg_f[7]__0[6]} {reg_f[7]__0[7]}]]
connect_debug_port u_ila_0/probe96 [get_nets [list {reg_g[40][0]} {reg_g[40][1]} {reg_g[40][2]} {reg_g[40][3]} {reg_g[40][4]} {reg_g[40][5]} {reg_g[40][6]} {reg_g[40][7]}]]

connect_debug_port u_ila_0/probe0 [get_nets [list {f_counter[0]} {f_counter[1]} {f_counter[2]} {f_counter[3]} {f_counter[4]} {f_counter[5]} {f_counter[6]}]]
connect_debug_port u_ila_0/probe2 [get_nets [list {maxproduct[0]} {maxproduct[1]} {maxproduct[2]} {maxproduct[3]} {maxproduct[4]} {maxproduct[5]} {maxproduct[6]} {maxproduct[7]} {maxproduct[8]} {maxproduct[9]} {maxproduct[10]} {maxproduct[11]} {maxproduct[12]} {maxproduct[13]} {maxproduct[14]} {maxproduct[15]} {maxproduct[16]} {maxproduct[17]} {maxproduct[18]} {maxproduct[19]} {maxproduct[20]} {maxproduct[21]}]]
connect_debug_port u_ila_0/probe3 [get_nets [list {current_state[0]} {current_state[1]} {current_state[2]} {current_state[3]} {current_state[4]} {current_state[5]} {current_state[6]}]]
connect_debug_port u_ila_0/probe4 [get_nets [list {next_state[0]} {next_state[1]} {next_state[2]} {next_state[3]} {next_state[4]} {next_state[5]} {next_state[6]}]]
connect_debug_port u_ila_0/probe5 [get_nets [list {maxproductlocation[0]} {maxproductlocation[1]} {maxproductlocation[2]} {maxproductlocation[3]} {maxproductlocation[4]} {maxproductlocation[5]} {maxproductlocation[6]} {maxproductlocation[7]} {maxproductlocation[8]} {maxproductlocation[9]} {maxproductlocation[10]}]]
connect_debug_port u_ila_0/probe6 [get_nets [list {productfg[0]} {productfg[1]} {productfg[2]} {productfg[3]} {productfg[4]} {productfg[5]} {productfg[6]} {productfg[7]} {productfg[8]} {productfg[9]} {productfg[10]} {productfg[11]} {productfg[12]} {productfg[13]} {productfg[14]} {productfg[15]} {productfg[16]} {productfg[17]} {productfg[18]} {productfg[19]} {productfg[20]} {productfg[21]}]]
connect_debug_port u_ila_0/probe7 [get_nets [list {shift_counter[0]} {shift_counter[1]} {shift_counter[2]} {shift_counter[3]} {shift_counter[4]} {shift_counter[5]} {shift_counter[6]} {shift_counter[7]} {shift_counter[8]} {shift_counter[9]} {shift_counter[10]}]]



connect_debug_port u_ila_0/probe5 [get_nets [list ld_rst_n]]


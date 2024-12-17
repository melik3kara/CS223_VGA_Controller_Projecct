
set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports clk_100MHz]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS33} [get_ports {vgaRed[2]}]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports {vgaRed[1]}]
set_property -dict {PACKAGE_PIN N19 IOSTANDARD LVCMOS33} [get_ports {vgaRed[0]}]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {vgaBlue[1]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {vgaBlue[0]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {vgaGreen[2]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {vgaGreen[1]}]
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {vgaGreen[0]}]
set_property -dict {PACKAGE_PIN P19 IOSTANDARD LVCMOS33} [get_ports vgaHsync]
set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports vgaVsync]
set_property PACKAGE_PIN C17 [get_ports mouse_clk]
set_property IOSTANDARD LVCMOS33 [get_ports mouse_clk]
set_property PULLUP true [get_ports mouse_clk]
set_property PACKAGE_PIN B17 [get_ports mouse_data]
set_property IOSTANDARD LVCMOS33 [get_ports mouse_data]
set_property PULLUP true [get_ports mouse_data]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property PACKAGE_PIN V16 [get_ports {sw[1]}]
set_property PACKAGE_PIN W16 [get_ports {sw[2]}]
set_property PACKAGE_PIN W17 [get_ports {sw[3]}]
set_property PACKAGE_PIN W15 [get_ports {sw[4]}]
set_property PACKAGE_PIN V15 [get_ports {sw[5]}]
set_property PACKAGE_PIN W14 [get_ports {sw[6]}]
set_property PACKAGE_PIN W13 [get_ports {sw[7]}]
set_property PACKAGE_PIN T1 [get_ports {sw[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}]
set_property PACKAGE_PIN R2 [get_ports brushController]
set_property IOSTANDARD LVCMOS33 [get_ports brushController]
set_property IOSTANDARD LVCMOS33 [get_ports right_btn]
set_property IOSTANDARD LVCMOS33 [get_ports left_btn]
set_property IOSTANDARD LVCMOS33 [get_ports down_btn]
set_property IOSTANDARD LVCMOS33 [get_ports up_btn]
set_property IOSTANDARD LVCMOS33 [get_ports center_btn]
set_property PACKAGE_PIN U18 [get_ports center_btn]
set_property PACKAGE_PIN T18 [get_ports up_btn]
set_property PACKAGE_PIN U17 [get_ports down_btn]
set_property PACKAGE_PIN W19 [get_ports left_btn]
set_property PACKAGE_PIN T17 [get_ports right_btn]
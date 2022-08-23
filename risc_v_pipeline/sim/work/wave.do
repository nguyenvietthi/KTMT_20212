onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /risc_v_pipeline_tb/risc_v_pipeline_ins/clk
add wave -noupdate /risc_v_pipeline_tb/risc_v_pipeline_ins/hazrad_detect_ins/hazard_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/BrEq_i
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/BrLT_i
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/opcode_i
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/funct7_i
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/funct3_i
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/ImmSel_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/PCSel_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/BrUn_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/ASel_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/BSel_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/RegWEn_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/WBSel_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/ALUSel_o
add wave -noupdate -expand -group control /risc_v_pipeline_tb/risc_v_pipeline_ins/control_ins/insert_nop_flag_o
add wave -noupdate -expand -group DECODE -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/instruction_decode_ins/inst_i
add wave -noupdate -expand -group DECODE -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/instruction_decode_ins/rd_o
add wave -noupdate -expand -group DECODE -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/instruction_decode_ins/rs1_o
add wave -noupdate -expand -group DECODE -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/instruction_decode_ins/rs2_o
add wave -noupdate -expand -group DECODE -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/instruction_decode_ins/funct3_o
add wave -noupdate -expand -group DECODE -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/instruction_decode_ins/funct7_o
add wave -noupdate -expand -group DECODE -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/instruction_decode_ins/opcode_o
add wave -noupdate -expand -group alu /risc_v_pipeline_tb/risc_v_pipeline_ins/ALU_ins/src1
add wave -noupdate -expand -group alu /risc_v_pipeline_tb/risc_v_pipeline_ins/ALU_ins/src2
add wave -noupdate -expand -group alu /risc_v_pipeline_tb/risc_v_pipeline_ins/ALU_ins/ALU_sel
add wave -noupdate -expand -group alu /risc_v_pipeline_tb/risc_v_pipeline_ins/ALU_ins/alu_result
add wave -noupdate -expand -group alu /risc_v_pipeline_tb/risc_v_pipeline_ins/ALU_ins/zero_flag
add wave -noupdate /risc_v_pipeline_tb/risc_v_pipeline_ins/rst_n
add wave -noupdate -expand -group IF/ID /risc_v_pipeline_tb/risc_v_pipeline_ins/IF_ID_ins/inst_i
add wave -noupdate -expand -group IF/ID /risc_v_pipeline_tb/risc_v_pipeline_ins/IF_ID_ins/pc_i
add wave -noupdate -expand -group IF/ID /risc_v_pipeline_tb/risc_v_pipeline_ins/IF_ID_ins/pc_o
add wave -noupdate -expand -group IF/ID /risc_v_pipeline_tb/risc_v_pipeline_ins/IF_ID_ins/inst_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/pc_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/imm_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/RegDst_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/RegS1_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/RegS2_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/data1_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/data2_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/ASel_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/BSel_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/MemR_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/MemW_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/RegWEn_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/WBSel_o
add wave -noupdate -expand -group ID/EX /risc_v_pipeline_tb/risc_v_pipeline_ins/ID_EX_ins/ALUSel_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/pc_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/ALU_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/forward_b_data_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/RegDst_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/MemR_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/MemW_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/RegWEn_o
add wave -noupdate -expand -group EX/MEM /risc_v_pipeline_tb/risc_v_pipeline_ins/EX_MEM_ins/WBSel_o
add wave -noupdate -expand -group MEM_WB -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/MEM_WB_ins/RegDst_o
add wave -noupdate -expand -group MEM_WB -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/MEM_WB_ins/RegWEn_o
add wave -noupdate -expand -group MEM_WB -radix decimal /risc_v_pipeline_tb/risc_v_pipeline_ins/MEM_WB_ins/data_wb_o
add wave -noupdate -expand -group {Hazard dect} /risc_v_pipeline_tb/risc_v_pipeline_ins/hazrad_detect_ins/IF_IDrs1_i
add wave -noupdate -expand -group {Hazard dect} /risc_v_pipeline_tb/risc_v_pipeline_ins/hazrad_detect_ins/IF_IDrs2_i
add wave -noupdate -expand -group {Hazard dect} /risc_v_pipeline_tb/risc_v_pipeline_ins/hazrad_detect_ins/ID_EXrd_i
add wave -noupdate -expand -group {Hazard dect} /risc_v_pipeline_tb/risc_v_pipeline_ins/hazrad_detect_ins/ID_EX_MemRead_i
add wave -noupdate -expand -group {Hazard dect} /risc_v_pipeline_tb/risc_v_pipeline_ins/hazrad_detect_ins/hazard_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {184679 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {656908 ps}

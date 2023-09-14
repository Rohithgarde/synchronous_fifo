// `include "defines.sv"

class f_sequence_item extends uvm_sequence_item;

  //---------------------------------------
  //data and control fields
  //---------------------------------------
  rand bit [127:0] i_wrdata;
  rand bit i_wren;
  rand bit i_rden;
  bit o_full;
  bit o_empty;
  bit o_alm_empty;
  bit o_alm_full;
  bit [127:0] o_rddata;
  //---------------------------------------
  //Utility and Field macros
  //---------------------------------------
  `uvm_object_utils_begin(f_sequence_item)
  `uvm_field_int(i_wrdata, UVM_ALL_ON)
  `uvm_field_int(i_rden, UVM_ALL_ON)
  `uvm_field_int(i_wren, UVM_ALL_ON)
  `uvm_field_int(o_full, UVM_ALL_ON)
  `uvm_field_int(o_empty, UVM_ALL_ON)
  `uvm_field_int(o_alm_full, UVM_ALL_ON)
  `uvm_field_int(o_alm_empty, UVM_ALL_ON)
  `uvm_field_int(o_rddata, UVM_ALL_ON)
  `uvm_object_utils_end
  
    //---------------------------------------
  //Constructor
  //---------------------------------------
  function new(string name="f_sequence_item");
    super.new(name);
  endfunction

  //---------------------------------------
  //Constraint
//   ---------------------------------------
//   constraint c1{
//     {i_wren,i_rden}={2'b00,2'b01,2'b10,2'b11};
  
//   };
  constraint wr_rd2 {i_wren != i_rden;};

//   ---------------------------------------
//   Pre randomize function
 
  function void pre_randomize();
    if(i_rden)
      i_wrdata.rand_mode(0);
  endfunction



  function string convert2string();
return $psprintf("i_wrdata=%0h,o_rddata=%0h,i_wren=%0d,i_rden=%0d,o_full=%od,o_empty=%0d,o_alm_full=%0h, o_alm_empty=%0h ",i_wrdata,o_rddata,i_wren,i_rden,o_full,o_empty,o_alm_full,o_alm_empty);
  endfunction

endclass

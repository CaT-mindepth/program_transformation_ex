#include <tofino/intrinsic_metadata.p4>
#include "tofino/stateful_alu_blackbox.p4"

/* Declare Header */
header_type ethernet_t {
    fields {
        dstAddr : 48;
        srcAddr : 48;
        etherType : 16;
    }
}

header ethernet_t ethernet;

header_type ipv4_t {
    fields {
        // TODO: Have a hard limit on 5 fields for now. Ensure this in the tofino code generator.
        pkt_0 : 32 (signed);
        pkt_1 : 32 (signed);
        pkt_2 : 32 (signed);
        pkt_3 : 32 (signed);
        pkt_4 : 32 (signed);
        pkt_5 : 32 (signed);
        pkt_6 : 32 (signed);
        pkt_7 : 32 (signed);
        pkt_8 : 32 (signed);
        pkt_9 : 32 (signed);
    }
}

header ipv4_t ipv4;

/* Declare Parser */
parser start {
	return select(current(96,16)){
		0x0800: parse_ethernet;
	}
}

parser parse_ethernet {
    extract(ethernet);
    return select(latest.etherType) {
        /** Fill Whatever ***/
        0x0800     : parse_ipv4;
        default: ingress;
    }
}
parser parse_ipv4 {
    extract(ipv4);
    return ingress;
}

// TODO: Derive MAX_SIZE from Domino program.
#define MAX_SIZE 10

register reg_0 {
    width : 64;
    instance_count : MAX_SIZE;
    attributes : signed;
}

register reg_1 {
    width : 64;
    instance_count : MAX_SIZE;
    attributes : signed;
}

register reg_2 {
    width : 64;
    instance_count : MAX_SIZE;
    attributes : signed;
} 
    
// Stateful ALU blackbox
blackbox stateful_alu state_A0_blackbox {
    
    reg                       : reg_0;
    condition_lo              : ( - (register_hi)+0) != (0);
    condition_hi              : ( - (register_lo)+999) != (0);
    update_lo_1_predicate     : true;
    update_lo_1_value         : ( 1) + (register_lo);
    update_lo_2_predicate     : true;
    update_lo_2_value         : ( 1000);
    update_hi_1_predicate     : false;
    update_hi_1_value         : ( 3) + (register_hi);
    update_hi_2_predicate     : false;
    update_hi_2_value         : (1) + (0);
    output_predicate          : 1;
    output_value              : register_lo;
    output_dst                : ipv4.pkt_4;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;
}
blackbox stateful_alu state_A1_blackbox {
    
    reg                       : reg_1;
    condition_lo              : ( - (register_hi)+0) != (0);
    condition_hi              : ( - (register_lo)+999) != (0);
    update_lo_1_predicate     : true;
    update_lo_1_value         : ( 1) + (register_lo);
    update_lo_2_predicate     : true;
    update_lo_2_value         : ( 1000);
    update_hi_1_predicate     : false;
    update_hi_1_value         : ( 3) + (register_hi);
    update_hi_2_predicate     : false;
    update_hi_2_value         : (1) + (0);
    output_predicate          : 1;
    output_value              : register_lo;
    output_dst                : ipv4.pkt_5;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;
}
blackbox stateful_alu state_A2_blackbox {
    
    reg                       : reg_2;
    condition_lo              : ( - (register_hi)+0) != (0);
    condition_hi              : ( - (register_lo)+999) != (0);
    update_lo_1_predicate     : true;
    update_lo_1_value         : ( 1) + (register_lo);
    update_lo_2_predicate     : true;
    update_lo_2_value         : ( 1000);
    update_hi_1_predicate     : false;
    update_hi_1_value         : ( 3) + (register_hi);
    update_hi_2_predicate     : false;
    update_hi_2_value         : (1) + (0);
    output_predicate          : 1;
    output_value              : register_lo;
    output_dst                : ipv4.pkt_6;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;
}
blackbox stateful_alu state_A3_blackbox {
    
    reg                       : reg_0;
    condition_lo              : ( - (register_hi)+0) != (0);
    condition_hi              : ( - (register_lo)+999) != (0);
    update_lo_1_predicate     : true;
    update_lo_1_value         : ( 1) + (register_lo);
    update_lo_2_predicate     : true;
    update_lo_2_value         : ( 1000);
    update_hi_1_predicate     : false;
    update_hi_1_value         : ( 3) + (register_hi);
    update_hi_2_predicate     : false;
    update_hi_2_value         : (1) + (0);
    output_predicate          : 1;
    output_value              : register_lo;
    output_dst                : ipv4.pkt_4;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;
}
blackbox stateful_alu state_A4_blackbox {
    
    reg                       : reg_1;
    condition_lo              : ( - (register_hi)+0) != (0);
    condition_hi              : ( - (register_lo)+999) != (0);
    update_lo_1_predicate     : true;
    update_lo_1_value         : ( 1) + (register_lo);
    update_lo_2_predicate     : true;
    update_lo_2_value         : ( 1000);
    update_hi_1_predicate     : false;
    update_hi_1_value         : ( 3) + (register_hi);
    update_hi_2_predicate     : false;
    update_hi_2_value         : (1) + (0);
    output_predicate          : 1;
    output_value              : register_lo;
    output_dst                : ipv4.pkt_5;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;
}
blackbox stateful_alu state_A5_blackbox {
    
    reg                       : reg_2;
    condition_lo              : ( - (register_hi)+0) != (0);
    condition_hi              : ( - (register_lo)+999) != (0);
    update_lo_1_predicate     : true;
    update_lo_1_value         : ( 1) + (register_lo);
    update_lo_2_predicate     : true;
    update_lo_2_value         : ( 1000);
    update_hi_1_predicate     : false;
    update_hi_1_value         : ( 3) + (register_hi);
    update_hi_2_predicate     : false;
    update_hi_2_value         : (1) + (0);
    output_predicate          : 1;
    output_value              : register_lo;
    output_dst                : ipv4.pkt_6;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;
}
// Stateful ALU Action
action state_A0_action () {
    state_A0_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}
action state_A1_action () {
    state_A1_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}
action state_A2_action () {
    state_A2_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}
action state_A3_action () {
    state_A3_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}
action state_A4_action () {
    state_A4_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}
action state_A5_action () {
    state_A5_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}
// Stateful ALU table

table state_A0_table {
    actions {
        state_A0_action;
    }
    default_action: state_A0_action;
}
table state_A1_table {
    actions {
        state_A1_action;
    }
    default_action: state_A1_action;
}
table state_A2_table {
    actions {
        state_A2_action;
    }
    default_action: state_A2_action;
}
table state_A3_table {
    actions {
        state_A3_action;
    }
    default_action: state_A3_action;
}
table state_A4_table {
    actions {
        state_A4_action;
    }
    default_action: state_A4_action;
}
table state_A5_table {
    actions {
        state_A5_action;
    }
    default_action: state_A5_action;
}

action T4_action() {
    modify_field(ipv4.pkt_4, 0);
}
table T4 {
    actions {
        T4_action;
    }
    default_action: T4_action;
}

action T4_action_cp() {
    modify_field(ipv4.pkt_4, 0);
}
table T4_cp {
    actions {
        T4_action_cp;
    }
    default_action: T4_action_cp;
}

action T5_action() {
    modify_field(ipv4.pkt_5, 0);
}
table T5 {
    actions {
        T5_action;
    }
    default_action: T5_action;
}

action T5_action_cp() {
    modify_field(ipv4.pkt_5, 0);
}
table T5_cp {
    actions {
        T5_action_cp;
    }
    default_action: T5_action_cp;
}

action T6_action() {
    modify_field(ipv4.pkt_6, 0);
}
table T6 {
    actions {
        T6_action;
    }
    default_action: T6_action;
}

action T6_action_cp() {
    modify_field(ipv4.pkt_6, 0);
}
table T6_cp {
    actions {
        T6_action_cp;
    }
    default_action: T6_action_cp;
}
control ingress {
    // Call all the required ALUs.
    if (ipv4.pkt_0 == 1) {
        if (ipv4.pkt_1 == 1) {
            apply(state_A0_table);
        } else {
            apply(T4);
        }
        if (ipv4.pkt_2 == 1) {
            apply(state_A1_table);
        } else {
            apply(T5);
        }
        if (ipv4.pkt_3 == 1) {
            apply(state_A2_table);
        } else {
            apply(T6);
        }
    } else {
        if (ipv4.pkt_1 == 1) {
            apply(state_A3_table);
        } else {
            apply(T4_cp);
        }
        if (ipv4.pkt_2 == 1) {
            apply(state_A4_table);
        } else {
            apply(T5_cp);
        }
        if (ipv4.pkt_3 == 1) {
            apply(state_A5_table);
        } else {
            apply(T6_cp);
        }
    }

}
control egress {

}

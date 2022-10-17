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
        pkt_10 : 32 (signed);
        pkt_11 : 32 (signed);
        pkt_12 : 32 (signed);
        pkt_13 : 32 (signed);
        pkt_14 : 32 (signed);
        pkt_15 : 32 (signed);
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
    
action T1_action () {
    add(ipv4.pkt_4, ipv4.pkt_4, ipv4.pkt_5);
}
table T1 {
    /*
    reads {
        ipv4.pkt_1 : exact;
        ipv4.pkt_0 : exact;
    }*/
    actions {
        T1_action;
    }
}

action T2_action () {
    add(ipv4.pkt_3, ipv4.pkt_3, 1);
}
table T2 {
    /*
    reads {
        ipv4.pkt_1 : exact;
        ipv4.pkt_0 : exact;
    }*/
    actions {
        T2_action;
    }
}

action T3_action () {
    add(ipv4.pkt_6, ipv4.pkt_1, ipv4.pkt_2); // a0 = v0 + v1;
}
table T3 {
    actions {
        T3_action;
    }
}

action T4_action () {
    add(ipv4.pkt_8, ipv4.pkt_3, ipv4.pkt_4); // a2 = v2 + v3;
}
table T4 {
    actions {
        T4_action;
    }
}

action T5_action () {
    modify_field(ipv4.pkt_7, ipv4.pkt_2); // a1 = hash<<32>>(1, v1[26:0], v1[31:27]);;
}
table T5 {
    actions {
        T5_action;
    }
}

action T6_action () {
    modify_field(ipv4.pkt_9, ipv4.pkt_2); // a3 = hash<<32>>(1, v1[23:0], v1[31:24]);
}
table T6 {
    actions {
        T6_action;
    }
}

action T7_action () {
    add(ipv4.pkt_2, ipv4.pkt_6, ipv4.pkt_7); // v1 = a1 ^^ a0;
}
table T7 {
    actions {
        T7_action;
    }
}

action T8_action () {
    add(ipv4.pkt_4, ipv4.pkt_8, ipv4.pkt_9); // v3 = a3 ^^ a2;
}
table T8 {
    actions {
        T8_action;
    }
}

action T9_action () {
    modify_field(ipv4.pkt_1, ipv4.pkt_6); // v0 = hash<<32>>(1, a0[15:0], a0[31:16]);
}
table T9 {
    actions {
        T9_action;
    }
}

action T10_action () {
    modify_field(ipv4.pkt_3, ipv4.pkt_7); // v2 = a2;
}
table T10 {
    actions {
        T10_action;
    }
}

action T11_action () {
    add(ipv4.pkt_7, ipv4.pkt_1, ipv4.pkt_2); // a1 = v0 ^^ v1;
}
table T11 {
    actions {
        T11_action;
    }
}

action T12_action () {
    add(ipv4.pkt_8, ipv4.pkt_3, ipv4.pkt_4); // a2 = v2^^v3;
}
table T12 {
    actions {
        T12_action;
    }
}

action T13_action () {
    add(ipv4.pkt_9, ipv4.pkt_7, ipv4.pkt_8); // a3 = a1^^a2;
}
table T13 {
    actions {
        T13_action;
    }
}

action T14_action () {
    modify_field(ipv4.pkt_10, ipv4.pkt_9); // int hash_value=hash<<32>>(1, a3);
}
table T14 {
    actions {
        T14_action;
    }
}

action T15_action () {
    add(ipv4.pkt_11, ipv4.pkt_11, ipv4.pkt_10); // cookie_time=hash_value+cookie_time;
}
table T15 {
    actions {
        T15_action;
    }
}

control ingress {
    // Call all the required ALUs.
   if (ipv4.pkt_0 == 0 or ipv4.pkt_0 == 2 or ipv4.pkt_0 == 4 or ipv4.pkt_0 == 6) {
       apply(T1);
   } else if (ipv4.pkt_0 == 8) {
       apply(T2);
   }
   if (ipv4.pkt_0 == 12) {
       apply(T11);
       apply(T12);
       apply(T13);
       apply(T14);
       apply(T15);
   } else {
       apply(T3);
       apply(T4);
       apply(T5);
       apply(T6);
       apply(T7);
       apply(T8);
       apply(T9);
       apply(T10);
   }

}
control egress {

}

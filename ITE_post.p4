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


action A1 () {
    modify_field(ipv4.pkt_1, 1);
}

action A2 () {
    modify_field(ipv4.pkt_1, 2);
}

action A3 () {
    modify_field(ipv4.pkt_1, 3);
}

table T1 {
    reads {
        ipv4.pkt_0   : exact;
    }
    actions {
        A1;
        A2;
        A3;
    }
    size : 3;
}
control ingress {
    // Call all the required ALUs.
    apply(T1);

}
control egress {

}

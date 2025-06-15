# UVM Register Abstraction Layer (RAL)

## Introduction:
The UVM Register Model provides a way of tracking the register content of a DUT & a convenience layer for accessing register & memory locations within the DUT.

## Three discussion topics:
1. How do we model registers within our design?
a. We can model a shadow copy of the DUT registers using register model & integrate it as part of RAL into the UVM env.
b. Typically, registers(field info, rw access policy, reset value, is_acc(field accessible) etc.) are parsed in from a spreadsheet doc/tabular document by a register code generator(vendors who provide register code generators-Agnisys, AMIQ etc) & result we get is a register model (UVM class-based code) that can be integrated into UVM env containing DUT registers info.
c. uvm_reg class --> Ideally a x_reg class will extend from uvm_reg base class when defining/creating a register & its field config
d. uvm_reg_block --> A class extending from uvm_reg_block base class is an entity which is associated with a single agent & which instantiate registers, memories and creates bus maps for the registers, memories etc.
2. How do we integrate the register model within the UVM Testbench?
a. top-level reg block class (which may contain submaps of subenv reg blocks) is instantiated as register model (rm) in the top-level env class.
b.In the top-level env build-phase register model(rm - top-level reg block handle) build method is innvoked which builds the top-level reg model & also creates subenv reg models using submaps.
c. top-level env connect_phase is where regmodel is connected/integrated to reg adaptor/predictor.
d. Imp:- rm.bus_map.set_auto_predict(0) method set to 0 means explicit prediction is enabled & auto-prediction is turned off. Explicit prediction is tied to either having an explicit predictor or not having an explicit predictor. An explicit predictor hels in keeping DUT register mirrored values in step with DUT register actual values.
e. reg adapter is protocol-specific (one per agent as there is one agent per interface). Adaptor has reg2bus() & bus2reg() methods whose implementation needs to be overriden to abide by the protocol-specific functionality.
-->e.1:- The reg2bus() is used to convert generic register layer transactions (reg read/write txn) to protocol-specific transactions.
f. reg predictor is connected to agent/monitor via hierarchial analysis port TLM connection. 
3. How to access registers in the design via register model APIs?
a. DESIRED Value:- What value WE would like the register to have.
b. MIRRORED Value:- What value WE THINK the register is storing in itself. (This only gets updated by bus transactions or frontdoor reg transactions)

### More about Register Predictor:
1. Eplicit prediction:- It is the default mode of prediction that involves an explicit external predictor component that snoop for bus transactions(subscribes to analysis port of monitor/hierachical analysis port of agent) and calls the predict() method to update its mirrored register value. Since it directly interacts with bus transactions, it requires a register adapter to convert bus transactions into a register transaction. A predictor contains a handle to adaptor which helps with converting incoming bus txns (from agent/monitor via AP) into generic reg txns which then can update the mirrored values of the register in the reg model.
2. The uvm_reg_predictor component is a child class of uvm_subscriber and has an analysis implementation port capable of receiving bus sequence items from the target monitor. It uses the register adapter to convert the incoming bus packet into a generic register item and then looks up the address from the register map to find the correct register and update its contents. This is protocol independent and hence we do not need to define a custom class.

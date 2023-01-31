****************************
.inc '90nm_bulk.l'
.SUBCKT nd2 DVDD GND In1 In2 Out j
*.PININFO DVDD:I GND:I In:I Out:O
MM1 Out In1 j GND NMOS l=0.1u w=0.25u m=1
MM2 j In2 GND GND NMOS l=0.1u w=0.25u m=1
MM3 Out In1 DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM4 Out In2 DVDD DVDD PMOS l=0.1u w=0.5u m=1
.ENDS

Vdd DVDD    0   1.0
Vss GND     0   0

Vin1 In1  0   pulse (0 1.8 0 100n 100n 0.4u 1u)
Vin2 In2  0   pulse (0 1.8 0 100n 100n 0.4u 1u)

x1 DVDD GND In1 In2  Out j     nd2

.tran 10n 2.1u
.op
.option post
.end
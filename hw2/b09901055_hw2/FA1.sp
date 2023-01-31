****************************
.inc '90nm_bulk.l'
.SUBCKT fa1 DVDD GND A B CI CO X S 1 2 4 5 6 7 8 9 10 11 12

MM1 1 A DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM2 1 B DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM3 2 B 1 DVDD PMOS l=0.1u w=0.5u m=1
MM4 X A 2 DVDD PMOS l=0.1u w=0.5u m=1
MM5 X CI 1 DVDD PMOS l=0.1u w=0.5u m=1

MM6 X CI 4 GND NMOS l=0.1u w=0.25u m=1
MM7 4 A GND GND NMOS l=0.1u w=0.25u m=1
MM8 4 B GND GND NMOS l=0.1u w=0.25u m=1
MM9 X A 5 GND NMOS l=0.1u w=0.25u m=1
MM10 5 B GND GND NMOS l=0.1u w=0.25u m=1

MM11 CO X DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM12 CO X GND GND NMOS l=0.1u w=0.25u m=1

MM13 6 CI DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM14 6 A DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM15 6 B DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM16 9 X 6 DVDD PMOS l=0.1u w=0.5u m=1
MM17 7 A 6 DVDD PMOS l=0.1u w=0.5u m=1
MM18 8 B 7 DVDD PMOS l=0.1u w=0.5u m=1
MM19 9 CI 8 DVDD PMOS l=0.1u w=0.5u m=1

MM20 9 X 10 GND NMOS l=0.1u w=0.25u m=1
MM21 10 A GND GND NMOS l=0.1u w=0.25u m=1
MM22 10 B GND GND NMOS l=0.1u w=0.25u m=1
MM23 10 CI GND GND NMOS l=0.1u w=0.25u m=1
MM24 9 CI 11 GND NMOS l=0.1u w=0.25u m=1
MM25 11 A 12 GND NMOS l=0.1u w=0.25u m=1
MM26 12 B GND GND NMOS l=0.1u w=0.25u m=1

MM27 S 9 DVDD DVDD PMOS l=0.1u w=0.5u m=1
MM28 S 9 GND GND NMOS l=0.1u w=0.25u m=1

.ENDS

Vdd DVDD    0   1.0
Vss GND     0   0

Vin1 A  0   pulse (0 1.8 0 100n 100n 0.4u 1u)
Vin2 B  0   pulse (1.8 0 0 100n 100n 0.4u 1u)
Vin3 CI  0   pulse (0 1.8 0 100n 100n 0.4u 1u)

x1 DVDD GND A B CI CO X S 1 2 4 5 6 7 8 9 10 11 12     fa1

.tran 10n 2.1u
.op
.option post
.end
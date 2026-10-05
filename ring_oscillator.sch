v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N 1170 -100 1510 -100 {lab=VDD}
N 130 -100 130 -20 {lab=VDD}
N 480 -100 480 -20 {lab=VDD}
N 130 -100 480 -100 {lab=VDD}
N 1510 -100 1510 -20 {lab=VDD}
N 1170 -100 1170 -20 {lab=VDD}
N 830 -100 1170 -100 {lab=VDD}
N 830 -100 830 -20 {lab=VDD}
N 690 -100 830 -100 {lab=VDD}
N 690 -140 690 -100 {lab=VDD}
N 480 -100 690 -100 {lab=VDD}
N 1170 100 1510 100 {lab=0}
N 1510 20 1510 100 {lab=0}
N 1170 20 1170 100 {lab=0}
N 830 100 1170 100 {lab=0}
N 830 20 830 100 {lab=0}
N 690 100 830 100 {lab=0}
N 130 20 130 100 {lab=0}
N 480 20 480 100 {lab=0}
N 130 100 480 100 {lab=0}
N 690 100 690 140 {lab=0}
N 480 100 690 100 {lab=0}
N -260 -100 -260 -30 {lab=VDD}
N -260 -100 130 -100 {lab=VDD}
N -260 30 -260 100 {lab=0}
N -260 100 130 100 {lab=0}
C {/foss/designs/cmos-ring-oscillator/inverter.sym} -20 0 0 0 {name=x1}
C {/foss/designs/cmos-ring-oscillator/inverter.sym} 330 0 0 0 {name=x2}
C {/foss/designs/cmos-ring-oscillator/inverter.sym} 680 0 0 0 {name=x3}
C {/foss/designs/cmos-ring-oscillator/inverter.sym} 1020 0 0 0 {name=x4}
C {/foss/designs/cmos-ring-oscillator/inverter.sym} 1360 0 0 0 {name=x5}
C {lab_pin.sym} -170 -20 0 0 {name=p2 sig_type=std_logic lab=n5}
C {lab_pin.sym} 130 0 0 0 {name=p3 sig_type=std_logic lab=n1}
C {lab_pin.sym} 180 -20 0 0 {name=p4 sig_type=std_logic lab=n1}
C {lab_pin.sym} 480 0 0 0 {name=p5 sig_type=std_logic lab=n2}
C {lab_pin.sym} 530 -20 0 0 {name=p6 sig_type=std_logic lab=n2}
C {lab_pin.sym} 830 0 0 0 {name=p7 sig_type=std_logic lab=n3}
C {lab_pin.sym} 870 -20 0 0 {name=p8 sig_type=std_logic lab=n3}
C {lab_pin.sym} 1170 0 0 0 {name=p9 sig_type=std_logic lab=n4
}
C {lab_pin.sym} 1210 -20 0 0 {name=p10 sig_type=std_logic lab=n4
}
C {lab_pin.sym} 1510 0 0 0 {name=p11 sig_type=std_logic lab=n5}
C {vdd.sym} 690 -140 0 0 {name=l1 lab=VDD}
C {gnd.sym} 690 140 0 0 {name=l2 lab=0}
C {vsource.sym} -260 0 0 0 {name=V1 value=1.8 savecurrent=false}
C {code_shown.sym} 470 380 0 0 {name=s1 only_toplevel=false value="
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.ic v(n1)=0
.control
shell rm -f freq_vs_vdd.txt freq_vs_temp.txt

* --- Voltage sweep at 27 C ---
set temp  27
foreach vsup 1.6 1.7 1.8 1.9 2.0
	alter V1 dc = $vsup
	tran 1p 10n
	meas tran t10 trig v(n1) val='$vsup/2' rise=5 targ v(n1) val='$vsup/2' rise=15
	let freq = 10 /t10
	echo '$vsup $&freq' >> freq_vs_vdd.txt
end

* --- Temperature sweep at 1.8 V ---
alter V1 dc = 1.8
foreach tval -10 0 20 40 60 80
	set temp = $tval
	tran 1p 10n
	meas tran t10 trig v(n1) val=0.9 rise=5 targ v(n1) val=0.9 rise=15
	let freq = 10 /t10
	echo '$tval $&freq' >> freq_vs_temp.txt
end

echo 'Done'
shell cat freq_vs_vdd.txt freq_vs_temp.txt
.endc
"}

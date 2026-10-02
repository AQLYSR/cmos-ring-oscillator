v {xschem version=3.4.8RC file_version=1.3}
G {}
K {}
V {}
S {}
F {}
E {}
N -10 -20 -10 0 {lab=OUT}
N -60 30 -50 30 {lab=IN}
N -60 -10 -60 30 {lab=IN}
N -60 -50 -50 -50 {lab=IN}
N -10 -90 -10 -80 {lab=VDD}
N -10 -90 40 -90 {lab=VDD}
N -10 -110 -10 -90 {lab=VDD}
N 40 -90 40 -50 {lab=VDD}
N -10 -50 40 -50 {lab=VDD}
N -10 70 -10 80 {lab=0}
N -130 -10 -60 -10 {lab=IN}
N -60 -50 -60 -10 {lab=IN}
N -130 50 -130 70 {lab=0}
N -130 70 -10 70 {lab=0}
N -10 60 -10 70 {lab=0}
N -10 70 40 70 {lab=0}
N 40 30 40 70 {lab=0}
N -10 30 40 30 {lab=0}
N 100 -90 100 -50 {lab=VDD}
N 40 -90 100 -90 {lab=VDD}
N 100 10 100 70 {lab=0}
N 40 70 100 70 {lab=0}
C {/foss/pdks/sky130A/libs.tech/xschem/sky130_fd_pr/pfet_01v8.sym} -30 -50 0 0 {name=M1
W=1
L=0.15
nf=1
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {/foss/pdks/sky130A/libs.tech/xschem/sky130_fd_pr/nfet_01v8.sym} -30 30 0 0 {name=M2
W=1
L=0.15
nf=1 
mult=1
ad="expr('int((@nf + 1)/2) * @W / @nf * 0.29')"
pd="expr('2*int((@nf + 1)/2) * (@W / @nf + 0.29)')"
as="expr('int((@nf + 2)/2) * @W / @nf * 0.29')"
ps="expr('2*int((@nf + 2)/2) * (@W / @nf + 0.29)')"
nrd="expr('0.29 / @W ')" nrs="expr('0.29 / @W ')"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {vdd.sym} -10 -110 0 0 {name=l1 lab=VDD}
C {gnd.sym} -10 80 0 0 {name=l2 lab=0}
C {vsource.sym} -130 20 0 0 {name=V1 value=0 savecurrent=false}
C {vsource.sym} 100 -20 0 0 {name=V2 value=1.8 savecurrent=false}
C {lab_pin.sym} -130 -10 0 0 {name=p1 sig_type=std_logic lab=IN
}
C {lab_pin.sym} -10 -10 0 0 {name=p2 sig_type=std_logic lab=OUT}

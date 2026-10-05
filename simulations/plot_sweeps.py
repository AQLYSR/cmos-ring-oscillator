import numpy as np
import matplotlib.pyplot as plt

v, fv = np.loadtxt("freq_vs_vdd_ff.txt", unpack=True)
t, ft = np.loadtxt("freq_vs_temp_ff.txt", unpack=True)

fig, ax = plt.subplots(1, 2, figsize=(10, 4))
ax[0].plot(v, fv / 1e9, "o-")
ax[0].set(xlabel="Supply voltage (V)", ylabel="Frequency (GHz)",
          title="Frequency vs VDD (27 °C, ff)")
ax[1].plot(t, ft / 1e9, "o-", color="tab:red")
ax[1].set(xlabel="Temperature (°C)", ylabel="Frequency (GHz)",
          title="Frequency vs temperature (1.8 V, ff)")
for a in ax:
    a.grid(True)
plt.tight_layout()
plt.savefig("sweeps_ff.png", dpi=150)

# Code Updates for `run_kilosort4.py`

This document outlines the recent changes made to the `run_kilosort4.py` script.
The `run_kilosort4.py` file is located in `~/Documents/Development/MEA/src/utilities`. 
---

## 1. Configure `run_kilosort4.py`

### Update to the Import Path

To ensure the correct module path is included, add the following code **before** `import config as cfg`:

```python
import sys
# Get the absolute path to the directory containing your module
module_path = os.path.expanduser('~/Documents/Development/MEA/src/analysis/config')
# Add the module path to sys.path
sys.path.append(module_path)
```

This change ensures that the configuration module can be located and imported successfully.

---

## 2. Modify the `run_kilosort` Function Call

In the same file, the function call to `run_kilosort` has been updated to **remove the `kept_spikes` variable** from the returned values. The updated code is as follows:

```python
ops, st, clu, tF, Wall, similar_templates, is_ref, est_contam_rate = \
    run_kilosort(settings=settings, 
                 probe=probe,
                 filename=bin_path,
                 results_dir=results_path,
                 data_dtype='int16',  # Check the data type
                 device=torch.device(device),  # Example: device = torch.device('cuda:1')
                 invert_sign=True,  # Invert the sign of the data as expected by kilosort4 (was False)
                 do_CAR=use_car,
                 save_extra_vars=False)
```

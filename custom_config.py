import os
# circuit 
#DATA_VOLUME = '/mnt/lab/Array-data'


# NAS_PATH = '/mnt/FieldLab/Array-data/'
# Wagner
DATA_VOLUME ='/media/kais/Kais/data'

print("Checking Data_Volume directory",DATA_VOLUME,'Exists', os.path.exists(DATA_VOLUME))

# This provides the custom path to my data files.
if os.path.exists(DATA_VOLUME):
    JSON_PATH = os.path.join(DATA_VOLUME, 'metadata/json/')
    SORT_PATH = os.path.join(DATA_VOLUME, 'sorted/')
# elif os.path.exists(NAS_PATH): # Look for the NAS array mounted to the computer
#     JSON_PATH = os.path.join(NAS_PATH, 'data','metadata','json')
#     SORT_PATH = os.path.join(NAS_PATH, 'data','sorted')
else:
    # Warn the user that the data drive is not connected.
    print('Warning!! Cannot find path to data on ' + DATA_VOLUME)
    JSON_PATH = ''
    SORT_PATH = ''

print("JSON_PATH",JSON_PATH)
print('Sort_PATH',SORT_PATH)

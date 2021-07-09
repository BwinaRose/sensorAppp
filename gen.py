def read_data_files_gen(filename):
    filename = '/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog/' + filename
    with open(filename, 'r') as f:
        for line in f:
        #text = f.read()
            yield line

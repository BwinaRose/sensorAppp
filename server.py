import os
from bottle import route, request, run, template, post, static_file


@route('/')
def root():
    return template('sensorApp.tpl', root='.')


@route('/datafiles')
def get_data_files():
    path = '/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog'
    listdirs = os.listdir(path)
    return template('data_files', listdirs=listdirs)


# @route('/datafiles', method="POST")
# def read_data_files():
#     filename = request.forms.get('filename')
#     filename = '/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog/' + filename
#     f = open(filename, 'r')
#     text = f.readline()
#     return text

@route('/datafiles/<filename>')
def read_data_files(filename):
    filename = '/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog/' + filename
    with open(filename, 'r') as f:
        text = f.read()
    return text

@route('/livedata/<filename>')
def read_data_files_gen(filename):
    filename = '/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog/' + filename
    with open(filename, 'r') as f:
        for line in f:
        #text = f.read()
            yield line
    #return text




if __name__ == '__main__':
    run(host='localhost', port=8080)

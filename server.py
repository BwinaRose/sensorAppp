import os, sys
from bottle import route, request, run, template, post, static_file


dirname = os.path.dirname(sys.argv[0])

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

@route('/static/<jsfile>')
def send_javascript(jsfile):
    return static_file(filename=jsfile, root='./static')


@route('/static/<filename:re:.*\.css>')
def send_css(filename):
    return static_file(filename, root=dirname+'/static')

@route('/static/<filename:re:.*\.js>')
def send_js(filename):
    return static_file(filename, root=dirname+'/static')


# @route('/livedata')
# def read_live_data():
#     return template('live_data')
#
# @route('/livedata/<filename>')
# def read_data_files_gen(filename):
#     filename = '/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog/' + filename
#     with open(filename, 'r') as f:
#         for line in f:
#         #text = f.read()
#             yield line
#          return text




if __name__ == '__main__':
    run(reloader=True, debug=True, host='localhost', port=8080)

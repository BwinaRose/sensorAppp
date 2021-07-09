def dataGen(n):
    import random
    import os
    import time


    filename = '/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog/'
    filename += time.strftime('%d-%m-%Y.csv')
    x = os.path.exists('/Users/srkrueger19@students.desu.edu/Desktop/sensorAppp/DataLog/'+time.strftime('%d-%m-%Y.csv'))
    if x == False:
        with open (filename,"w") as outfile:
            outfile.write('time,pm1,pm2,pm10\n')
    outfile = open(filename, "a")
    for count in range(n):
        num1 = random.randint(0, 20)
        num2 = random.randint(0, 20)
        num3 = random.randint(0, 20)
        outfile.write(str(time.strftime('%H:%M:%S')+','))
        outfile.write(str(num1)+',')
        outfile.write(str(num2)+',')
        outfile.write(str(num3)+'\n')
        time.sleep(1)
        outfile.flush()
    outfile.close()

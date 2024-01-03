# coding: utf-8
import sys, os
from robot.api import ExecutionResult
from datetime import datetime
import json
import socket

def get_info (kw, host, suite, type):
    line = None
    try:
        args = kw.args
    except:
        args = None
    params=""
    if args != None:
        for arg in args:
            params += "|" + arg
    dt_start = datetime.strptime(kw.starttime, '%Y%m%d %H:%M:%S.%f')
    dt_end = datetime.strptime(kw.endtime, '%Y%m%d %H:%M:%S.%f')
    time_difference = dt_end - dt_start
    difference_in_milliseconds = int(time_difference.total_seconds() * 1000)
    dt_start = str(dt_start).replace(' ', 'T')
    dt_start = dt_start[:len(dt_start) - 7] + '+01:00'
    if kw.name is not None:
        line = {"host": host, "suite": suite, "type": type, "action": kw.name + params, "start": dt_start,
            "duration": difference_in_milliseconds, "status": kw.status}
    return (line)

def main (argv, arc):
    result = ExecutionResult(argv[1])
    start = result.suite.starttime[0:8]
    output = argv[2] + '/' + result.suite.name.replace(' ', '_') +  '_' + start + '.log'
    if not os.path.exists(argv[2]):
        os.makedirs(argv[2])
    res = open(output, 'a')
    for tc in result.suite.tests:
        line = get_info(tc, socket.gethostname(), result.suite.name, "testcase")
        if line is None:
            continue
        res.write(json.dumps(line) + '\n')
        # print(line)
        for kw in tc.body:
            line = get_info(kw, socket.gethostname(), result.suite.name, "keyword")
            if line is None:
                continue
            res.write(json.dumps(line) + '\n')
            # print(line)
            for act in kw.body:
                if act.type !='MESSAGE':
                    line = get_info(act, socket.gethostname(), result.suite.name, "step")
                    if line is None:
                        continue
                    res.write(json.dumps(line) + '\n')
                    # print(line)
    res.close()
    print (output)
if __name__ == '__main__':
    main(sys.argv, len(sys.argv))
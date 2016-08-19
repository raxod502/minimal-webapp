#!/usr/bin/env python3

from multiprocessing import Process, Queue
from subprocess import run, PIPE, Popen
import sys

def run_verbosely(command, *args, **kwargs):
    print('$ ' + ' '.join(command))
    return run(command, *args, **kwargs)

def Popen_verbosely(command, *args, **kwargs):
    print('$ ' + ' '.join(command))
    return Popen(command, *args, **kwargs)

def wait_for_output(process, output, timeout=None):
    def job():
        while True:
            line = process.stdout.readline().decode('utf-8')
            print(line, end='')
            if output in line:
                queue.put(True)
                return
            elif not line:
                queue.put(False)
                return
    queue = Queue()
    thread = Process(target=job)
    thread.start()
    if timeout is not None:
        thread.join(timeout)
        if thread.is_alive():
            thread.terminate()
            return False
    else:
        thread.join()
    return queue.get()

def is_webpage_correct(port):
    html = run_verbosely(
        ['phantomjs', 'get_html.js', 'http://localhost:' + str(port)],
        stdout=PIPE).stdout.decode(sys.stdout.encoding)
    return 'Hello from Reagent' in html

def uberjar_test():
    print('--> Running from uberjar')

    run_verbosely(
        ['lein', 'do', 'clean,', 'uberjar'])
    try:
        server = Popen_verbosely(
            ['java', '-jar', '../target/minimal-webapp-standalone.jar'],
            stdout=PIPE)
        if not wait_for_output(server, 'Started server', timeout=10):
            return False
        return is_webpage_correct(5000)
    finally:
        print('* Killing server')
        server.kill()

def figwheel_sidecar_test():
    print('--> Running from Figwheel Sidecar')

    try:
        repl = Popen_verbosely(
            ['lein', 'do', 'clean,', 'repl'])
        repl.stdin.write("(use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl)")
        wait_for_output(repl, 'Prompt will show when Figwheel connects')
    finally:
        print('* Killing REPL')
        repl.kill()

if __name__ == '__main__':
    #assert uberjar_test()
    assert figwheel_sidecar_test()

import os
import subprocess


def which(program):

    def is_exe(fpath):
        return os.path.isfile(fpath) and os.access(fpath, os.X_OK)
    
    fpath, fname = os.path.split(program)
    if fpath:
        if is_exe(program):
            return program
    else:
        for path in os.environ["PATH"].split(os.pathsep):
            exe_file = os.path.join(path, program)
            if is_exe(exe_file):
                return exe_file
    
    return None



check_git = which('git')
if check_git == None:
  x = 'a none'
else:
  try:
    x = subprocess.check_output("git log -1",shell=True)
  except:
    x = 'a none'
  

sha = x.split("\n")[0].split(" ")[1]

f = open('resources/gitcommit.txt','w')

f.write(sha)
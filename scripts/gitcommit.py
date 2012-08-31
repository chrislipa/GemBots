import os
import subprocess

x = subprocess.check_output("git log -1",shell=True)

sha = x.split("\n")[0].split(" ")[1]

f = open('resources/gitcommit.txt','w')

f.write(sha)
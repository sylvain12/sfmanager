import subprocess

# print(subprocess.run(["ls", "-l"], capture_output=True).stdout.decode())
# print("#" * 20)
# print(subprocess.run(["ls", "-l", "/usr/src"], capture_output=True).stdout.decode())
# print("#" * 20)
print(subprocess.run(["ls", "-l", "/usr/local/"], capture_output=True).stdout.decode())
print(subprocess.run(["echo", "$PATH"], capture_output=True).stdout.decode())
# print(subprocess.run(["uname", "-or"], capture_output=True).stdout.decode())

# print(subprocess.run(["sf", "--version"], capture_output=True).stdout.decode())

import subprocess

print(subprocess.run(["ls", "-al"], capture_output=True).stdout.decode())
print("#" * 40)
print(subprocess.run(["ls", "-l", "app"], capture_output=True).stdout.decode())
print("#" * 40)
print(subprocess.run(["ls", "-l", "cli"], capture_output=True).stdout.decode())
print("#" * 40)
print(subprocess.run(["sf", "--version"], capture_output=True).stdout.decode())

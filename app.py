import subprocess

import os

# print(subprocess.run(["ls", "/usr/local/sf/bin"], capture_output=True).stdout.decode())
# print(
#     subprocess.run(
#         ["ls", "-dall", "/usr/local/sf/bin/sf"], capture_output=True
#     ).stdout.decode()
# )

# print(subprocess.run(["sf", "--version"], capture_output=True).stdout.decode())

# print(subprocess.run(["sfdx", "version"], capture_output=True).stdout.decode())

env = os.environ.copy()

# print(subprocess.run(["sf", "version"], capture_output=True).stdout.decode())
# print(subprocess.run(["sfdx", "version"], capture_output=True).stdout.decode())
print(subprocess.run(["echo", env["PATH"]], capture_output=True).stdout.decode())
print(subprocess.run(["sfdx", "version"], capture_output=True).stdout.decode())
print(subprocess.run(["sf"], capture_output=True).stdout.decode())

import os
import subprocess

class terminalColors:
    WARNING = '\033[93m'
    INFO = '\033[94m'
    END_COLOR = '\033[0m'

# first of all, jump into this directory no matter where we actually started this script
script_path = os.path.abspath(__file__)
script_directory = os.path.dirname(script_path)
os.chdir(script_directory)
# now jump to the root directory of the repository
os.chdir('..')

# Windows requires the shell=True option on subprocesses that use the 'flutter' or 'dart' commands with arguments.
requireShellFlag = os.name == 'nt'

# Run initialization steps
# initialize

# misc_utils
os.chdir('./packages/misc_utils')
subprocess.run(['flutter', 'pub', 'get'], check=True, shell=requireShellFlag)
subprocess.run(['dart', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'], check=True, shell=requireShellFlag)
os.chdir('../..')

# theming
os.chdir('./packages/theming')
subprocess.run(['flutter', 'pub', 'get'], check=True, shell=requireShellFlag)
subprocess.run(['dart', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'], check=True, shell=requireShellFlag)
os.chdir('../..')

# pile_of_shame
subprocess.run(['flutter', 'pub', 'get'], check=True, shell=requireShellFlag)
subprocess.run(['dart', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'], check=True, shell=requireShellFlag)
subprocess.run(['flutter', 'gen-l10n'], check=True, shell=requireShellFlag)

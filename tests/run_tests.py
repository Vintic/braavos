"""
Development usage examples (from /westeros root):

All tests:
`python3 tests/run_tests.py`

Selected package:
`python3 tests/run_tests.py -p unit.helpers.string`

On explicit server:
`python3 tests/run_tests.py -p unit.helpers.string -s "see-eye.elasticbeanstalk.com"`

--h www.westeros.dv

optional arguments:
    -h, --help          show this help message and exit
    -s SERVER, --server SERVER server on which to run tests. (Default: www.westeros.dv)
    -p PACKAGES, --packages PACKAGES dot notated package to run. (Eg: unit.helpers.string)
"""

import argparse
import datetime
import os

import requests

current_dir = os.path.abspath('.')
tests_dir =  os.path.join(current_dir, 'tests')
build_report_dir = os.path.join(current_dir, 'build-report')
cfc_extension = ".cfc"
is_database_seeded = False
failed_packages = []

# process optional arguments
parser = argparse.ArgumentParser()
parser.add_argument("-s", "--server", help="server on which to run tests. (Default: see-eye.elasticbeanstalk.com)")
parser.add_argument("-p", "--packages", help="dot notated package to run. (Eg: unit.helpers.string)")
args = parser.parse_args()

server = 'www.westeros.dv'
if args.server:
    server = args.server

packages = ['unit', 'requests']
if args.packages:
    packages = args.packages.split()


# returns an array of dot notated test package names
def get_test_packages(package):
    package_path = tests_dir
    for directory in package.split('.'):
        package_path = os.path.join(package_path, directory)

    packages = []
    for dirpath, dirnames, files in os.walk(package_path):
        dirnames.sort()
        for name in files:
            if name.lower().endswith(cfc_extension):
                package_full_path = os.path.join(dirpath, name)
                package_name = convert_path_to_package_name(package_full_path)
                packages.append(package_name)
    return packages


def convert_path_to_package_name(path):
    name = path.replace(cfc_extension, '')
    name = name.replace(os.path.abspath(tests_dir), '')
    # hack-o-rama
    name = name.replace('\\\\', '.')
    name = name.replace('\\', '.')
    name = name.replace('/', '.')
    name = name.replace('.', '.')  # strip leading .
    name = name.replace('.', '', 1)
    return name


def get_base_url(server):
    return f'http://{server}/junify/app'


def get_package_url(server, package_name):
    return f'{get_base_url(server)}?package={package_name}'


def is_skipped(package_name):
    if package_name.lower().endswith("_skip"):
        return True
    return False


def run_all_test_packages(base_package_name):
    for package in get_test_packages(base_package_name):
        global is_database_seeded
        seed_database = False
        if is_database_seeded is False:
            seed_database = True
            is_database_seeded = True
        run_single_test_package(package, seed_database)


def run_single_test_package(package_name, seed):
    if is_skipped(package_name):
        print(f'SKIP... {package_name} ...')
    else:
        junit_file = os.path.join(build_report_dir, f'test-result-{package_name.lower()}.xml')
        package_url = get_package_url(server, package_name)
        if seed is True:
            package_url = f'{package_url}&seed=true'
            print('Seeding database...')

        response = requests.get(package_url)

        with open(junit_file, 'w') as f:
            f.write(response.text)

        if response.status_code is 200:
            print(f'Pass: {package_name}')
        else:
            print(f'__FAIL__: {package_name} !!!')
            failed_packages.append(package_name)


def date_format(date):
    return date.strftime("%d-%B-%Y %H:%M:%S")


start_time = datetime.datetime.now()
print(f'Started {date_format(start_time)}')
print(f'Using endpoint {get_base_url(server)}?package=test.package.name')

if not os.path.exists(build_report_dir):
    os.makedirs(build_report_dir)

for package in packages:
    run_all_test_packages(package)

failed_package_count = len(failed_packages)
if failed_package_count:
    print('\n')
    print('-'*20)
    print(f'{failed_package_count} FAILED PACKAGES')
    print('-'*20)
    for package in failed_packages:
        print(f'- {package}')
    print('\n')

end_time = datetime.datetime.now()
delta = end_time - start_time
seconds = int(delta.total_seconds())
print(f'Finished {date_format(end_time)} (Took {seconds} seconds)')

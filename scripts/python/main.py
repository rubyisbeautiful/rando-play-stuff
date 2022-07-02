import argparse
import collections
import sys


def print_results(data: list) -> int:
    """prints results in pythonic way"""
    c = collections.Counter(data)
    print(c)
    return 0


def parse_log(filename: str) -> list:
    """parses log file with minimal error handling, w/o regard
    for size/mem/performance/security"""
    data = []
    try:
        with open(filename, 'r') as f:
            ip = None
            for line in f:
                try:
                    # not very tolerant of errors / weird lines
                    ip = (line.split(' /')[0]).split()[-1]
                except Exception:
                    print('skipping bad line')
                    continue
                if not ip:
                    print('no ip detected')
                    continue
                data.append(ip)
    except Exception as err:
        print(f'unexpected error in parse_log\n{err}')
        raise err
    return data


def main() -> int:
    """main program function"""
    try:
        parser = argparse.ArgumentParser(description='log parser')
        parser.add_argument('--file', required=True, help='log file')
        args = parser.parse_args()
    except Exception as err:
        print(err)
        return 1
    return print_results(parse_log(args.file))


if __name__ == "__main__":
    sys.exit(main())

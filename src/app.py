#!/usr/bin/env python3
"""
Module Main
"""

__author__ = "Name Surname"
__version__ = "1.0"
__license__ = "The Unlicense"

import argparse
import logging

logging.basicConfig(
    format="%(asctime)s %(threadName)-2s %(levelname)s: %(message)s",
    level=logging.INFO,
    handlers=[
        logging.StreamHandler(),
    ],
)

""" dummy hello world function (used also in tests) """


def hello_world():
    return "hello world"


def main(args):
    """Main entry point of the app"""
    logging.info(f"running main with args: {args}")
    print(hello_world())


if __name__ == "__main__":
    """This is executed when run from the command line"""
    parser = argparse.ArgumentParser()

    # Required positional argument
    # parser.add_argument("arg", help="Required positional argument")

    # Optional argument flag which defaults to False
    # parser.add_argument("-f", "--flag", action="store_true", default=False)

    # Optional argument which requires a parameter (eg. -d test)
    # parser.add_argument("-n", "--name", action="store", dest="name")

    # Optional verbosity counter (eg. -v, -vv, -vvv, etc.)
    # parser.add_argument("-v", "--verbose", action="count", default=0, help="Verbosity (-v, -vv, etc)")

    # Specify output of "--version"
    parser.add_argument("--version", action="version", version="%(prog)s (version {version})".format(version=__version__))

    args = parser.parse_args()
    main(args)

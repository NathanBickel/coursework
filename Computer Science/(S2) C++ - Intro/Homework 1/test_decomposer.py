#!/usr/bin/env python3
"""Module documentation goes here
"""

import string
import subprocess
import sys

class TestDecomposer:
    """Q & D class to test a student app.
    """
    def __init__(self, test_no):
        self._app = "./base_decomposer"  # name of child proc
        self._test_no = test_no  # mapping to test info below
        self._input = ["12345", "-12345"]  # test input for child proc
        self._expected = [  # expected output from child proc
            "10000 + 2000 + 300 + 40 + 5",
            "-(10000 + 2000 + 300 + 40 + 5)"]

        self.test()


    def test(self):
        """Method is called by constructor. It is public, but should not need be
        called explicitly.
        """
        returncode, actual = self._run()

        # remove all non-printable characters
        actual = "".join(filter(lambda x: x in string.printable, actual))

        if returncode != 0:
            print(
                "ERROR: EXPECTED return 0, ACTUAL return {}".format(returncode),
                file=sys.stderr)

        if not actual:
            print("ERROR: No output from student app.", file=sys.stderr)
            sys.exit(1)

        print("STUDENT OUTPUT")
        print("\t----------------------------------")
        print(f"\t  {actual}")  # this is known as an fstring
        print("\t----------------------------------")

        if actual == self._expected[self._test_no]:
            print("CORRECT!")
        else:
            print("INCORRECT...")
            print(f"  Expected:\t{self._expected[self._test_no]}")
            print(f"  Actual:\t{actual}")
            sys.exit(1)


    def _run(self):
        """Does the actual work of running the tested app. Called by test method
        and returns the exit code of app and anything in STDOUT.
        """
        with subprocess.Popen(
                self._app, stderr=subprocess.PIPE,
                stdin=subprocess.PIPE, stdout=subprocess.PIPE) as proc:
            out, _ = proc.communicate(
                input=self._input[self._test_no].encode("utf-8"))

            try:
                return proc.returncode, out.decode("utf-8") if out else None
            except UnicodeDecodeError as decode_exception:
                return proc.returncode, \
                       "Serious execution badness: {}".format(decode_exception)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("USAGE: test_parse_grades.py [1 | 2] to run tests 1 or 2")
    else:
        TestDecomposer(int(sys.argv[1]) - 1)

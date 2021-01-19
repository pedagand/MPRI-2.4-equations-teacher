#!/bin/sh

FILENAME=$1

dune runtest &>/dev/null

echo "Selectively run tests for $FILENAME"
./_build/default/examples/.examples.inline-tests/inline_test_runner_examples.exe    \
    inline-test-runner                                                              \
    examples                                                                        \
    -source-tree-root ..                                                            \
    -only-test $1
if [ $? -eq 0 ]; then
    echo "OK"
fi

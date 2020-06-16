#!/bin/bash

cd ..
echo '############################### Cleaning stuff ###############################'
flutter clean
echo '############################### Running tests ################################'
flutter test --coverage
echo '############################### Generating coverage ##########################'
genhtml coverage/lcov.info -o coverage/html

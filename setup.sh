#!/bin/bash

function command_exists {
  command -v "$1" > /dev/null;
}

# cocoaPods
if ! command_exists rbenv ; then
  brew install rbenv
  brew install ruby-build
  rbenv --version
  rbenv install -l
  ruby_latest=$(rbenv install -l | grep -v '[a-z]' | tail -1 | sed 's/ //g')
  rbenv install $ruby_latest
  rbenv local $ruby_latest
  rbenv rehash
  ruby -v
fi

# SwiftLint
if ! command_exists swiftlint ; then
  brew install swiftlint
fi

# SwiftGen
if ! command_exists swiftgen ; then
  brew install swiftgen
fi

# Bundler
if ! command_exists bundler ; then
  gem install bundler
fi

bundle install --path=vendor/bundle
bundle exec pod repo update
bundle exec pod install

# View build time setting
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# Compile num setting
cores=$(system_profiler SPHardwareDataType | grep 'Total Number of Cores:' | sed -e 's/.*Cores: \([0-9]*\).*/\1/')
defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks `expr $cores \* 2`

# Tuning Xcode
git clone git@github.com:AkkeyLab/TuningXcode.git
mv TuningXcode/TuningXcode.app ./
rm -rf TuningXcode


#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-

# Non-Windows-specific tests
# Copyright © 2014-2017  Basil Peace

# This file is part of FIDATA Build Environment.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# 	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

control 'non-windows' do
  impact 1.0
  title 'Non-Windows-specific tests'
  desc 'Additional requirements for all platforms except Windows'
  only_if do
    !os.windows?
  end

  describe command('gcc') do
    it { should exist }
  end
  describe command('gcc --version') do
    its('exit_status') { should eq 0 }
  end
  describe command('g++') do
    it { should exist }
  end
  describe command_output('g++ --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^g\+\+ \(.*\) (\d+\.\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 4.7' }
  end
  describe command('gmake') do
    it { should exist }
  end
  describe command('gmake --version') do
    its('exit_status') { should eq 0 }
  end
  describe command_output('gmake --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^GNU Make (\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 3.80' }
  end

  describe command('gfortran') do
    it { should exist }
  end
  describe command('gfortran --version') do
    its('exit_status') { should eq 0 }
  end

  # Until https://github.com/chef/inspec/issues/1418 is fixed
  # we run this test for non-windows only
  describe command_output('diff --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^diff \(GNU diffutils\) (\d+\.\d+(\.\d+)?(-\w)?)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '> 0' }
  end
end

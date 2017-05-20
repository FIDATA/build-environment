#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-

# Linux-specific tests
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

control 'linux' do
  impact 1.0
  title 'Linux tests'
  desc 'Additional requirements for Linux'
  only_if do
    os.linux?
  end

  describe command('make') do
    it { should exist }
  end
  describe command('make --version') do
    its('exit_status') { should eq 0 }
  end
  describe command_output('make --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^GNU Make (\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 3.80' }
  end
end

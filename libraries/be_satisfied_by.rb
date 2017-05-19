#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-

# be_satisfied_by custom rspec matcher
# Copyright © 2017  Basil Peace

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

require 'rspec'
require 'semverse'

RSpec::Matchers.define :be_satisfied_by do |constraint|
  match do |actual|
    begin
      version = Semverse::Version.new(actual.parsed_output)
    rescue
      return false
    end
    Semverse::Constraint.new(constraint).satisfies?(version)
  end

  failure_message do |actual|
    "expected that stdout\n\n#{actual.stdout.rstrip}\n\nand stderr\n\n#{actual.stderr.rstrip}\n\nwhen parsed would be satisfied by #{constraint}"
  end
end

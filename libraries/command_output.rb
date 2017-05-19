#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-

# command_output custom inspec resource
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

# Custom inspec resource for parsed command output
class CommandOutput < Inspec.resource(1)
  name 'command_output'
  attr_reader :parser

  def initialize(cmd, parsed_with:)
    @command = cmd
    @parser = parsed_with
  end

  def result
    @result ||= inspec.backend.run_command(@command)
  end

  def stdout
    result.stdout
  end

  def stderr
    result.stderr
  end

  def parsed_output
    parser.call(stdout, stderr)
  end

  def to_s
    "Output of `#{@command}`"
  end
end

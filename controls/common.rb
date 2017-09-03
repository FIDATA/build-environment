#!/usr/bin/env ruby
# -*- coding: UTF-8 -*-

# Common tests
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

control 'common' do
  impact 1.0
  title 'Common tests'
  desc 'Requirements for all platforms'

  describe os_env('JAVA_HOME') do
    its('content') { should_not eq '' }
    its('content') { should_not eq nil }
  end

  describe command('java') do
    it { should exist }
  end
  # See http://www.oracle.com/technetwork/java/javase/versioning-naming-139433.html
  describe command_output('java -version', parsed_with: lambda { |_stdout, stderr|
    return stderr[/^.*version "1\.(\d+\.\d+(_\d+)?(-\w+)?)"/, 1].sub('_', '.')
  }) do
    it { is_expected.to be_satisfied_by '>= 7.0' }
  end
  # Test for JDK
  describe command_output('javac -version', parsed_with: lambda { |_stdout, stderr|
    return stderr[/^javac 1\.(\d+\.\d+(_\d+)?(-\w+)?)/, 1].sub('_', '.')
  }) do
    it { is_expected.to be_satisfied_by '>= 7.0' }
  end

  describe command('git') do
    it { should exist }
  end
  describe command_output('git --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^git version (\d+\.\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 1.6' }
  end

  describe command('diff') do
    it { should exist }
  end

  describe command('gperf') do
    it { should exist }
  end
  describe command('gperf --version') do
    its('exit_status') { should eq 0 }
  end

  describe command('cmake') do
    it { should exist }
  end
  describe command_output('cmake --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^cmake version (\d+\.\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 3.9' }
  end

  describe command('ruby') do
    it { should exist }
  end
  describe command_output('ruby --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^ruby (\d+\.\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 2' }
  end
  describe command('bundle') do
    it { should exist }
  end
  describe command_output('bundle --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^Bundler version (\d+\.\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 1.14' }
  end
  describe os_env('GEM_HOME') do
    its('content') { should_not be_empty }
  end
  GEM_HOME = os_env('GEM_HOME').content
  unless GEM_HOME.to_s.empty?
    describe directory(GEM_HOME) do
      it { should exist }
    end
  end

  describe command('perl') do
    it { should exist }
  end
  describe command_output('perl --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^This is perl.*\(v(\d+\.\d+\.\d+)\)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 5.14' }
  end

  describe command('pandoc') do
    it { should exist }
  end
  describe command_output('pandoc --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^pandoc(\.exe)? (\d+\.\d+\.\d+)/, 2]
  }) do
    it { is_expected.to be_satisfied_by '> 0' }
  end

  describe command('lualatex') do
    it { should exist }
  end
  describe command_output('lualatex --version', parsed_with: lambda { |stdout, _stderr|
    m = stdout.match(/^This is LuaTeX, Version ((\w+)-)?(\d+\.\d+\.\d+)/)
    return m[3] + (m[2].nil? ? '' : '-' + m[2])
  }) do
    it { is_expected.to be_satisfied_by '> 0' }
  end
  describe command('makeindex') do
    it { should exist }
  end
  describe command('bibtex') do
    it { should exist }
  end
  describe command_output('bibtex --version', parsed_with: lambda { |stdout, _stderr|
    m = stdout.match(/^BibTeX (\d+\.\d+)(\w+)/)
    return "#{m[1]}.0-#{m[2]}"
  }) do
    it { is_expected.to be_satisfied_by '> 0' }
  end
  describe command('latexmk') do
    it { should exist }
  end
  describe command_output('latexmk --version', parsed_with: lambda { |stdout, _stderr|
    m = stdout.match(/^Latexmk.*Version (\d+\.\d+)(\w+)/)
    return "#{m[1]}.0-#{m[2]}"
  }) do
    it { is_expected.to be_satisfied_by '> 0' }
  end
  describe command('jadetex') do
    it { should exist }
  end
  describe command_output('jadetex --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^pdfTeX (\d+\.\d+)-(\d+\.\d+)-(\d+\.\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '> 0' }
  end

  describe command('flex') do
    it { should exist }
  end
  describe command_output('flex --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^flex(\.exe)?"? (\d+\.\d+\.\d+)/, 2]
  }) do
    it { is_expected.to be_satisfied_by '>= 2.5.31' }
  end
  describe command('bison') do
    it { should exist }
  end
  describe command_output('bison --version', parsed_with: lambda { |stdout, _stderr|
    return stdout[/^bison \(GNU Bison\) (\d+\.\d+\.\d+)/, 1]
  }) do
    it { is_expected.to be_satisfied_by '>= 2.2' }
  end

  describe command('xmllint') do
    it { should exist }
  end
  describe command('xmllint --version') do
    its('exit_status') { should eq 0 }
  end

  describe command('xsltproc') do
    it { should exist }
  end
  describe command('xsltproc --version') do
    its('exit_status') { should eq 0 }
  end

  describe os_env('IMCONV') do
    its('content') { should_not be_empty }
  end

  IMCONV = os_env('IMCONV').content
  unless IMCONV.to_s.empty?
    describe file(IMCONV.delete('"')) do
      it { should exist }
    end
    describe command("#{IMCONV} --version") do
      its('exit_status') { should eq 0 }
    end
  end
end

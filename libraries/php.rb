# frozen_string_literal: true

#
# Copyright:: 2016, Christoph Hartmann
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

class PHP < Inspec.resource(1)
  name 'php'

  example "
    describe php.config('max_execution_time') do
      it { should cmp 0 }
    end

    describe php.extension('tillext') do
    	it { should_not be_loaded }
    end

    describe php.extension('session') do
      it { should be_loaded }
    end
  "

  def initialize(options = {})
    super()
    @options = options
  end

  # returns php runtime information
  def info
    inspec.command("#{_php_executable} -i")
  end

  def config(param)
    cmd = inspec.command("#{_php_executable} -r 'echo get_cfg_var( \"#{param}\" );'")
    cmd.stdout
  end

  def extension(extension)
    ext = Class.new do
      def initialize(parent, extension)
        super
        @parent = parent
        @extension = extension
      end

      def loaded?
        cmd = @parent._run("#{@parent._php_executable} --ri '#{@extension}'")
        return true if cmd.exit_status.zero?

        false
      end

      def to_s
        "PHP Extension #{@extension}"
      end
    end
    ext.new(self, extension)
  end

  # internal methods

  def _php_executable
    cmd = 'php'
    cmd += " -c #{@options[:ini]}" if !@options.nil? && @options.key?(:ini)
    cmd
  end

  def _run(cmd)
    inspec.command(cmd)
  end
end

# Deprecated Serverspec resource
class PHPConfig < PHP
  name 'php_config'

  example "
    describe php_config('default_mimetype') do
      its('value') { should eq 'text/html' }
    end
  "

  def initialize(param)
    super()
    warn '[DEPRECATION] `php_config(param)` is deprecated.  Please use `php.config(param)` instead.'
    @param = param
  end

  def value
    config(@param)
  end

  def to_s
    "PHP Config #{@param}"
  end
end

# Deprecated Serverspec resource
class PHPExtension < PHP
  name 'php_extension'

  example "
    describe php_extension('tillext') do
    	  it { should_not be_loaded }
    end

    describe php_extension('session') do
      it { should be_loaded }
    end
  "

  def initialize(extension)
    super
    warn '[DEPRECATION] `php_extension(ext)` is deprecated.  Please use `php.extension(ext)` instead.'
    @extension = extension
  end

  def loaded?
    extension(@extension).loaded?
  end

  def to_s
    "PHP Extension #{@extension}"
  end
end

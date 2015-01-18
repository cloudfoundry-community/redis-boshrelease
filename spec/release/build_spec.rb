require 'spec_helper'

describe 'redis release' do
  before(:all) do
    unless File.exists?('config/dev.yml')
      File.open('config/dev.yml', 'w') do |f|
        f.puts("---\ndev_name: redis\n")
      end
    end
  end

  it 'should build' do
    output = %x{bosh create release --force}
    result = $?
    puts output unless result == 0
    expect(result).to eq 0
  end
end

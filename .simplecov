require 'simplecov-rcov'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails' do
  add_filter 'ruby_gems'
end

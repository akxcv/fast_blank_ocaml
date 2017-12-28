require 'benchmark/ips'
require 'fast_blank'
require_relative 'lib/cowcaml.rb'

class String
  def ocaml_blank?
    Cowcaml::Base.blank self
  end

  # active support implementation
  def slow_blank?
    /\A[[:space:]]*\z/ === self
  end

  def new_slow_blank?
    empty? || !(/[[:^space:]]/ === self)
  end
end

test_strings = [
  "",
  "\r\n\r\n  ",
  "this is a test",
  "   this is a longer test",
  "   this is a longer test
      this is a longer test
      this is a longer test
      this is a longer test
      this is a longer test"
]

test_strings.each do |s|
  raise "failed on #{s.inspect}" if s.ocaml_blank? != s.slow_blank?
  raise "failed on #{s.inspect}" if s.ocaml_blank? != s.new_slow_blank?
end

test_strings.each do |s|
  puts "\n================== Test String Length: #{s.length} =================="
  Benchmark.ips do |x|
    x.report("Fast Blank") do |times|
      i = 0
      while i < times
        s.blank?
        i += 1
      end
    end

    x.report("Fast ActiveSupport") do |times|
      i = 0
      while i < times
        s.blank_as?
        i += 1
      end
    end

    x.report("Slow Blank") do |times|
      i = 0
      while i < times
        s.slow_blank?
        i += 1
      end
    end

    x.report("New Slow Blank") do |times|
      i = 0
      while i < times
        s.new_slow_blank?
        i += 1
      end
    end

    x.report("OCaml Fast Blank") do |times|
      i = 0
      while i < times
        s.ocaml_blank?
        i += 1
      end
    end

    x.compare!
  end
end

__END__

================== Test String Length: 0 ==================
Warming up --------------------------------------
          Fast Blank   259.226k i/100ms
  Fast ActiveSupport   226.507k i/100ms
          Slow Blank    67.603k i/100ms
      New Slow Blank   259.002k i/100ms
    OCaml Fast Blank   186.906k i/100ms
Calculating -------------------------------------
          Fast Blank     20.637M (±15.6%) i/s -     99.284M in   5.013785s
  Fast ActiveSupport     21.001M (±14.2%) i/s -    101.702M in   5.007715s
          Slow Blank    802.420k (±20.7%) i/s -      3.718M in   5.001746s
      New Slow Blank     18.710M (±23.3%) i/s -     84.694M in   4.998752s
    OCaml Fast Blank      4.950M (±15.4%) i/s -     23.924M in   5.025812s

Comparison:
  Fast ActiveSupport: 21001105.8 i/s
          Fast Blank: 20637083.6 i/s - same-ish: difference falls within error
      New Slow Blank: 18710072.3 i/s - same-ish: difference falls within error
    OCaml Fast Blank:  4949668.0 i/s - 4.24x  slower
          Slow Blank:   802419.7 i/s - 26.17x  slower


================== Test String Length: 6 ==================
Warming up --------------------------------------
          Fast Blank   187.458k i/100ms
  Fast ActiveSupport   171.902k i/100ms
          Slow Blank    61.453k i/100ms
      New Slow Blank   102.474k i/100ms
    OCaml Fast Blank   163.372k i/100ms
Calculating -------------------------------------
          Fast Blank      9.151M (± 9.8%) i/s -     45.177M in   5.004625s
  Fast ActiveSupport     10.112M (± 6.9%) i/s -     50.367M in   5.010209s
          Slow Blank    922.222k (± 4.0%) i/s -      4.609M in   5.005885s
      New Slow Blank      1.741M (± 6.3%) i/s -      8.710M in   5.026138s
    OCaml Fast Blank      4.555M (±10.2%) i/s -     22.382M in   5.005977s

Comparison:
  Fast ActiveSupport: 10112422.2 i/s
          Fast Blank:  9150969.7 i/s - same-ish: difference falls within error
    OCaml Fast Blank:  4554510.1 i/s - 2.22x  slower
      New Slow Blank:  1741425.3 i/s - 5.81x  slower
          Slow Blank:   922222.1 i/s - 10.97x  slower


================== Test String Length: 14 ==================
Warming up --------------------------------------
          Fast Blank   249.490k i/100ms
  Fast ActiveSupport   248.312k i/100ms
          Slow Blank   125.931k i/100ms
      New Slow Blank    69.459k i/100ms
    OCaml Fast Blank   182.275k i/100ms
Calculating -------------------------------------
          Fast Blank     18.106M (± 6.8%) i/s -     90.315M in   5.015731s
  Fast ActiveSupport     16.674M (±19.7%) i/s -     77.225M in   5.006326s
          Slow Blank      2.104M (±15.7%) i/s -     10.200M in   5.041044s
      New Slow Blank    876.423k (±13.0%) i/s -      4.306M in   5.013083s
    OCaml Fast Blank      5.026M (±12.4%) i/s -     24.607M in   5.011347s

Comparison:
          Fast Blank: 18106150.8 i/s
  Fast ActiveSupport: 16673555.8 i/s - same-ish: difference falls within error
    OCaml Fast Blank:  5026177.7 i/s - 3.60x  slower
          Slow Blank:  2103665.1 i/s - 8.61x  slower
      New Slow Blank:   876422.6 i/s - 20.66x  slower


================== Test String Length: 24 ==================
Warming up --------------------------------------
          Fast Blank   221.182k i/100ms
  Fast ActiveSupport   222.870k i/100ms
          Slow Blank   111.589k i/100ms
      New Slow Blank    66.756k i/100ms
    OCaml Fast Blank   171.531k i/100ms
Calculating -------------------------------------
          Fast Blank     11.786M (± 5.3%) i/s -     58.834M in   5.007267s
  Fast ActiveSupport     11.704M (±14.7%) i/s -     56.386M in   5.011782s
          Slow Blank      1.984M (±10.0%) i/s -      9.820M in   5.049188s
      New Slow Blank    874.532k (± 8.3%) i/s -      4.339M in   5.001362s
    OCaml Fast Blank      4.967M (± 4.8%) i/s -     24.872M in   5.019823s

Comparison:
          Fast Blank: 11785709.1 i/s
  Fast ActiveSupport: 11704475.2 i/s - same-ish: difference falls within error
    OCaml Fast Blank:  4966928.5 i/s - 2.37x  slower
          Slow Blank:  1983904.0 i/s - 5.94x  slower
      New Slow Blank:   874532.3 i/s - 13.48x  slower


================== Test String Length: 136 ==================
Warming up --------------------------------------
          Fast Blank   210.768k i/100ms
  Fast ActiveSupport   193.088k i/100ms
          Slow Blank    77.595k i/100ms
      New Slow Blank    44.558k i/100ms
    OCaml Fast Blank   143.046k i/100ms
Calculating -------------------------------------
          Fast Blank     10.256M (±20.4%) i/s -     47.844M in   5.002855s
  Fast ActiveSupport     12.072M (±10.6%) i/s -     59.471M in   5.009553s
          Slow Blank      1.851M (±18.1%) i/s -      8.613M in   5.087665s
      New Slow Blank    849.400k (±14.3%) i/s -      4.144M in   5.036486s
    OCaml Fast Blank      3.387M (±13.7%) i/s -     16.593M in   5.024423s

Comparison:
  Fast ActiveSupport: 12071703.8 i/s
          Fast Blank: 10255565.3 i/s - same-ish: difference falls within error
    OCaml Fast Blank:  3387110.1 i/s - 3.56x  slower
          Slow Blank:  1850712.1 i/s - 6.52x  slower
      New Slow Blank:   849400.0 i/s - 14.21x  slower

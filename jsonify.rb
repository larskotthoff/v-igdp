#!/usr/bin/env ruby

require 'json'

disp = Hash.new
f = File.open("disparity.csv")
f.each { |l|
    v = l.chomp.split(/,/)
    disp[v[0]] = v[1].to_f
}

data = JSON.parse(STDIN.read)

data["features"].delete_if { |f|
    not disp.has_key?(f["p"]["n"])
}

data["features"].each { |f|
    f["p"]["d"] = 1 - (disp[f["p"]["n"]]/100)
}

puts data.to_json

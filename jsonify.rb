#!/usr/bin/env ruby

require 'json'

disp = Hash.new
f = File.open("disparity.csv")
f.each { |l|
    v = l.chomp.split(/,/)
    disp[v[0]] = v[1].to_f
}

data = JSON.parse(STDIN.read)

data["features"].each { |f|
    if disp.has_key?(f["p"]["n"])
        f["p"]["d"] = 1 - (disp[f["p"]["n"]]/100)
    end
}

puts data.to_json

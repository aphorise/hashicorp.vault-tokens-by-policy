#!/usr/bin/env ruby
# // This scripts checks accessor tokens for polict affilation
# // grouping each unique policy series in an array and count 
# // the same type of tokens and listen a count at the end.
# // for more details see: https://github.com/hashicorp/vault-ruby/blob/master/lib/vault/api/auth_token.rb

require 'vault';

tSTART = Time.now;  # // START TIME FOR MEASURING SPEED
puts "Running Ruby: #{__FILE__}\n\n";

# // Vault API URL:
Vault.address = "http://192.168.178.201:8200";  # Also reads from ENV["VAULT_ADDR"] if not set.
Vault.token   = "root";
Vault.ssl_verify = false;

VPOLICIES = [];

rAccessors = Vault.auth_token.accessors;

# pp rAccessors.data[:keys]
iVTOTAL = rAccessors.data[:keys].length;

for aAccessor in rAccessors.data[:keys]
    rAccessor_Lookup = Vault.auth_token.lookup_accessor(aAccessor.to_s);
#    pp rAccessor_Lookup; # puts rAccessor_Lookup.data[:policies].to_s;
    if ! VPOLICIES.include?(rAccessor_Lookup.data[:policies].to_s)
        VPOLICIES.push(rAccessor_Lookup.data[:policies], 1)
    else
        iPOS = VPOLICIES.index(rAccessor_Lookup.data[:policies].to_s)
        puts "iPOS == #{iPOS}";
        VPOLICIES[iPOS+1] += 1
    end ;
end;

if VPOLICIES.length > 0 then puts "TOKEN POLICY COUNTS:" ; end ;

(1..VPOLICIES.length).step(2) do |iX|
  puts "#{VPOLICIES[iX-1]}: #{VPOLICIES[iX]}";
end

puts "\nINSPECTED: #{iVTOTAL} total accessor tokens.\n\n";

tEND = Time.now;
tDIFF = (tEND - tSTART);
puts "Ruby ACCESSOR TOKENS POLICY CHECKS TOOK: #{tDIFF} seconds to complete.";

module Autofold
  class Commander < Thor

    class << self
      def source_root
        File.expand_path("../templates", __FILE__)
      end
    end

    desc "version", "Autofold version"
    def version
      say Autofold::Version
    end

    desc "scaffold [NAMES]", "scaffolds out a resource vertical."
    long_desc <<-LONGDESC
      Scaffolds out a vertical resourceful gem with the given <name> in your current dir.
      Separate names of resources by ":", "()", and "+" characters.

      It will also attempt to create a spec testing folder for you with a mirrored structure

      Examples:
      scaffold negotiation:(discussion:(offer+message)+transaction:(checkout+payment))
      creates the following folder directory. 

      negotiation.rb
      negotiation
      |- record.rb
      |- controller.rb
      |- discussion.rb
      |- discussion
        |- record.rb
        |- controller.rb
        |- offer.rb
        |- offer
          |- record.rb
          |- controller.rb
        |- message.rb
        |- message
          |- record.rb
          |- controller.rb
      |- transaction.rb
      |- transaction
        |- record.rb
        |- controller.rb
        |- checkout.rb
        |- checkout
          |- record.rb
          |- controller.rb
        |- payment.rb
        |- payment
          |- record.rb
          |- controller.rb 
    LONGDESC
    def scaffold(names)
      Scaffold.scaffold(names)
      _create_file_tree _parse_to_expanded_names names
    end

    private
    # takes a string and expands it out to [{}]s
    
  end
end
require_relative "commander/scaffold"
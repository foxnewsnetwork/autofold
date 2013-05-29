module Autofold
  class Commander < Thor

    desc "version", "Autofold version"
    def version
      say Autofold::Version
    end

    desc "scaffold [PROJECT] [NAMES]", "scaffolds out a resource vertical."
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
    def scaffold(project_name, names)
      BaseBuilder.from_project_name project_name
      Scaffold.parse_to_simple_array(names).each do |things|
        _twoify(things).each do |thing|
          CoreBuilder.from_absolute_path(File.expand_path(project_name, Dir.pwd)).call *thing
        end
      end
    end

    private
    # takes [s1,s2,s3...] and splits it into [[s1,s2], [s2,s3], [s3,s4]...]
    def _twoify(array)
      array.zip(array[1..-1]).reject { |a| a.last.nil? }
    end
  end
end
require_relative "commander/scaffold"
require_relative "commander/base_builder"
require_relative "commander/core_builder"
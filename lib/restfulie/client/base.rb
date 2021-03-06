module Restfulie
  module Client#:nodoc
    module Base
      
      def method_missing(sym, *args, &block)
        if @base_position.respond_to?(sym)
          @base_position.send sym, *args, &block
        else
          super(sym, *args, &block)
        end
      end
     
      def self.included(base)#:nodoc
        base.extend(self)
      end
  
      def uses_restfulie(configuration = Configuration.new,&block)
        EntryPoint.configuration_for(resource_name,configuration,&block)
        configure
      end
  
      def configure
        configuration = EntryPoint.configuration_of(resource_name)
        raise "Undefined configuration for #{resource_name}" unless configuration
        @base_position = Restfulie.at(configuration.entry_point)
        configuration.representations.each do |representation_name,representation|
          register_representation(representation_name,representation)
        end
      end
  
      def resource_name
        @resource_name ||= self.class.to_s.to_sym 
      end
    end
  end
end

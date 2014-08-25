=begin
    Copyright 2010-2014 Tasos Laskos <tasos.laskos@gmail.com>
    Please see the LICENSE file at the root directory of the project.
=end

module Arachni
module Component

# Includes some useful methods for the components.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@gmail.com>
module Utilities
    include Arachni::Utilities

    # @param    [String]    filename
    #   Filename, without the path.
    # @param    [Block]     block
    #   The block to be passed each line as it's read.
    def read_file( filename, &block )
        component_path = block_given? ?
            block.source_location.first : caller_path(1)

        # The name of the component that called us.
        component_name = File.basename( component_path, '.rb' )

        # The path to the component's data file directory.
        path  = File.expand_path( File.dirname( component_path ) ) +
            "/#{component_name}/"

        File.open( "#{path}/#{filename}" ) do |file|
            if block_given?
                # I really hope that ruby frees each line as soon as possible
                # otherwise this provides no advantage
                file.each { |line| yield line.strip }
            else
                file.read.lines.map { |l| l.strip }
            end
        end
    end

    extend self

end

end
end
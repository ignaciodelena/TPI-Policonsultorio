module Polycon
  module Commands
    module Professionals
      require 'fileutils'
      HOME = Dir.home 
      FileUtils.mkdir_p(HOME+"/.polycon") unless  File.exists?(HOME+"/.polycon") 
      
      class Create < Dry::CLI::Command
        

        desc 'Create a professional'

        argument :name, required: true, desc: 'Full name of the professional'

        example [
          '"Alma Estevez"      # Creates a new professional named "Alma Estevez"',
          '"Ernesto Fernandez" # Creates a new professional named "Ernesto Fernandez"'
        ]

        def call(name:string)
          
          FileUtils.mkdir_p(HOME+"/.polycon/#{name}") unless  File.exists?(HOME+"/.polycon/#{name}") 
          
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a professional (only if they have no appointments)'

        argument :name, required: true, desc: 'Name of the professional'

        example [
          '"Alma Estevez"      # Deletes a new professional named "Alma Estevez" if they have no appointments',
          '"Ernesto Fernandez" # Deletes a new professional named "Ernesto Fernandez" if they have no appointments'
        ]

        def call(name: nil)
          
          FileUtils.remove_dir(HOME+"/.polycon/#{name}") if File.directory?(HOME+"/.polycon/#{name}")
         
        end
      end

      class List < Dry::CLI::Command
        desc 'List professionals'

        example [
          "          # Lists every professional's name"
        ]

        def call(*)
          puts HOME
          Dir.foreach(HOME+"/.polycon") do |item| next if item == '.' or item == '..'
            puts item
          end
          
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a professional'

        argument :old_name, required: true, desc: 'Current name of the professional'
        argument :new_name, required: true, desc: 'New name for the professional'

        example [
          '"Alna Esevez" "Alma Estevez" # Renames the professional "Alna Esevez" to "Alma Estevez"',
        ]

        def call(old_name:string, new_name:string, **)
          File.rename HOME+"/.polycon/#{old_name}", HOME+"/.polycon/#{new_name}"
          
        end
      end
    end
  end
end

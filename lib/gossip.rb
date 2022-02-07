require 'csv'

class Gossip

    attr_accessor :content, :author, :id
    @@all_gossips =[]

    def initialize(author, content)
        @content = content
        @author = author
    end
    
    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << [@author, @content]
        end
    end

    def self.all
        CSV.read("./db/gossip.csv").each do |csv_line|
            @@all_gossips << Gossip.new(csv_line[0], csv_line[1])
          end
          return @@all_gossips
    end

    def self.find(id)
        CSV.foreach("./db/gossip.csv").with_index do |csv_line, index|
            if (index + 1) == (id).to_i
                return csv_line
            end
        end
    end

    def self.modification(id, author, content)
        array_modif = []
        CSV.read("./db/gossip.csv").each_with_index do |row, index|
            if (id).to_i == (index + 1)
                array_modif << [author, content]
            else 
                array_modif << [row[0],row[1]]
            end
        end
        CSV.open("./db/gossip.csv", "w") do |csv| 
                array_modif.each do |row|
                csv << row
                end
            end
    end
end

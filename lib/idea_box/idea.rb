require 'date'
class Idea
  include Comparable
  attr_reader :title, :description, :rank, :id, :time, :tag

  def initialize(attributes)
     @title       = attributes["title"]
     @description = attributes["description"]
     @rank = attributes["rank"] || 0
     @id   = attributes["id"]
     @time = attributes["time"]
     @tag = attributes["tag"] 
  end

  def database
    Idea.database
  end

  def save
    IdeaStore.create(to_h)
  end

  def to_h
    {
      "title" => title,
      "description" => description,
      "rank" => rank,
      "time" => time,
      "tag"  => tag
    }
  end

  def like!
    @rank += 1
  end

  def <=>(other)
    other.rank <=> rank
  end
end

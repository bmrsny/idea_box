require 'yaml/store'

class IdeaStore
  def self.all
    raw_ideas.map.with_index do |data, i|
      Idea.new(data.merge("id" => i))
    end
  end

  def self.filter(tag)
    all.select do |entry|
      entry.tag == tag
    end
  end

  def self.delete(position)
    database.transaction do
      database['ideas'].delete_at(position)
    end
  end

  def self.find(id)
    raw_idea = find_raw_idea(id)
    Idea.new(raw_idea.merge('id' => id))
  end

  def self.raw_ideas
    database.transaction do |db|
      db['ideas'] || []
    end
  end

  def self.database
    return @database if @database
    #add some logic for testing
    @database ||= YAML::Store.new ("db/ideabox")
    @database.transaction do
      @database['ideas'] ||= []
    end
    @database
  end

  def self.update(id, data)
    database.transaction do
      database['ideas'][id] = data
    end
  end

  def self.find_raw_idea(id)
    database.transaction do
      database['ideas'].at(id)
    end
  end

  def self.create(data, time)
    database.transaction do
      database['ideas'] << data.merge('time' => time)
    end
  end
end

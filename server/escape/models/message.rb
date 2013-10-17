class Escape::Models::Message < ActiveRecord::Base

  KIND_NORMAL = 0
  KIND_EMOTE = 1

  validate :content, length: { in: 1..140 }
  belongs_to :author, class_name: 'Char'
  belongs_to :receiver, class_name: 'Char'

  def self.say(author, content)
    create(author: author, content: content, kind: KIND_NORMAL)
  end

  def self.whisper(author, receiver, content)
    create(author: author, receiver: receiver, content: content, kind: KIND_NORMAL)
  end

  def self.emote(author, content)
    create(author: author, content: content, kind: KIND_EMOTE)
  end

  def self.unheard_for(char, since)
    where("author_id = :char_id or receiver_id = :char_id or receiver_id is null",
          char_id: char.id)
    .where("created_at > ?", since)
    .order("created_at asc")
    .map(&:to_s)
  end

  def to_s
    msg = if kind == KIND_NORMAL
      "[#{author.name}]"
    else
      "* #{author.name}"
    end
    if receiver
      msg << " -> [#{receiver.name}]"
    end
    msg << " #{content}"
    msg
  end
end

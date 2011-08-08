module Todotxt
  class Todo

    attr_accessor :text
    attr_accessor :line
    attr_accessor :priority
    attr_accessor :projects
    attr_accessor :contexts
    attr_accessor :done

    def initialize text, line=nil
      @text = text
      @line = line
      @priority = text.scan(PRIORITY_REGEX).flatten.first || nil
      @projects = text.scan(PROJECT_REGEX).flatten.uniq   || []
      @contexts = text.scan(CONTEXT_REGEX).flatten.uniq   || []
      @done = !text.scan(DONE_REGEX).empty?
    end

    def do
      unless done
        @text = "x #{text}"
        @done = true
      end
    end

    def undo
      if done
        @text = text.sub(DONE_REGEX, "")
        @done = false
      end
    end

    def to_s
      text
    end

    def <=> b
      if priority.nil? && b.priority.nil?
        return line <=> b.line
      end

      return 1 if priority.nil?
      return -1 if b.priority.nil?

      return priority <=> b.priority
    end

  end
end
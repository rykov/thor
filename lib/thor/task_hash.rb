require 'thor/ordered_hash'
require 'thor/task'

class Thor::TaskHash < Thor::OrderedHash
  def initialize(klass)
    super()
    @klass = klass
  end

  def each(local = false, &block)
    super(&block)
    @klass.superclass.tasks.each(&block) unless local || @klass == Thor
  end

  def [](name)
    if task = super(name)
      return task.with_klass(@klass)
    end

    Thor::Task.dynamic(name, @klass)
  end
end
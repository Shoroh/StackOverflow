class KarmaObserver < ActiveRecord::Observer
  observe :question, :answer, :vote

  def after_create(record)
    Karma.new(record: record).increase
  end

  def after_destroy(record)
    Karma.new(record: record).decrease
  end

end

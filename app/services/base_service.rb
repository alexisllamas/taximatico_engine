class BaseService
  def self.call(*args)
    new(*args).perform
  end
end

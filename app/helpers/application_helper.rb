module ApplicationHelper
  def vacuum
    @vacuum ||= load_vacuum_client
  end

  def load_vacuum_client
    request = Vacuum.new
    request.configure(aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"], aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"], associate_tag: ENV["AWS_ASSOCIATE_TAG"])
    request
  end
end

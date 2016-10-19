module ApplicationHelper
  def vacuum
    @vacuum ||= load_vacuum_client
  end

  def load_vacuum_client
    request = Vacuum.new
    request.configure(aws_access_key_id: Rails.configuration.amazon['aws_access_key_id'],
                      aws_secret_access_key: Rails.configuration.amazon['aws_secret_access_key'],
                      associate_tag: Rails.configuration.amazon['associate_tag'])
    request
  end
end
